//Top module of Unsigned Binary bit multiplier (20 bits) 
module multiplier_Top (product, Done, Mult, Mcand, St, clock); 
output [19:0] product; // 20-bit product 
output Done;           
// Done signal 
input [15:0] Mult;     
input [3:0] Mcand;      
input St;              
// 16-bit Multiplier 
// 4-bit Multiplicand 
// Start signal 
input clock;          
// Internal signals 
wire Ld, Ad, Sh4; 
// Clock signal 
wire [7:0] mult_result, add_result; 
wire [23:0] A; 
// Instantiate submodules 
control_unit cu (.clock(clock), .St(St), .Ld(Ld), .Ad(Ad), .Sh4(Sh4), .Done(Done)); 
multiplier mul (.a(Mcand), .b(A[3:0]), .prod(mult_result)); 
adder add (.a(A[23:16]), .b(mult_result), .sum(add_result)); 
 accumulator acc (.clock(clock), .Ld(Ld), .Sh4(Sh4), .Mult(Mult), .add_result(add_result), 
.A(A)); 
 
// Assign final product 
 assign product = A[19:0]; 
endmodule 


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Instantiated modules

//Control unit 
module control_unit (clock, St, Ld, Ad, Sh4, Done); 
 input clock;          // Clock signal 
 input St;           // Start signal 
 output Ld;      // Load signal 
 output Ad;      // Add signal 
 output Sh4;     // Shift signal 
 output Done;     // Done signal 
 
 reg Ld, Ad, Sh4, Done; 
 reg [3:0] PS, NS;   // Previous state and Next state 
 
// State Encoding 
 parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011, 
              s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111, 
              s8 = 4'b1000, s9 = 4'b1001; 
 
// State transition logic 
 always @(posedge clock) begin 
  PS <= NS; 
 end 
 
// Next state logic 
 always @(St or PS) begin 
  Ld = 0; 
  Ad = 0; 
  Sh4 = 0; 
  Done = 0; 
 
 case (PS) 
  s0: begin 
   if (St) begin 
    Ld = 1; 
    NS = s1; 
   end 
   else begin 
    NS = s0; 
   end 
  end 
 
  s1, s3, s5, s7: begin 
   Ad = 1; 
   NS = PS + 1; 
  end 
 
  s2, s4, s6, s8: begin 
   Sh4 = 1; 
   NS = PS + 1; 
  end 
 
  s9: begin 
   Done = 1; 
   NS = s0; 
  end 
 
  default: NS = s0; 
 endcase 
 end 
endmodule

/////////////////////////////////

//Multiplier 
module multiplier (a,b,prod); 
 input [3:0] a;    // 4-bit input (Mcand) 
 input [3:0] b;    // 4-bit input (lower 4 bits of accumulator) 
 output [7:0] prod; // 8-bit product output 
 
 assign prod = a * b;  
endmodule 

/////////////////////////////////

// Adder 
module adder (a,b,sum); 
 input [7:0] a;    // 8-bit input 
 input [7:0] b;    // 8-bit input 
 output [7:0] sum  // 8-bit sum output 
 
 assign sum = a + b;  
endmodule 

/////////////////////////////////

//Accumulator 
module accumulator (clock,Ld,Sh4,Mult,add_result,A); 
 input clock;              // Clock signal 
 input Ld;               // Load signal 
 input Sh4;              // Shift signal 
 input [15:0] Mult;      // 16-bit multiplicand 
 input [7:0] add_result; // 8-bit result from adder 
 output reg [23:0] A;     // 24-bit accumulator 
 
 always @(posedge clock) begin 
  if (Ld) begin 
   A <= {8'b00000000, Mult}; // Load multiplicand into lower 16-bits 
  end 
  else if (Sh4) begin 
   A <= A >> 4; // Shift right by 4-bits 
  end 
  else begin 
   A[23:16] <= add_result; // Update upper 8-bits with adder result 
  end 
  end 
endmodule
