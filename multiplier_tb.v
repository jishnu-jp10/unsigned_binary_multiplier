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


/*module multiplier_tb;

    // Testbench signals
    reg [15:0] Mult;         // 16-bit multiplier input
    reg [3:0] Mcand;          // 4-bit multiplicand input
    reg St;                   // Start signal
    reg CLK;                  // Clock signal
    wire Done;                // Done signal from multiplier
    wire [19:0] product;      // 20-bit product output from multiplier

    // Instantiate the multiplier module
     multiplier uut(product, Done, Mult, Mcand, St, CLK);
 

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK; // 10 time unit clock period
    end

    // Test procedure
    initial begin
        // Initialize signals
        Mult = 16'd0;
        Mcand = 4'd0;
        St = 0;
        
        // Wait for a couple of clock cycles
        #10;
        
        // Test Case 1: Mult = 16, Mcand = 3
        Mult = 16'd16;
        Mcand = 4'd3;
        St = 1;
        #10 St = 0;  // Deassert start after one clock cycle

        // Wait for the multiplier to complete
        wait(Done == 1);
        #10; // Small delay for stability
        $display("Test Case 1: Mult = %d, Mcand = %d, Product = %d", Mult, Mcand, Product);

        // Test Case 2: Mult = 25, Mcand = 7
        Mult = 16'd25;
        Mcand = 4'd7;
        St = 1;
        #10 St = 0;  // Deassert start after one clock cycle

        // Wait for the multiplier to complete
        wait(Done == 1);
        #10;
        $display("Test Case 2: Mult = %d, Mcand = %d, Product = %d", Mult, Mcand, Product);

        // Test Case 3: Mult = 100, Mcand = 15
        Mult = 16'd100;
        Mcand = 4'd15;
        St = 1;
        #10 St = 0;

        // Wait for the multiplier to complete
        wait(Done == 1);
        #10;
        $display("Test Case 3: Mult = %d, Mcand = %d, Product = %d", Mult, Mcand, Product);

        // Test Case 4: Edge case Mult = 0, Mcand = 8
        Mult = 16'd0;
        Mcand = 4'd8;
        St = 1;
        #10 St = 0;

        // Wait for the multiplier to complete
        wait(Done == 1);
        #10;
        $display("Test Case 4: Mult = %d, Mcand = %d, Product = %d", Mult, Mcand, Product);

        // Test Case 5: Edge case Mult = 65535, Mcand = 15 (Maximum input values)
        Mult = 16'd65535;
        Mcand = 4'd15;
        St = 1;
        #10 St = 0;

        // Wait for the multiplier to complete
        wait(Done == 1);
        #10;
        $display("Test Case 5: Mult = %d, Mcand = %d, Product = %d", Mult, Mcand, Product);

        // Finish simulation
        #100; $stop;
    end

endmodule*/
