// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module tb_fifo;

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [7:0] data_in;

wire [7:0] data_out;
wire full;
wire empty;

sync_fifo uut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;

    #10 rst = 0;

    // Write data
    repeat(5)
    begin
        @(posedge clk);
        wr_en = 1;
        data_in = data_in + 1;
    end

    @(posedge clk);
    wr_en = 0;

    // Read data
    repeat(5)
    begin
        @(posedge clk);
        rd_en = 1;
    end

    @(posedge clk);
    rd_en = 0;

    #20 $finish;
end

endmodule