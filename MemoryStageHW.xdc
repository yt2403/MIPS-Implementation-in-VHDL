# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# Switches
set_property PACKAGE_PIN V17 [get_ports {switches[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[0]}]
set_property PACKAGE_PIN V16 [get_ports {switches[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[1]}]
set_property PACKAGE_PIN W16 [get_ports {switches[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[2]}]
set_property PACKAGE_PIN W17 [get_ports {switches[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[3]}]
set_property PACKAGE_PIN W15 [get_ports {switches[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[4]}]
set_property PACKAGE_PIN V15 [get_ports {switches[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[5]}]
set_property PACKAGE_PIN W14 [get_ports {switches[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[6]}]
set_property PACKAGE_PIN W13 [get_ports {switches[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[7]}]
set_property PACKAGE_PIN V2 [get_ports {switches[8]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[8]}]
set_property PACKAGE_PIN T3 [get_ports {switches[9]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[9]}]
set_property PACKAGE_PIN T2 [get_ports {switches[10]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[10]}]
set_property PACKAGE_PIN R3 [get_ports {switches[11]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[11]}]
set_property PACKAGE_PIN W2 [get_ports {switches[12]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[12]}]
set_property PACKAGE_PIN U1 [get_ports {switches[13]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[13]}]
set_property PACKAGE_PIN T1 [get_ports {switches[14]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[14]}]
set_property PACKAGE_PIN R2 [get_ports {switches[15]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[15]}]





#7 segment display
set_property PACKAGE_PIN W7 [get_ports {SevenSegDigit[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegDigit[0]}]
set_property PACKAGE_PIN W6 [get_ports {SevenSegDigit[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegDigit[1]}]
set_property PACKAGE_PIN U8 [get_ports {SevenSegDigit[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegDigit[2]}]
set_property PACKAGE_PIN V8 [get_ports {SevenSegDigit[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegDigit[3]}]
set_property PACKAGE_PIN U5 [get_ports {SevenSegDigit[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegDigit[4]}]
set_property PACKAGE_PIN V5 [get_ports {SevenSegDigit[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegDigit[5]}]
set_property PACKAGE_PIN U7 [get_ports {SevenSegDigit[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SevenSegDigit[6]}]

#set_property PACKAGE_PIN V7 [get_ports dp]
#	set_property IOSTANDARD LVCMOS33 [get_ports dp]

set_property PACKAGE_PIN U2 [get_ports {ActiveDigit[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ActiveDigit[0]}]
set_property PACKAGE_PIN U4 [get_ports {ActiveDigit[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ActiveDigit[1]}]
set_property PACKAGE_PIN V4 [get_ports {ActiveDigit[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ActiveDigit[2]}]
set_property PACKAGE_PIN W4 [get_ports {ActiveDigit[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ActiveDigit[3]}]


##Buttons
set_property PACKAGE_PIN U18 [get_ports rst]
	set_property IOSTANDARD LVCMOS33 [get_ports rst]

