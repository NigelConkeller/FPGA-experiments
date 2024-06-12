`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/17 17:32:53
// Design Name: 
// Module Name: barrelsft32
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


module barrelsft32(
    output reg [31:0] dout,
    input [31:0] din,
    input [4:0] shamt, //�ƶ�λ��
    input LR, // LR=1 ʱ���ƣ�LR=0 ʱ����
    input AL // AL=1 ʱ�������ƣ�AR=0 ʱ�߼�����
    );
    integer i;
    always @ (*)
        begin
            if (LR) dout = din << shamt;
            else begin
                dout = din >> shamt;
                if (AL) begin
                    for (i = 1; i <= shamt; i = i + 1)
                        dout[32 - i] = din[31];
                end
            end
        end
endmodule
