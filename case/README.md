# usb-atx-ctrl-redux case

## Printing

There are two versions of the case - with signs ([STL](usb-atx-ctrl-redux-signs.stl) and [3MF optimized for multi-material](usb-atx-ctrl-redux-signs.3mf)) and without ([STL](usb-atx-ctrl-redux.stl)).

Printing is done typically by placing the box and the cap on the build plate.

Pretty much any non-conductive material can be used.

The holes for LEDs can be enlarged using a 1.7mm drill bit and a translucent 1.75mm filament can be used as a light guide.

## Modification

The case source is in OpenSCAD. Whether signs for ports are enabled or not is determined by the `signs_enabled` variable.  

To export the STL correctly though a recent OpenSCAD version (2025.x) must be used with lazy unions enabled. 

## License

The case is [licensed](LICENSE) under Creative Commons Attribution 4.0 license ("CC-BY").
