EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Texas_MSP430:MSP430G2553IRHB32 U1
U 1 1 5E8F512E
P 8100 2150
F 0 "U1" H 8100 3431 50  0000 C CNN
F 1 "MSP430G2553IRHB32" H 8100 3340 50  0000 C CNN
F 2 "Package_DIP:DIP-32_W7.62mm" H 6950 1150 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/msp430g2553.pdf" H 8100 2150 50  0001 C CNN
	1    8100 2150
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Raspberry_Pi_2_3 J1
U 1 1 5E8F67ED
P 2050 3450
F 0 "J1" H 2050 4931 50  0000 C CNN
F 1 "NVIDIA_Jetson_Nano" H 2050 4840 50  0000 C CNN
F 2 "seniordesign:PinSocket_2x20_P2.54mm_Vertical_SMD_posts" H 2050 3450 50  0001 C CNN
F 3 "https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3bplus_1p0_reduced.pdf" H 2050 3450 50  0001 C CNN
	1    2050 3450
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Female J2
U 1 1 5E8F81AD
P 9800 4800
F 0 "J2" H 9828 4826 50  0000 L CNN
F 1 "Pressure_Sensor" H 9828 4735 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Horizontal" H 9800 4800 50  0001 C CNN
F 3 "~" H 9800 4800 50  0001 C CNN
	1    9800 4800
	1    0    0    -1  
$EndComp
$Sheet
S 6250 3750 1400 2050
U 5E94DDF9
F0 "motors" 50
F1 "motors.sch" 50
F2 "MotorAGo" I L 6250 4300 50 
$EndSheet
$Sheet
S 4300 3750 1400 2050
U 5E94ECD4
F0 "power" 50
F1 "power.sch" 50
$EndSheet
$Comp
L Device:C C?
U 1 1 5E9AAE09
P 3500 1300
F 0 "C?" H 3615 1346 50  0000 L CNN
F 1 "C" H 3615 1255 50  0000 L CNN
F 2 "" H 3538 1150 50  0001 C CNN
F 3 "~" H 3500 1300 50  0001 C CNN
	1    3500 1300
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 5E9AC293
P 2250 1950
F 0 "#PWR?" H 2250 1800 50  0001 C CNN
F 1 "+3.3V" H 2265 2123 50  0000 C CNN
F 2 "" H 2250 1950 50  0001 C CNN
F 3 "" H 2250 1950 50  0001 C CNN
	1    2250 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 1950 2250 2050
Wire Wire Line
	2250 2050 2150 2050
Wire Wire Line
	2150 2050 2150 2150
Connection ~ 2250 2050
Wire Wire Line
	2250 2050 2250 2150
$EndSCHEMATC
