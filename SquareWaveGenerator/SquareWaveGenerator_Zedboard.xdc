# File:            SquareWaveGenerator_Zedboard.xdc
# Author:          Caglayan DOKME, caglayandokme@gmail.com
# Date:            May 16, 2021 -> Created
# Description:     Zedboard based constraint file for square wave generator module

# Clock Source
set_property PACKAGE_PIN Y9 [get_ports {clk}];
set_property IOSTANDARD LVCMOS33 [get_ports clk];

# Reset (Center Button)
set_property PACKAGE_PIN P16 [get_ports {reset}];  # "BTNC"
set_property IOSTANDARD LVCMOS33 [get_ports reset];

# High Cycles(SW0 to SW3)
set_property PACKAGE_PIN F22 [get_ports {highCycles[0]}];   # SW0
set_property PACKAGE_PIN G22 [get_ports {highCycles[1]}];   # SW1
set_property PACKAGE_PIN H22 [get_ports {highCycles[2]}];   # SW2
set_property PACKAGE_PIN F21 [get_ports {highCycles[3]}];   # SW3
set_property IOSTANDARD LVCMOS33 [get_ports highCycles[0]];
set_property IOSTANDARD LVCMOS33 [get_ports highCycles[1]];
set_property IOSTANDARD LVCMOS33 [get_ports highCycles[2]];
set_property IOSTANDARD LVCMOS33 [get_ports highCycles[3]];

# Low Cycles(SW4 to SW7)
set_property PACKAGE_PIN H19 [get_ports {lowCycles[0]}];    # SW4
set_property PACKAGE_PIN H18 [get_ports {lowCycles[1]}];    # SW5
set_property PACKAGE_PIN H17 [get_ports {lowCycles[2]}];    # SW6
set_property PACKAGE_PIN M15 [get_ports {lowCycles[3]}];    # SW7
set_property IOSTANDARD LVCMOS33 [get_ports lowCycles[0]];
set_property IOSTANDARD LVCMOS33 [get_ports lowCycles[1]];
set_property IOSTANDARD LVCMOS33 [get_ports lowCycles[2]];
set_property IOSTANDARD LVCMOS33 [get_ports lowCycles[3]];

# Wave (JA1)
set_property PACKAGE_PIN Y11 [get_ports {wave}];
set_property IOSTANDARD LVCMOS33 [get_ports wave];
