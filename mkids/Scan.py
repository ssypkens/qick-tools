import matplotlib.pyplot as plt
import copy,os,sys,time
import numpy as np
from numpy.polynomial.polynomial import Polynomial
from tqdm.notebook import trange, tqdm
from scipy.interpolate import interp1d
"""
The firmware chooses which input channels to read out.


The number of input channels is soc.nInCh and for the ZCU111 this is 4096.  Which channel to read out is defined by an address and a bit.  This points to a set of 8 input channels.

For the ZCU111 these numbers are:
    number of addresses = 16
    number of bits = 32
    This yields the same number of channels, 16*32*8 = 4096.16
"""

class Scan():
    
    def __init__(self, soc):
        """ initialize with the already loaded TopSoc"""
        self.soc = soc

    def setTones(self, freqsRequested, amplitudes, fis, pfbOutQout=0, verbose=False):
        """
        Generate tones near the requested frequencies, so they can be demodulated back to DC.  Note that the mixer frequency needs to be set before calling this function.
        
            Parameters
            ----------
            freqsRequested : ndarray
                1d array of requested frequencies in MHz
            amplitudes: ndarray
                1d array of amplitudes, in the range [0,1).  Note that no checks are made to ensure the resulting data are in range.
            fis : ndarray
                1d array of phases, in radians
            pdbOutQout : int
                default 0
            verbose : boolean
                default False, use "True" to print information to stdout

            Returns
            -------
                None
            
            Sets
            ----
                self.toneFreqs -- the actual frequencies set
                self.toneAmplitudes and .toneFis, copies from input
                
                uses calls to soc. functions to generate the tones

        """
        # pdbOutQout:  0 for max output power, larger values give finer control
        self.soc.dds_out.alloff()
        self.toneFreqsRequested = freqsRequested
        freqs = self.soc.DF*np.round(freqsRequested/self.soc.DF)
        pfb_chs, dds_freqs, _, unwrapped_chs = self.soc.pfb_out.freq2ch(freqs, self.soc.pfb_out.get_fmix())
        if verbose:
            for i in range(len(freqs)):
                print("i, freqs[i], pfb_chs[i], dds_freqs[i], unwarpped_chs[i]",
                     i, freqs[i], pfb_chs[i], dds_freqs[i], unwrapped_chs[i])
        if len(set(pfb_chs)) != len(pfb_chs):
            raise ValueError("Output tones map to PFB channels %s, which are not unique"%(str(pfb_chs)))        
        for ch, fdds, amplitude, unwrapped_ch, fiDeg in zip(pfb_chs, dds_freqs, amplitudes, unwrapped_chs, np.rad2deg(fis)):
            if verbose: 
                print("Scan.setTones: ",ch,fdds,amplitude,unwrapped_ch,fiDeg)
            self.soc.dds_out.ddscfg(ch=ch, f=fdds, g=amplitude, fi=fiDeg)
        self.outChs = pfb_chs
        self.outDds = dds_freqs
        self.soc.pfb_out.qout(pfbOutQout)
        self.toneFreqs = freqs
        self.toneAmplitudes = amplitudes
        self.toneFis = fis
        
    def prepRead(self, decimation, pfbInQout=8, verbose=False, debugChselSet=False):
        """
        Prepare to read out tones generated by setTones
            Parameters
            ----------
            decimation : int
                decimation in readout, in the range [2,250]
            pdbInQout : int
                quantization level, use default of 8
            verbose : boolean
                default False, use "True" to print information to stdout
            debuaChselSet: boolean
                default False, use "True" to print information to stdout

            Returns
            -------
                None
            
            Sets
            ----
                self.ntranByTone -- the transaction number for each tone
                self.streamByTone -- the stream number for each tone
                
                uses calls to soc. functions to set the input frequency to demodulate tones to DC, and select data
                to transfer

        """
        if verbose:
            print("in Scan.py prepRead:  self.toneFreqs=",self.toneFreqs)
        self.inChs,self.inOffsets = self.soc.inFreq2chOffset(self.toneFreqs)
        self.soc.pfb_in.qout(pfbInQout)
        self.soc.ddscic.decimation(value=decimation)
        self.soc.ddscic.dds_outsel(outsel="product")
        for i in range(len(self.toneFreqs)):
            self.soc.ddscic.set_ddsfreq(ch_id=self.inChs[i], f=self.inOffsets[i])
            if verbose:
                print("Scan.prepRead: i, ch_id, dds_freq =",i, self.inChs[i], self.inOffset[i])
        _,_ = self.soc.chsel.set(self.inChs, debug=debugChselSet)
        self.ntranByTone, self.streamByTone = self.soc.inFreq2NtranStream(self.toneFreqs)
        if verbose:
            print("self.ntranByTone =",self.ntranByTone)
            print("self.streamByTone =",self.streamByTone)

    
    def readAndUnpack(self,  nt=1, nsamp=10000,
                      average=False, subtractInputPhase=True, iBegin=0,
                      debugTransfer=False, unpackVerbose=False):
        self.packets = self.soc.stream.transfer(nt=nt, nsamp=nsamp, debug=debugTransfer)
        return self.unpack(unpackVerbose, average, subtractInputPhase=subtractInputPhase, iBegin=iBegin)
        """
        read and unpack data for the tones
            Parameters
            ----------
            nt : int
                number of transfers, >=1, but not too big
            nsamp : int
                number of samples
            average : boolean
                whether to average the samples
            subtractInputPhase: boolean
                use default of True to subtract the phase of the generated tone; default False
            iBegin : int
                number of samples to truncate from the beginning of the stream; default 0
            debugTransfer : boolean
                use True to print information to stdout; default False
            unpackVerbose : boolean
                use True to print information to stdout; default False
       
           Returns
           -------
               the results of the call to the unpack function
        
        """
    
    def unpack(self, verbose, average, subtractInputPhase=True, iBegin=0):
        """
        unpack the packets
        Parameters
        ----------
            verbose : boolean
                True to print information to stdout; default False
            average : boolean
                True to report average of the samples
            subtractInputPhase : boolean
                True to subtract the phase of the generated tone; default True
            iBegin : int
                sample number to begin using; default 0
        Returns
        -------
            xs : complex values
            
            The first index indicates the transfer number, of the nt transfers used in the call to readAndUnpack.  The second index is to the tone.
            If average is False, this is a list of lists of ndarrays of complex values.    The ndarray of complex values does not always have the same number of samples, hence the need for a list of lists.
            
            If average is True, this is a 2D array of the average complex value of the samples.
        """
        if verbose: print("self.packets.shape =",self.packets.shape)
        packets = self.packets[:, iBegin:, :]
        if verbose: print("     packets.shape =",packets.shape)
        ntrans = packets[:,:,16]
        if verbose: print("      ntrans.shape =",ntrans.shape)
        xis = packets[:,:,0:16:2]
        if verbose: print("         xis.shape =",xis.shape)
        xqs = packets[:,:,1:17:2]
        if verbose: print("         xqs.shape =",xqs.shape)
        xs = xis + 1j*xqs
        if verbose: print("          xs.shape =",xs.shape)
        xsByNtTone = []
        nt = xs.shape[0]
        nTone = len(self.ntranByTone)
        for it in range(nt):
            xsByTone = []
            for iTone,(ntran,stream) in enumerate(zip(self.ntranByTone,self.streamByTone)):
                temp = xs[it, ntrans[it]==ntran, stream]
                if verbose: print("   nt, iTone , x.shape", it, iTone, temp.shape)

                if subtractInputPhase:
                    temp = self._subtractInputPhase(temp, self.toneFis[iTone])

                xsByTone.append(temp)
            xsByNtTone.append(xsByTone)
        if average:
            retval = np.zeros((nt,nTone), dtype=complex)
            for it in range(nt):
                for iTone in range(nTone):
                    retval[it,iTone] =  xsByNtTone[it][iTone].mean()
            retval = retval.mean(axis=0)
        else:
            retval = xsByNtTone
        return retval

    def _subtractInputPhase(self, x, toneFi):
        """
        Return values with phase of x reducted by toneFi in radians
        """
        xrot = np.abs(x)*np.exp(1j * (np.angle(x)-toneFi))
        return xrot

    def fscan(self, freqs, amps, fis, 
              bandwidth, nf, decimation, nt, iBegin=200, nsamp=10000,
              pfbOutQout=0, verbose=False, doProgress=False,
              retainPackets = False, subtractInputPhase=True):
        """
        Perform a frequncy scan around the frequencies.  Note that this is NOT done by changing mixer settings, but rather, by changing the frequencies of the tones.
        
        Parameters
        ----------
            freqs : ndarray
                1d array of central frequencies (MHz)
            amps : ndarray
                1d array of amplitudes, in [0,1), where you need to make sure the sum of all tones does not saturate the output
            fis : ndarray
                1d array of phases
            bandwidth : float
                width of the scan, in MHz
            nf : int
                number of frequencies to measure in the bandwidth
            decimation : int
                input ADC decimation factor, in [2,250]
            nt : int
                number of transfers at each measurement
            iBegin : int
                number of samples to skip at the beginning of each transfer; default=200
            nsamp : int
                number of samples for each transfer; default 10000
            pdbOutQOut :int
                pfbOut resolution, use default=0
            verbose : boolean
                True to print some information to stdout
            doProgress : boolean
                True to iterate using tdqm to show a nifty progress bar in jupyter notebook
            retainPackets : boolean
                True to save copies of all packets during a scan, used in development and debugging; default=False
            subtracInputPhase : boolean
                True to subtract phase of the generated tone; default=True
        Returns:
        -------
            A dictionary with the following keys:
 
                fMixer": double
                        the mixer setting used during the scan (in MHz)
                freqs: ndarray 
                        1D array of central frequencies
                amps : ndarray 
                        1D array of amplitudes of generated tones,
                dfs: ndarray 
                        1D array of the frequency offsets for the scan (in Mhz)
                xs: ndarray 
                        2D array of the mean complex values measured.  First index is for each transfer at a frequency, second index is for each tone.

        Sets:
        -----
            if retainPackets is True, set .retainedPackets to a list of packets read during the scan
            
        """
        dfs = np.linspace(-bandwidth/2, bandwidth/2, num=nf)
        xs = np.zeros((nf, len(freqs)), dtype=complex)
        if retainPackets:
            self.retainedPackets = []
        if doProgress:
            iValues = trange(len(dfs))
        else:
            iValues = range(len(dfs))

        for i in iValues:
            df = dfs[i]
            self.setTones(df+freqs, amps, fis)
            self.prepRead(decimation)
            x = self.readAndUnpack(nt, nsamp, average=True,
                                   subtractInputPhase=subtractInputPhase,
                                   iBegin=iBegin)
            if retainPackets:
                self.retainedPackets.append(self.packets)
            xs[i] =  x  
        return {
                "fMixer": self.soc.get_mixer(),
                "freqs":freqs,
                "amps": amps,
                "dfs": dfs,
                "xs": xs
               }
    
    def makeFList(self, fMixer, fMin, fMax):
        """
        For a frequency range, make a list of frequencies at boundaries where the measure complex values are discontinuous

        Parameters:
        -----------
            fMixer : double 
                mixer frequency in MHz
            fMin : double 
                minimum frequency of the range (in MHz)
            fMax : double
                maximum frequency of the range (in MHz)

        Returns:
        --------
            fList : ndarray
                1D arrray of floats, frequencies that define the relevant ranges (in MHz)
        """
        self.soc.set_mixer(fMixer)
        fList = []
        # Add boundaries of input channels to fList
        
        freq = self.soc.inCh2FreqCenter(self.soc.inFreq2ch(fMin)) -  self.soc.fcIn/2
        fEnd = self.soc.inCh2FreqCenter(self.soc.inFreq2ch(fMax)) +  self.soc.fcIn/2
        while True:
            fList.append(freq)
            freq += self.soc.fcIn
            if freq >= fEnd: 
                fList.append(freq)
                break

        freq = self.soc.outCh2FreqCenter(self.soc.outFreq2ch(fMin)) -  self.soc.fcOut/2
        fEnd = self.soc.outCh2FreqCenter(self.soc.outFreq2ch(fMax)) +  self.soc.fcOut/2
        while True:
            fList.append(freq)
            freq += self.soc.fcOut
            if freq >= fEnd: 
                fList.append(freq)
                break

        fList = np.sort(np.unique(np.array(fList)))
        i0 = max(0, np.searchsorted(fList, fMin)-1)
        i1 = np.searchsorted(fList, fMax)+1
        return fList[i0:i1]
    
    def makeCalibration(self, fMixer, fMin, fMax, nf=100, nt=10, 
                        decimation=2, pfbOutQout=0, verbose=False,
                       randSeed=1234991, iBegin=500, doProgress=True,
                       nsamp=10000, nominalDelay=None):
        """
        For the frequency range, measure I,Q values and prepare for interpolation
        
        Parameters:
        -----------
            fMixer : double
                mixer setting, in MHz
            fMin : double 
                minimum frequency of the range (in MHz)
            fMax : double
                maximum frequency of the range (in MHz)
            nf : int
                number of frequencies to measure in each PFB bin
            nt : int
                number of transfers at each frequency
            decimation : int
                ADC decimation, in [2,250]; default=2
            pfbOutQout : int
                pfb resolution, use default of 0
            verbose : boolean
                If True, print information to stdout; default=False
            randSeed : int
                Seed for generating random phases; default=1234991
            iBegin : int
                Starting sample for each transfer; default=500
            doProgress : boolean
                True to iterate using tdqm to show a nifty progress bar in jupyter notebook; default=True    
            nsamp : int
                Number of samples for each transfer; default=10000
            nominalDelay : int
                Delay to use.  Default=None applies no phase correction due to delay
                
        """
        fcMax = max(self.soc.fcIn, self.soc.fcOut)
        fcMin = min(self.soc.fcIn, self.soc.fcOut)
        fMinCentered = self.soc.outCh2FreqCenter(self.soc.outFreq2ch(fMin))
        fMaxCentered = self.soc.outCh2FreqCenter(self.soc.outFreq2ch(fMax))
        freqs =  np.arange(fMinCentered-fcMax, fMaxCentered+fcMax, self.soc.fcOut)
        if verbose: print("Scan.makeCalibration:  len(freqs) =",len(freqs))
        amps = np.ones(len(freqs))*0.9/len(freqs)
        np.random.seed(randSeed)
        fis = np.random.uniform(0, 2*np.pi, len(freqs))
        bandwidth = self.soc.fcOut * (1-1/nf) 
        fscan = self.fscan(freqs, amps, fis, 
                           bandwidth, nf, decimation, 
                           nt, iBegin, nsamp,
                           pfbOutQout, verbose=verbose, doProgress=doProgress)
        if nominalDelay is not None:
            applyDelay(fscan, nominalDelay)
        fList = self.makeFList(fMixer, fMin, fMax)
        sFreqs, fAmps, sFis = fscanToSpectrum(fscan)
        sxs = fAmps*np.exp(1j*sFis)
        cInterps = []
        for i in range(len(fList)-1):
            f0 = fList[i]
            f1 = fList[i+1]
            inds = (f0 < sFreqs) & (sFreqs < f1)
            interp = interp1d(sFreqs[inds], sxs[inds], bounds_error=False, fill_value="extrapolate")
            cInterps.append(interp)
        calib = {"fMixer":fMixer, "fList":fList, "cInterps":cInterps, 
                 "fMin":fMin, "fMax":fMax, "fscan":fscan, "nominalDelay":nominalDelay} 
        return calib
    
    def measureNominalDelay(self, outCh, nf=20, nt=1, doProgress=False, doPlot=False, decimation=32, iBegin=500, pfbOutQout=0, nsamp=10000):
        """
        Measure the nominal delay between the input and ouput DDS
        
        Parameters:
        -----------
            outCh : int
                the output channel to use for this measurement
            nf : int
                the number of phase measurements to make; default=20
            nt : int
                the number of transfers per phase measurement; default=1
            doProgress : boolean
                True to iterate using tdqm to show a nifty progress bar in jupyter notebook; default=True     
            doPlot : boolean
                True to show a plot of phase vs. frequency and the fit; default=False
            decimation : int
                input ADC decimation factor; default=32
            iBegin : int
                begin sample to use each transfer; default=500
            pfbOutQOut : int
                pfb resolution, use default=0
                
        Returns:
        --------
           the measured delay, in micro seconds 
               
        """
        freqs = np.array([self.soc.outCh2FreqCenter(outCh)])
        amps = np.array([0.9])
        fis = np.array([0.0])
        bandwidth = self.soc.fcOut / 100
        self.mndScan = self.fscan(freqs, amps, fis, 
                                  bandwidth, nf, decimation, nt,
                      iBegin, nsamp, pfbOutQout, doProgress=doProgress)
       
        iTone = 0
        dfs = self.mndScan['dfs']
        fis = np.angle(self.mndScan['xs'][:,iTone])
        ufis = _unwrapPhis(fis)
        fit = Polynomial.fit(dfs, ufis, 1)
        nominalDelay = fit.convert().coef[1]
        if doPlot:
                #plt.plot(dfs,fis, ".-")
                fig,ax = plt.subplots(2,1,sharex=True)
                ax[0].plot(dfs, ufis, ".",label="data")
                ax[0].plot(dfs, fit(dfs), label="fit")
                ax[0].set_ylabel("unwrapped phase [Radians]")
                ax[0].legend()
                ax[1].plot(dfs, ufis-fit(dfs),'.')
                ax[1].set_ylabel("fit residual [Radians]")
                ax[1].set_xlabel("f offset in out channel")
                plt.suptitle("outCh=%d DDSDelay = %f $\mu$sec"%(outCh,nominalDelay))
        return nominalDelay

