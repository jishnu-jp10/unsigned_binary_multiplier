//TESTBENCH

module tb_multiplier_Top();
    reg [15:0] Mult;
    reg [3:0] Mcand;
    reg St, clock;
    wire [19:0] product;
    wire Done;

    // Instantiate the module under test
  multiplier_Top dut (.product(product), .Done(Done), .Mult(Mult), .Mcand(Mcand), .St(St), .clock(clock));

    // Clock generation
    always #5 clock = ~clock;

    initial begin
        // Initialize signals
        clock = 0;
        St = 0;
        Mult = 0;
        Mcand = 0;

        // Test case 1: 5 * 18
        #10;
        Mult = 16'd18; // Multiplicand
        Mcand = 4'd5;  // Multiplier
        St = 1;
        #10 St = 0; // Release start
        wait(Done);
        $display("5 * 18 = %d", product);
        
        // Test case 2: 8 * 20
        #10;
        Mult = 16'd20; // Multiplicand
        Mcand = 4'd8;  // Multiplier
        St = 1;
        #10 St = 0; // Release start
        wait(Done);
        $display("8 * 20 = %d", product);
        
        #20;
        $stop;
    end
endmodule
