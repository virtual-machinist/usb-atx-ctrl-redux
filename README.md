# usb-atx-ctrl-redux

## Rationale

This project is a minified/reduced version of [usb-atx-ctrl](https://github.com/zappanaut/usb-atx-ctrl) project by Zappanaut.

The rationale behind this project is to have a standard PiKVM ATX breakout board installed in the case of the PC being controlled vs replacing it with a custom PCB like done in the aforementioned project.

## Design Choices and Components Used

1. RP2040-Zero (`RZ1`) is not soldered to the PCB directly, but using SMD female pin headers. If needed `RZ1` can be soldered through a set of male pin headers. This might however require offsetting the USB-C socket in the case model.  
2. `SW1` and `SW2` are 4.5x4.5x5mm 90° through-hole miniature tactile push-button switches with distance between the shield and switch terminals is ~2.0mm.

## Assembly

Assembly starts with SMD components, typically resistors, then LEDs, then optorelays. After that RP2040-Zero, tactile switches, then 8P8C socket.  

After PCB assembly it's recommended to print and use a [case](case/README.md) to protect the PCB from accidental damage and electrical shorts.

Assembled photos can be seen under [pictures](pictures/README.md).

## Usage

Setting up the RP2040-Zero is the same as in [usb-atx-ctrl](https://github.com/zappanaut/usb-atx-ctrl) project. The project requires a PC with an [ATX breakout board](https://github.com/pikvm/pikvm/blob/master/docs/atx_board.md) from the PiKVM project or some other solution that exposes a [compatible](https://github.com/pikvm/pikvm/blob/master/docs/atx_board/rj45.jpg) RJ-45 connector. 

## License

The project uses MIT license, except for the case which is [licensed](case/LICENSE) under Creative Commons Attribution 4.0 license ("CC-BY").

## Credits

1. [usb-atx-ctrl](https://github.com/zappanaut/usb-atx-ctrl) project by Zappanaut for most of the schematics and some of the symbols.

2. [Wright-Train-Works](https://github.com/acwright/Wright-Train-Works) project by Aaron Wright for the Amphenol connector STEP file.
