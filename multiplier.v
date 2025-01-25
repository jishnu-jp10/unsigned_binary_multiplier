/*module multiplier(Done, Mult, Mcand, St, CLK);
 output Done;
 input [15:0] Mult;
 input [3:0] Mcand;
 input St, CLK;
 
 reg Done;
 reg [23:0] A;
 reg Ld, Ad, Sh4;
 reg [3:0] PS, NS;

initial 
 begin
  Done = 0;
  A = 0;
  Ld = 0;
  Ad = 0;
  Sh4 = 0;
  PS = 0;
  NS = 0;
 end

always @(PS, St)
 begin
  Ld = 0;
  Sh4 = 0;
  Ad = 0;
  Done = 0;

 case(PS)
  0: begin
   if(St == 1) begin
    Ld = 1;
    NS = 1;
   end
  else begin
   NS = 0;
  end
 end

  1,3,5,7: begin
   Ad = 1;
   NS = PS + 1;
  end

  2,4,6,8: begin
   Sh4 = 1;
   NS = PS + 1;
  end

  9: begin
   Done = 1;
   NS = 0;
  end

 default: begin
  end

  endcase
 end

always @(posedge CLK)
 begin
  PS <= NS;
  if(Ld == 1)
   A <= {8'b00000000, Mult};
  
  if(Ad == 1)
   A[23:16] <= (Mcand * Mult[3:0]) + A[23:16];
  
  if(Sh4 == 1)
   A <= A >> 4;
 end
endmodule*/





/*
/Working code
module multiplier(product, Done, Mult, Mcand, St, clk);
 output [19:0] product;  // 20-bit product value
 output Done;   // When Done = 1, product value is obtained
 input [15:0] Mult;  //16-bit number 
 input [3:0] Mcand;  //4-bit number 
 input St, clk;
 
 reg [19:0] product;  
 reg Done; 
 reg [23:0] A;
 reg Ld, Ad, Sh4;
 reg [3:0] PS, NS;

 //State Encoding
 parameter  s0 = 4'b0000,
            s1 = 4'b0001,   
            s2 = 4'b0010,   
            s3 = 4'b0011,  
            s4 = 4'b0100,
            s5 = 4'b0101;  
            s6 = 4'b0110,   
            s7 = 4'b0111,   
            s8 = 4'b1000,  
            s9 = 4'b1001;
 
         
assign product = A[19:0];

always @(PS, St)
 begin
  Ld = 0;
  Sh4 = 0;
  Ad = 0;
  Done = 0;
  product = 0;

 case(PS)
  s0: begin
   if(St == 1) begin
    Ld = 1;
    NS = s1;
   end
  else begin
   NS = s0;
  end
 end

  s1,s3: begin
   Ad = 1;
   NS = PS + 1;//4'b0001;
   product = A[19:0];
  end

  s2,s4: begin
   Sh4 = 1;
   NS = PS + 1;//4'b0001;
   product = A[19:0];
  end

  s5: begin
   product = A[19:0];  // Assign the lower 20 bits of A reg to product
   Done = 1;
   NS = s0;
  end

  default: begin
            NS = s0;
           end
 endcase
 end

// Sequential block for State transition and accumulator operations
always @(posedge clk) begin
 PS <= NS;
  if (Ld == 1) begin
   A <= {8'b00000000, Mult};  // Load multiplier into lower 16 bits of A
  end
        
  if (Ad == 1) begin
   A[23:16] <= (Mcand * A[3:0]) + A[23:16]; // Multiply and add to upper 8 bits
  end
        
  if (Sh4 == 1) begin
   A <= A >> 4; // Shift accumulator A right by 4 bits
  end
 end
endmodule*/



// Unsigned Binary bits multiplier
module multiplier(product, Done, Mult, Mcand, St, clk);
 output [19:0] product;  // 20-bit product value
 output Done;   // When Done = 1, product value is obtained
 input [15:0] Mult;  //16-bit number 
 input [3:0] Mcand;  //4-bit number 
 input St, clk;
 
 wire [19:0] product;  
 reg Done; 
 reg [23:0] A;
 reg Ld, Ad, Sh4;
 reg [3:0] PS, NS; // previous state & next state

 //State Encoding
 parameter  s0 = 4'b0000,
            s1 = 4'b0001,   
            s2 = 4'b0010,   
            s3 = 4'b0011,  
            s4 = 4'b0100,
            s5 = 4'b0101,  
            s6 = 4'b0110,   
            s7 = 4'b0111,   
            s8 = 4'b1000,  
            s9 = 4'b1001;
 

//Next state logic
always @(St or PS)
 begin
  Ld = 0;
  Sh4 = 0;
  Ad = 0;
  Done = 0;
  //product = 0;

 case(PS)
  s0: begin
   if(St == 1) begin
    Ld = 1;
    NS = s1;
   end
  else begin
   NS = s0;
  end
 end

  s1: begin
   Ad = 1;
   NS = PS + 1;
   //product = A[19:0];
  end

  s2: begin
   Sh4 = 1;
   NS = PS + 1;
   //product = A[19:0];
  end

  s3: begin
   Ad = 1;
   NS = PS + 1;
   //product = A[19:0];
  end

  s4: begin
   Sh4 = 1;
   NS = PS + 1;
   //product = A[19:0];
  end

  s5: begin
   Ad = 1;
   NS = PS + 1;
   //product = A[19:0];
  end

  s6: begin
   Sh4 = 1;
   NS = PS + 1;
   //product = A[19:0];
  end

  s7: begin
   Ad = 1;
   NS = PS + 1;
   //product = A[19:0];
  end

  s8: begin
   Sh4 = 1;
   NS = PS + 1;
   //product = A[19:0];
  end

  s9: begin
   //product = A[19:0];  //Final product value
   Done = 1;
   NS = s0;
  end

  default: begin
            NS = s0;
           end
 endcase
 end

assign product = A[19:0];  // Assign the lower 20 bits of A reg to product

// Sequential block for State transition and accumulator operations
always @(posedge clk) 
 begin
 PS <= NS;
  if (Ld == 1) begin
   A <= {8'b00000000, Mult};  // Load multiplier into lower 16 bits of A
  end
        
  if (Ad == 1) begin
   A[23:16] <= (Mcand * A[3:0]) + A[23:16]; // Multiply and add to upper 8 bits
  end
        
  if (Sh4 == 1) begin
   A <= A >> 4; // Shift accumulator A right by 4 bits
  end
end
endmodule

// The product value obtained when Done = 1 is the final answer.
