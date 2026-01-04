`timescale 1ns / 1ps

module dual_port_bram #(
    parameter int ADDR_WIDTH = 10, 
    parameter int DATA_WIDTH = 8)
(
    input logic clk,
    input logic we0,
    input logic we1,
    input logic [ADDR_WIDTH-1:0] addr0, 
    input logic [ADDR_WIDTH-1:0] addr1,
    input logic [DATA_WIDTH-1:0] din0,
    input logic [DATA_WIDTH-1:0] din1,
    output logic [DATA_WIDTH-1:0] dout0,
    output logic [DATA_WIDTH-1:0] dout1
    );
    
    always_ff @(posedge clk) begin
        if (we0) begin
            RAM[addr0] <= din0;
        end
    end
    
    always_ff @(posedge clk) begin
        if (we1) begin
            RAM[addr1] <= din1;
        end
    end
    
    assign dout0 = RAM[addr0];
    assign dout1 = RAM[addr1];

endmodule
