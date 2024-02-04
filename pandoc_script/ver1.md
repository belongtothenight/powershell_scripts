# 7 Segment LED Driver Circuit

## I/O Specification

- INPUT
    - plastic switch array (x4): Represent binary value to display, for displaying decimal digits 0-9
    - power (3V to 18V)
- OUTPUT
    - 7-segment LED display (x1): Display decimal digits 0-9

## Components (per 1 unit)

| No  | Name         | Quantity | Description                        | Link to Item                                                                                                                 |
| :-: | -            | :-:      | -                                  | :-:                                                                                                                          |
| 1   | CD4511BE     | 1        | LED driver                         | [貿澤](https://www.mouser.tw/ProductDetail/Texas-Instruments/CD4511BE?qs=sGAEpiMZZMutXGli8Ay4kD%252BkpvCmt1Jbvu3k2X8AEmM%3D) |
| 2   | 5161AS       | 1        | 7-segment display (common cathode) | [集賢](https://knowing-tech.com/product/5161as/)                                                                             |
| 3   | Switch Array | 1        | 4P (4-bit) switch array            | [集賢](https://knowing-tech.com/product/dip-4/)                                                                              |
| 4   | Battery      | 1        | 9V                                 |                                                                                                                              |
| 5   | Resistor     | 4        | 10k Ohm                            |                                                                                                                              |
| 6   | Resistor     | 7        | 470 Ohm                            |                                                                                                                              |

## Circuit Diagram

![Circuit diagram drawn with [KiCAD](https://kicad.org/).](7SegCtl_circuit/7SegCtl_circuit.svg)

## Proof of Viability

![Circuit pre-tested with [tinkercad](https://www.tinkercad.com) for proof of viability.](breadboard/7SegCtl_circuit.png)

## Reference

1. [YouTube - Best breadboard 7-segment LED driver: TLC5916 tutorial](https://www.youtube.com/watch?v=EsUxWO096L0)
2. [ALL ABOUT CIRCUITS - Digital Lab - 7-segment LED Display](https://www.allaboutcircuits.com/textbook/experiments/chpt-7/7-segment-display/)
