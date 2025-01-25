//Figure 1 is the required state graph of the multiplier. The 4-bit multiplier needs four sets of addition and shifts. It continues to be in the same state unless the signal St is 1. If the Signal St is 1, then it outputs the load and executes 4 sets of pairs adding and shifting right. After the execution, its goes to the initial state as shown in figure 1.

module multiplier_tb;
 wire Done;
 wire [19:0] product;
 reg [15:0] Mult;
 reg [3:0] Mcand;
 reg St;
 reg clk;

 multiplier uut(product, Done, Mult, Mcand, St, clk);

always
 #5 clk = ~clk;

initial 
 begin
  Mult = 0;
  Mcand = 0;
  St = 0;
  clk = 0;
  #100;

  Mult = 16'b0000_0000_0000_1001;  //9
  Mcand = 4'b0101; //5
  St = 1;
  #100;

  Mult = 16'b0000_0000_0000_1011; //11
  Mcand = 4'b1111; //15
  #100 $stop;
 end
 
endmodule

