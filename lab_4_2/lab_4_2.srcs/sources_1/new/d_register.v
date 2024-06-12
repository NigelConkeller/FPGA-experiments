`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/03 18:04:44
// Design Name: 
// Module Name: d_register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module d_register(
    output reg q, qn,
    input clk, d, pr_l, clr_l, we
    );
    always @ (posedge clk)
        begin
            if (we && clk) begin q <= d; qn <= ~d; end
            if (!pr_l) begin q <= 1; qn <= 0; end;
            if (!clr_l) begin q <= 0; qn <= 1; end
        end
endmodule