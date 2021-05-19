# File:            PWM_Generator_Zedboard.xdc
# Author:          Caglayan DOKME, caglayandokme@gmail.com
# Date:            May 19, 2021 -> Created
# Description:     Zedboard based constraint file for PWM generator module

# Clock Source
set_property PACKAGE_PIN Y9 [get_ports {clk}];
set_property IOSTANDARD LVCMOS33 [get_ports clk];

# Reset (Center Button)
set_property PACKAGE_PIN P16 [get_ports {reset}];  # "BTNC"
set_property IOSTANDARD LVCMOS33 [get_ports reset];

# Duty Cycles(SW0 to SW7)
set_property PACKAGE_PIN F22 [get_ports {dutyCycle[0]}];    # SW0
set_property PACKAGE_PIN G22 [get_ports {dutyCycle[1]}];    # SW1
set_property PACKAGE_PIN H22 [get_ports {dutyCycle[2]}];    # SW2
set_property PACKAGE_PIN F21 [get_ports {dutyCycle[3]}];    # SW3
set_property PACKAGE_PIN H19 [get_ports {dutyCycle[4]}];    # SW4
set_property PACKAGE_PIN H18 [get_ports {dutyCycle[5]}];    # SW5
set_property PACKAGE_PIN H17 [get_ports {dutyCycle[6]}];    # SW6
set_property PACKAGE_PIN M15 [get_ports {dutyCycle[7]}];    # SW7
set_property IOSTANDARD LVCMOS33 [get_ports dutyCycle[0]];
set_property IOSTANDARD LVCMOS33 [get_ports dutyCycle[1]];
set_property IOSTANDARD LVCMOS33 [get_ports dutyCycle[2]];
set_property IOSTANDARD LVCMOS33 [get_ports dutyCycle[3]];
set_property IOSTANDARD LVCMOS33 [get_ports dutyCycle[4]];
set_property IOSTANDARD LVCMOS33 [get_ports dutyCycle[5]];
set_property IOSTANDARD LVCMOS33 [get_ports dutyCycle[6]];
set_property IOSTANDARD LVCMOS33 [get_ports dutyCycle[7]];

# Wave (LED0)
set_property PACKAGE_PIN T22 [get_ports {pwmSignal}];
set_property IOSTANDARD LVCMOS33 [get_ports pwmSignal];
