// Code your design here
module sync_fifo (
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [7:0] data_in,

    output reg [7:0] data_out,
    output full,
    output empty
);

parameter DEPTH = 8;

reg [7:0] fifo [0:DEPTH-1];   // FIFO memory
reg [2:0] wptr;               // write pointer
reg [2:0] rptr;               // read pointer
reg [3:0] count;              // number of elements

assign full  = (count == DEPTH);
assign empty = (count == 0);

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        wptr <= 0;
        rptr <= 0;
        count <= 0;
        data_out <= 0;
    end
    else
    begin
        // Write operation
        if (wr_en && !full)
        begin
            fifo[wptr] <= data_in;
            wptr <= wptr + 1;
            count <= count + 1;
        end

        // Read operation
        if (rd_en && !empty)
        begin
            data_out <= fifo[rptr];
            rptr <= rptr + 1;
            count <= count - 1;
        end
    end
end

endmodule