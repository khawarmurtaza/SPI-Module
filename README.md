# SPI-Module
Verilog based SPI transciver
clock divder divedes the main clock to required clock to be used as spi_clock
A PISO Module takes parallel input and serialy outs that input along with a spi clock signal.
Transmitter module instansiates both clock divider and PISO.
SIPO acts as reciver its basically a serial in parall out shift reigister.
Reciver module instansiates the SIPO Module.
A loop back module for verification is designed called Top Module.