def applyCalibration(fscan, calibration, amplitudeMax=30000):
    """
    Apply the calibration to the frequency scan
    
    Parameters:
    -----------
        fscan : object
            returned from the function fscan.
        calibration : object
            returned from the function makeCalibration
        amplitudeMax : float
            amplitude of measurement when amplitudes of fscan and calibration are equal
            
    Returns:
    --------
        a deep copy of fscan with the calibration applied.
    """
    fscanCalib = copy.deepcopy(fscan)
    nominalDelay = calibration['nominalDelay']
    applyDelay(fscanCalib, nominalDelay)
    if nominalDelay != fscanCalib['delayApplied']:
        raise ValueError("fscan already had a delay applied", nominalDelay, fscanCalib['delayApplied'])
    dfs = fscanCalib['dfs']
    for iTone,(freq,xs) in enumerate(zip(fscanCalib['freqs'],fscanCalib['xs'])):
        freqs = freq+dfs
        xCalib = np.zeros(len(freqs), dtype=complex)
        for i, freq in enumerate(freqs):
            iCalib = np.searchsorted(calibration['fList'], freq)-1 
            xCalib[i] = calibration['cInterps'][iCalib](freq)
        gain = amplitudeMax/np.abs(xCalib)
        fscanCalib['xs'][:,iTone] *= gain
        dfi = np.angle(xCalib)
        xs = fscanCalib['xs'][:,iTone]
        fscanCalib['xs'][:,iTone] = np.abs(xs)*np.exp(1j*(np.angle(xs)-dfi))
    return fscanCalib                                                     


