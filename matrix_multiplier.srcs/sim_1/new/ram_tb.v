`timescale 1ns / 1ps

module ram_tb;

    // Inputs
    reg clk;
    reg [9:0] addr0, addr1;
    reg [31:0] d0, d1;
    reg [3:0] we0, we1;

    // Outputs
    wire [31:0] q0, q1;

    // RAM instance
    ram uut (
        .addr0(addr0),
        .d0(d0),
        .we0(we0),
        .q0(q0),
        .addr1(addr1),
        .d1(d1),
        .we1(we1),
        .q1(q1),
        .clk(clk)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Test procedure
    initial begin
        // Initialize inputs
        addr0 = 0; addr1 = 0;
        d0 = 0; d1 = 0;
        we0 = 0; we1 = 0;

        // Wait for the clock to stabilize
        #30;

        // Test write operation on Port 0
        addr0 = 4'b0001; d0 = 31'hAA; we0 = 1'b1; // Write 0xAA at address 1
        addr1 = 4'b0010; d1 = 31'h55; we1 = 1'b1; // Write 0x55 at address 2
        
        #30;
        we0 = 0; we1 = 0;
        #30;
        
        
        // Test read operation on Port 0
        addr0 = 4'b0001; // Read from address 1
        #30;
        $display("Port 0: Read data at address 1 = %h (Expected: AA)", q0);
        
        addr1 = 4'b0010; // Read from address 2
        #30;
        $display("Port 1: Read data at address 2 = %h (Expected: 55)", q1);
        
        
//        #10;
//        we0 = 0; // Disable write
//        #10;

//        // Test read operation on Port 0
//        addr0 = 4'b0001; // Read from address 1
//        #10;
//        $display("Port 0: Read data at address 1 = %h (Expected: AA)", q0);

//        // Test write operation on Port 1
//        addr1 = 4'b0010; d1 = 8'h55; we1 = 1'b1; // Write 0x55 at address 2
//        #10;
//        we1 = 0; // Disable write
//        #10;

//        // Test read operation on Port 1
//        addr1 = 4'b0010; // Read from address 2
//        #10;
//        $display("Port 1: Read data at address 2 = %h (Expected: 55)", q1);

//        // Test read-after-write on Port 0
//        addr0 = 4'b0001; d0 = 8'hFF; we0 = 1'b1; // Write 0xFF at address 1
//        #10;
//        $display("Port 0: Read-after-write data at address 1 = %h (Expected: FF)", q0);
//        we0 = 0; // Disable write
//        #10;

        // End of test
        $finish;
    end

endmodule
