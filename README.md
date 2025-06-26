# SPI-Module
SPI (Serial Peripheral Interface) is a synchronous serial communication protocol used to transfer data between a microcontroller (master) and one or more peripheral devices (slaves).
#Key-Charactristics:
Synchronous: Data is transferred with a shared clock signal.
Full-duplex: Data can be sent and received simultaneously.
Master-slave architecture: One master controls the communication with one or more slaves.
#Transmitter Design
clock divder divedes the main clock to required clock to be used as spi_clock
A PISO Module takes parallel input and serialy outs that input along with a spi clock signal.
Transmitter module instansiates both clock divider and PISO.
![transmitter](https://github.com/user-attachments/assets/2799bde0-fd29-474b-8fa6-eb904803c4da)
![transmitter](https://github.com/user-attachments/assets/2799bde0-fd29-474b-8fa6-eb904803c4da)
#Reciever Design
SIPO acts as reciver its basically a serial in parall out shift reigister.
Reciver module instansiates the SIPO Module.
![recieverJPG](https://github.com/user-attachments/assets/b7cc883d-9aae-46ff-8395-4184f6a4d01f)
![recieverJPG](https://github.com/user-attachments/assets/b7cc883d-9aae-46ff-8395-4184f6a4d01f)
A complete transceiver module is designed called Top Module.
![top module](https://github.com/user-attachments/assets/fb30358f-771b-4a1a-8f20-082708f0fde5)
![top module](https://github.com/user-attachments/assets/fb30358f-771b-4a1a-8f20-082708f0fde5)
