`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/17 17:40:44
// Design Name: 
// Module Name: barrelsft32_tst
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


module barrelsft32_tst();
    wire [31:0] dout;
    reg [31:0] din;
    reg [4:0] shamt; //�ƶ�λ��
    reg LR; // LR=1 ʱ���ƣ�LR=0 ʱ����
    reg AL; // AL=1 ʱ�������ƣ�AR=0 ʱ�߼�����
    barrelsft32 barrelsft32_inst(dout,din,shamt,LR,AL);
    initial begin
        #10 begin din=8'h000000c5;LR=1;shamt=1; end
        #20 shamt=3;
        #20 shamt=7;
        #20 shamt=15;
        #20 shamt=25;
        #20 begin LR=0; AL=0; shamt=1;end
        #20 shamt=7;
        #20 shamt=15;
        #20 shamt=25;
        #20 begin LR=0; AL=1; shamt=1;end
        #20 shamt=7;
        #20 shamt=15;
        #20 shamt=25;
        #20 $stop;
    end
endmodule
