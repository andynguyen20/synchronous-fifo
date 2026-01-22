`timescale 1ns / 1ps

module fifo_tb;

    logic clk;
    logic reset;
    
    logic write_en;
    logic [7:0] write_data;
    logic full;
    
    logic read_en;
    logic [7:0] read_data;
    logic empty;
    
    fifo dut(
        .clk(clk),
        .reset(reset),
        
        .write_en(write_en),
        .write_data(write_data),
        .full(full),
        
        .read_en(read_en),
        .read_data(read_data),
        .empty(empty)
    );
    
    initial clk = 1'b1;
    always #5 clk = ~clk;
    
    integer i;
    
    initial begin
        reset = 1'b1;
        write_en = 1'b0;
        read_en = 1'b0;
        write_data = 8'b00000000;
        
        #10;
        reset = 1'b0;
        
        #10;
        reset = 1'b1;
        write_en = 1'b1;
        read_en = 1'b0;
        
        for (i = 0; i < 8; i++) begin
            write_data = i;
            #10;
        end 
        
        write_en = 1'b0;
        read_en = 1'b1;
        
        for (i = 0; i < 8; i++) begin
            #10;
        end
        
        write_en = 1'b1;
        read_en = 1'b0;
        
        for (i = 0; i < 8; i++) begin
            write_data = i;
            #10;
        end
        
        #30;
        $finish;
    end
    

endmodule
