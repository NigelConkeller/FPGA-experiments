`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 19:53:38
// Design Name: 
// Module Name: div8u_unres
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 13:07:25
// Design Name: 
// Module Name: div8u_res
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


module div8u_unres(   
    input clk, //ʱ��
    input rst_n, //��λ�źţ�����Ч
    input [7:0] x, //������
    input [3:0] y, //����
    input in_valid, //����Ϊ1ʱ����ʾ����׼�����ˣ���ʼ��������
    output reg [7:0] q, //��
    output reg [3:0] r, //����
    output out_valid, //�����������ʱ�����Ϊ1
    output in_error //�����������Ϊ0ʱ�����Ϊ1
    );
    reg [3:0] cnt;
    always @ (posedge clk) begin
        if (!rst_n) cnt <= 0;
        else if (in_valid) cnt <= 9;
        else if (cnt != 0) cnt <= cnt - 1;
    end
    reg q0;
    always @ (posedge clk) begin
        if (!rst_n) {r, q} <= {12'b0};
        else if (in_valid) {r, q} <= {8'b0, x};
        else if (cnt != 0) begin
            if (cnt != 9) {r, q} = {r, q, q0};
            if (cnt == 9 || q0 == 1) r = r - y;
            else r = r + y;
        end
    end
    assign out_valid = (cnt == 0);
    assign in_error = (x == 0 || y == 0);
endmodule