`timescale 1ns / 1ps

module fifo#(
    parameter int WIDTH = 8,
    parameter int DEPTH = 8
)(
    input logic clk,
    input logic reset,
    input logic write_en,
    input logic read_en,
    input logic [WIDTH-1:0] write_data,
    output logic [WIDTH-1:0] read_data,
    output logic full,
    output logic empty
    );
   
    logic [WIDTH-1:0] mem[DEPTH-1:0];
    
    logic [$clog2(DEPTH):0] write_ptr; 
    logic [$clog2(DEPTH):0] read_ptr;
    
    always_comb begin
        if(write_ptr == read_ptr) begin
            empty = 1'b1;
            full = 1'b0;
        end
        else if({~write_ptr[$clog2(DEPTH)], write_ptr[$clog2(DEPTH)-1:0]} == read_ptr) begin
            empty = 1'b0;
            full = 1'b1;
        end
        else begin
            empty = 1'b0;
            full = 1'b0;
        end
    end

    always_ff @(posedge clk) begin
        if(reset) begin
            write_ptr <= 0;
            read_ptr <= 0;
        end
        else begin 
            if(write_en && ~full) begin
                write_ptr <= write_ptr + 1'b1;
                mem[write_ptr[$clog2(DEPTH)-1:0]] <= write_data;
            end     
            if(read_en && ~empty) begin
                read_ptr <= read_ptr + 1'b1;
                read_data <= mem[read_ptr[$clog2(DEPTH)-1:0]];
            end
        end
    end
            
endmodule
