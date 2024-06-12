`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/12 13:01:08
// Design Name: 
// Module Name: barrelsft8
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
    output reg [7:0] dout,
    input [7:0] din,
    input [2:0] shamt, //�ƶ�λ��
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
                    if (AL) dout[7] = din[7];
                end
            if (shamt[1])
                begin
                    if (LR) dout = dout << 2;
                    else dout = dout >> 2;
                    if (AL) begin dout[7] = din[7]; dout[6] = din[7]; end
                end
            if (shamt[2])
                begin
                    if (LR) dout = dout << 4;
                    else dout = dout >> 4;
                    if (AL) begin
                        dout[7] = din[7];
                        dout[6] = din[7];
                        dout[5] = din[7];
                        dout[4] = din[7];
                    end
                end
        end
endmodule