def fscanPlot(fscan, iTone):
    """
    plot the amplitude and phase near one tone of the scan
    
    Parameters:
    -----------
        fscan : object
            returned from the function fscan.
        iTone : int
            the tone in the fscan
            
    """
    dfs = fscan["dfs"]
    xs = fscan['xs'][:,iTone]
    fig,ax = plt.subplots(2,1,sharex=True)
    ax[0].plot(dfs, np.abs(xs), '-o')
    ax[0].set_ylabel("amplitude [ADUs]")
    ax[1].plot(dfs, np.angle(xs), '-o')
    ax[1].set_ylabel("phase [Radians]")
    ax[1].set_xlabel("Frequency-%f [MHz]"%fscan["freqs"][iTone])
    
def fscanToSpectrum(fscan):
    """
    arrange values from fscan to a spectrum
    
    Parameters:
    -----------
        fscan : object
            return value from function fscan
    
    Return:
    -------
        retval : tuple
        where the three values are 1D ndarrays of frequency, amplitude, phase

    """
    dfs = fscan['dfs']
    freqs = fscan['freqs']
    allfreqs = np.zeros((len(freqs),len(dfs)))
    for i,fTone in enumerate(freqs):
        allfreqs[i,:] = freqs[i]+dfs
    allfreqs = allfreqs.ravel()
    xs = np.transpose(fscan['xs'])
    allamps = np.abs(xs).ravel()
    allfis = np.angle(xs).ravel()
    inds = np.argsort(allfreqs)
    return allfreqs[inds], allamps[inds], allfis[inds]
   
def applyDelay(fscan, delay):
    """
    apply the delay to the phases
    
    Parameters:
    -----------
        fscan : object
            returned from the function fscan.
        delay : float
            time delay between DDS blocks, in microseconds, usually calculate by the function measureNominalDelay
            
    Return:
    -------
        None, as the fscan object is updated in place
    """
    try:
        fscan['delayApplied'] += delay
    except KeyError:
        fscan['delayApplied'] =  delay
    for iTone in range(fscan['xs'].shape[1]):
        xs = fscan['xs'][:,iTone]
        freqs = fscan['dfs'] + fscan['freqs'][iTone]
        
        fscan['xs'][:,iTone] = np.abs(xs)*np.exp( 1j*(np.angle(xs) - delay*freqs) )
        
def _unwrapPhis(phis, sign=1):
    """
    Increment (or decrement) values after a large change in phase to unwrap them
    """
    uphis = sign*(phis.copy())
    for i in range(1,len(uphis)):
        if uphis[i-1] > uphis[i]:
            uphis[i:] += 2*np.pi
    return sign*uphis