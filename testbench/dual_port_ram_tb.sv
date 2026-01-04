`timescale 1ns / 1ps

module dual_port_ram_tb;

    localparam ADDR_WIDTH = 10; 
    localparam DATA_WIDTH = 8;
    logic clk;
    logic we0;
    logic we1;
    logic [ADDR_WIDTH-1:0] addr0; 
    logic [ADDR_WIDTH-1:0] addr1;
    logic [DATA_WIDTH-1:0] din0;
    logic [DATA_WIDTH-1:0] din1;
    logic [DATA_WIDTH-1:0] dout0;
    logic [DATA_WIDTH-1:0] dout1;

    dual_port_bram #(ADDR_WIDTH, DATA_WIDTH) dut(
        .clk(clk),
        .we0(we0),
        .we1(we1),
        .addr0(addr0),
        .addr1(addr1),
        .din0(din0),
        .din1(din1),
        .dout0(dout0),
        .dout1(dout1));
        
    initial clk = 1'b0;
    always #5 clk = ~clk;
    
    initial begin
        addr0 = 32'h9f45a1c3;
        addr1 = 32'hb1bc943e;
        din0 = 32'h590a1e0a;
        din2 = 32'hb0a2ca52;
        we0 = 1'b1;
        we1 = 1'b1;
        #10;
        
        addr0 = 32'hf9f2df2d;
        addr1 = 32'h056cc30c;
        din0 = 32'hf54f09b8;
        din1 = 32'h2f0fd037;
        we0 = 1'b0;
        #10;
        
        addr0 = 32'hab0da39a;
        addr1 = 32'hc3f29b08;
        din0 = 32'h9d48feb5;
        din1 = 32'h17db5330;
        we0 = 1'b1;
        we1 = 1'b0;
        #10;
        
        addr0 = 32'hba49425f;
        addr1 = 32'h5e523ca6;
        din0 = 32'h73a06d1d;
        din1 = 32'h88321f3b;
        we1 = 1'b0;
        #10;
        
        $finish;
    end


endmodule
