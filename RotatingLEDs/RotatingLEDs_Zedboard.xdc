# File:            RotatingLEDs_Zedboard.xdc
# Author:          Caglayan DOKME, caglayandokme@gmail.com
# Date:            May 24, 2021 -> Created
# Description:     Zedboard based constraint file for Rotating LEDs module

# Clock Source
set_property PACKAGE_PIN Y9 [get_ports {clk}];
set_property IOSTANDARD LVCMOS33 [get_ports clk];

# Reset (Center Button)
set_property PACKAGE_PIN P16 [get_ports {reset}];  # "BTNC"
set_property IOSTANDARD LVCMOS33 [get_ports reset];

# Rotation Speed (SW0 to SW7)
set_property PACKAGE_PIN F22 [get_ports {rotationSpeed[0]}];    # SW0
set_property PACKAGE_PIN G22 [get_ports {rotationSpeed[1]}];    # SW1
set_property PACKAGE_PIN H22 [get_ports {rotationSpeed[2]}];    # SW2
set_property PACKAGE_PIN F21 [get_ports {rotationSpeed[3]}];    # SW3
set_property PACKAGE_PIN H19 [get_ports {rotationSpeed[4]}];    # SW4
set_property PACKAGE_PIN H18 [get_ports {rotationSpeed[5]}];    # SW5
set_property PACKAGE_PIN H17 [get_ports {rotationSpeed[6]}];    # SW6
set_property PACKAGE_PIN M15 [get_ports {rotationSpeed[7]}];    # SW7
set_property IOSTANDARD LVCMOS33 [get_ports rotationSpeed[0]];
set_property IOSTANDARD LVCMOS33 [get_ports rotationSpeed[1]];
set_property IOSTANDARD LVCMOS33 [get_ports rotationSpeed[2]];
set_property IOSTANDARD LVCMOS33 [get_ports rotationSpeed[3]];
set_property IOSTANDARD LVCMOS33 [get_ports rotationSpeed[4]];
set_property IOSTANDARD LVCMOS33 [get_ports rotationSpeed[5]];
set_property IOSTANDARD LVCMOS33 [get_ports rotationSpeed[6]];
set_property IOSTANDARD LVCMOS33 [get_ports rotationSpeed[7]];

# LEDs (LED0 - LED7)
set_property PACKAGE_PIN T22 [get_ports {leds[0]}];       # LED0
set_property PACKAGE_PIN T21 [get_ports {leds[1]}];       # LED1
set_property PACKAGE_PIN U22 [get_ports {leds[2]}];       # LED2
set_property PACKAGE_PIN U21 [get_ports {leds[3]}];       # LED3
set_property PACKAGE_PIN V22 [get_ports {leds[4]}];       # LED4
set_property PACKAGE_PIN W22 [get_ports {leds[5]}];       # LED5
set_property PACKAGE_PIN U19 [get_ports {leds[6]}];       # LED6
set_property PACKAGE_PIN U14 [get_ports {leds[7]}];       # LED7
set_property IOSTANDARD LVCMOS33 [get_ports leds[0]];
set_property IOSTANDARD LVCMOS33 [get_ports leds[1]];
set_property IOSTANDARD LVCMOS33 [get_ports leds[2]];
set_property IOSTANDARD LVCMOS33 [get_ports leds[3]];
set_property IOSTANDARD LVCMOS33 [get_ports leds[4]];
set_property IOSTANDARD LVCMOS33 [get_ports leds[5]];
set_property IOSTANDARD LVCMOS33 [get_ports leds[6]];
set_property IOSTANDARD LVCMOS33 [get_ports leds[7]];
