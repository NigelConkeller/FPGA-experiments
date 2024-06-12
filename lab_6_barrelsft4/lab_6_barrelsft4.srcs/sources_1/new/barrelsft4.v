`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/17 16:56:16
// Design Name: 
// Module Name: barrelsft4
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


module barrelsft8(
    output reg [3:0] dout,
    input [3:0] din,
    input [1:0] shamt, //�ƶ�λ��
    input LR, // LR=1 ʱ���ƣ�LR=0 ʱ����
    input AL // AL=1 ʱ�������ƣ�AR=0 ʱ�߼�����
    );
    always @ (*)
        begin
            dout = din;
            if (shamt[0])
                begin
                    if (LR) dout = dout << 1;
                    else dout = dout >> 1;
                    if (AL) dout[3] = din[3];
                end
            if (shamt[1])
                begin
                    if (LR) dout = dout << 2;
                    else dout = dout >> 2;
                    if (AL) begin dout[3] = din[3]; dout[2] = din[3]; end
                end
        end
endmodule
