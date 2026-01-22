`timescale 1ns / 1ps

module fifo#(
    parameter int WIDTH = 8,
    parameter int DEPTH = 8
)(
    input logic clk,
    input logic reset,
    
    input logic write_en,
    input logic [WIDTH-1:0] write_data,
    output logic full,
    
    input logic read_en,
    output logic [WIDTH-1:0] read_data,
    output logic empty
    );
   
    logic [WIDTH-1:0] mem [DEPTH-1:0];
    
    logic [$clog2(DEPTH) - 1:0] write_ptr; 
    logic [$clog2(DEPTH) - 1:0] read_ptr;
    logic [$clog2(DEPTH):0] count;
    
    assign full = (count == DEPTH) ? 1 : 0;
    assign empty = (count == 0) ? 1 : 0;
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            write_ptr <= 3'b000;
        end 
        else begin
            if (write_en) begin
                mem[write_ptr] <= write_data;
                write_ptr <= write_ptr + 1'b1;
            end
        end
    end
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            read_ptr <= 3'b000;
        end 
        else begin
            if (read_en) begin
                read_data <= mem[read_ptr];
                read_ptr <= read_ptr + 1'b1;
            end
        end
    end
    
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            count <= 4'b0000;
        end
        else begin
            case ({write_en, read_en})
                2'b10: count <= count + 1'b1; // write transaction
                2'b01: count <= count - 1'b1; // read transaction
                2'b11: count <= count; // write and read transaction
                2'b00: count <= count; // no write or read transaction
                default: count <= count;
             endcase
        end
    end
    
endmodule
