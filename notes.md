# OS Notes
---
## Mouse Control
- 3 - 4 byte packets asynchronously on port `0x60` (keyboard port) - Does not trigger IRQ1, instead IRQ12
- occasionally poll bit number 0 (value=1) of port 0x64
- Not necessary to use a driver but it can make things work faster
- To check if a byte in `0x60` is a keyboard input or a mouse input, you will have to check `0x64`. if it has a bit, it is a mouse input
- An additional bit, bit number 5 (value=0x20), indicates that this next byte came from the mouse, if the bit is set.
- No scroll wheel is a 3 byte packet and a 5 button (with scroll wheel) is a 4 byte packet
- The top two bits of the first byte (values 0x80 and 0x40) supposedly show Y and X overflows, respectively. They are not useful. If they are set, you should probably just discard the entire packet. Bit number 5 of the first byte (value 0x20) indicates that delta Y (the 3rd byte) is a negative number, if it is set. This means that you should OR 0xFFFFFF00 onto the value of delta Y, as a sign extension (if using 32 bits). Bit number 4 of the first byte (value 0x10) indicates that delta X (the 2nd byte) is a negative number, if it is set. This means that you should OR 0xFFFFFF00 onto the value of delta X, as a sign extension (if using 32 bits). Bit number 3 of the first byte (value 0x8) is supposed to be always set. This helps to maintain and verify packet alignment. Unfortunately, some older mice (such as 10 year old Microspeed 2 button trackballs) do not set this bit. RBIL claims that this bit should be 0, but it is wrong. The bottom 3 bits of the first byte indicate whether the middle, right, or left mouse buttons are currently being held down, if the respective bit is set. Middle = bit 2 (value=4), right = bit 1 (value=2), left = bit 0 (value=1).
---
### Useful links
- [OSDev Mouse input](https://wiki.osdev.org/Mouse_Input)
