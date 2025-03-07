create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_0
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_0.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_0]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_10
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_10.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_10]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_11
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_11.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_11]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_12
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_12.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_12]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_13
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_13.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_13]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_14
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_14.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_14]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_15
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_15.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_15]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_1
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_1.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_1]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_2
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_2.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_2]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_3
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_3.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_3]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_4
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_4.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_4]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_5
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_5.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_5]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_6
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_6.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_6]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_7
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_7.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_7]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_8
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_8.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_8]
create_ip -name fir_compiler -vendor xilinx.com -library ip -version 7.2 -module_name fir_9
set_property -dict [list \
	CONFIG.CoefficientSource {COE_File} \
	CONFIG.Coefficient_File {/home/lstefana/v20.2/ip/axis_pfb_8x16_v1/src/fir/coef/fir_9.coe} \
	CONFIG.Filter_Type {Interpolated} \
	CONFIG.Number_Paths {2} \
	CONFIG.RateSpecification {Input_Sample_Period} \
	CONFIG.Coefficient_Structure {Non_Symmetric} \
	CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
	CONFIG.Output_Width {16} \
	CONFIG.Coefficient_Sets {1} \
	CONFIG.Interpolation_Rate {1} \
	CONFIG.Decimation_Rate {1} \
	CONFIG.Zero_Pack_Factor {2} \
	CONFIG.Number_Channels {1} \
	CONFIG.SamplePeriod {1} \
	CONFIG.Sample_Frequency {0.001} \
	CONFIG.Clock_Frequency {300.0} \
	CONFIG.Coefficient_Sign {Signed} \
	CONFIG.Quantization {Integer_Coefficients} \
	CONFIG.Coefficient_Width {16} \
	CONFIG.Coefficient_Fractional_Bits {0} \
	CONFIG.Data_Width {16} \
	CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
	CONFIG.ColumnConfig {7}] \
[get_ips fir_9]
