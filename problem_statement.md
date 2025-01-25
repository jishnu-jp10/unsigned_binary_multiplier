# unsigned_binary_multiplier
**(Unsigned Binary Multiplier using Verilog HDL)**

Design of a multiplier for unsigned binary numbers that multiplies a 4-bit number by a 16-bit number to give a 20-bit product. To speed up the multiplication, a 4-by-4 array multiplier is used so that we can multiply by 4 bits in one clock time instead of by only 1 bit at each clock time. The hardware includes a 24-bit accumulator register that can be shifted right 4 bits at a time using a control signal Sh4. The array multiplier multiplies 4 bits by 4 bits to give an 8-bit product. This product is added to the accumulator using an Ad control signal. When an St signal occurs, the 16-bit multiplier is loaded into the lower part of the A register. A done signal should be turned on when the multiplication is complete. Since both the array multiplier and adder are combinational circuits, the 4-bit multiply and the 8-bit add can both be completed in the same clock cycle.  If D and E are 4-bit unsigned numbers, D * E will compute an 8-bit product. 

Block diagram architecture:
![image](https://github.com/user-attachments/assets/2af9232d-bc34-4860-9912-505e7de03d79)


