`timescale 1ns/1ps

module single_port_ram_tb;

reg clk;
reg we;
reg [3:0] address;
reg [7:0] data_in;
wire [7:0] data_out;

// Instantiate the DUT
single_port_ram uut (
    .clk(clk),
    .we(we),
    .address(address),
    .data_in(data_in),
    .data_out(data_out)
);

// Clock generation
always #5 clk = ~clk;

initial
begin
    // Generate waveform
    $dumpfile("dump.vcd");
    $dumpvars(0, single_port_ram_tb);

    // Initialize signals
    clk = 0;
    we = 0;
    address = 0;
    data_in = 0;

    // Write AA to address 3
    #10;
    we = 1;
    address = 4'd3;
    data_in = 8'hAA;

    // Write 55 to address 7
    #10;
    address = 4'd7;
    data_in = 8'h55;

    // Read address 3
    #10;
    we = 0;
    address = 4'd3;

    // Read address 7
    #10;
    address = 4'd7;

    #20;
    $finish;
end

// Display simulation output
initial
begin
    $monitor("Time=%0t WE=%b Address=%d DataIn=%h DataOut=%h",
             $time, we, address, data_in, data_out);
end

endmodule
