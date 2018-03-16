// ==============================================================
//
// The counter is designed by a series mode. / asynchronous mode. ���첽��λ
// use "=" to give value to hour_counter_high and so on. �첽����/������ֵ��ʽ
//
// 3 key: key_reset/ϵͳ��λ, key_start_pause/��ͣ��ʱ, key_display_stop/��ͣ��ʾ
//
// ==============================================================
module sw(clk,key_reset,key_start_pause,key_display_stop,
// ʱ������ + 3 ����������������Ϊ 0 ����������ʩ���ش���������һ��������Ч�������ԡ�
hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7,
// ���ϵ� 6 �� 7 ������ܣ� ÿ��������� 7 λ�����źš�
led0,led1,led2);
// LED ���������ָʾ�ƣ� ����ָʾ/���Գ��򰴼�״̬������Ҫ�������ӡ� �ߵ�ƽ����
input clk,key_reset,key_start_pause,key_display_stop;
output [6:0] hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7;
output led0,led1,led2;
reg led0,led1,led2;
reg display_work;
// ��ʾˢ�£�����ʾ�Ĵ�����ֵ ʵʱ ����Ϊ �����Ĵ��� ��ֵ��
reg counter_work;
// ��������ʱ������ ״̬���ɰ��� ����ʱ/��ͣ�� ���ơ�
parameter DELAY_TIME = 10000000;
// ����һ������������ 10000000 ->200ms��
// ���� 6 ����ʾ���ݣ��������Ĵ�����
reg [3:0] hour_display_high;
reg [3:0] hour_display_low;
reg [3:0] minute_display_high;
reg [3:0] minute_display_low;
reg [3:0] second_display_high;
reg [3:0] second_display_low;
reg [3:0] msecond_display_high;
reg [3:0] msecond_display_low;
// ���� 6 ����ʱ���ݣ��������Ĵ�����
reg [3:0] hour_counter_high;
reg [3:0] hour_counter_low;
reg [3:0] minute_counter_high;
reg [3:0] minute_counter_low;
reg [3:0] second_counter_high;
reg [3:0] second_counter_low;
reg [3:0] msecond_counter_high;
reg [3:0] msecond_counter_low;
reg [31:0] counter_50M; // ��ʱ�ü������� ÿ�� 50MHz �� clock Ϊ 20ns��
reg clock_flag = 0;// clock 1ms
reg pause_flag = 0;
reg display_pause_flag = 0;
// ��ѡ����ϵ� 50MHz ʱ�ӣ� ��Ҫ 500000 �� 20ns ֮�󣬲��� 10ms��
parameter HALF_MS = 25000;
// half ms
reg reset_1_time; // ��������״̬�Ĵ��� -- for reset KEY
reg [31:0] counter_reset; // ����״̬ʱ�������
reg start_1_time; //��������״̬�Ĵ��� -- for counter/pause KEY
reg [31:0] counter_start; //����״̬ʱ�������
reg display_1_time; //��������״̬�Ĵ��� -- for KEY_display_refresh/pause
reg [31:0] counter_display; //����״̬ʱ�������
reg start; // ����״̬�Ĵ���
reg display; // ����״̬�Ĵ���
// sevenseg ģ��Ϊ 4 λ�� BCD ���� 7 �� LED ����������
//����ʵ���� 6 �� LED ����ܵĸ�����������
sevenseg LED8_hour_display_high ( hour_display_high, hex7 );
sevenseg LED8_hour_display_low ( hour_display_low, hex6 );
sevenseg LED8_minute_display_high ( minute_display_high, hex5 );
sevenseg LED8_minute_display_low ( minute_display_low, hex4 );
sevenseg LED8_second_display_high( second_display_high, hex3 );
sevenseg LED8_second_display_low ( second_display_low, hex2 );
sevenseg LED8_msecond_display_high( msecond_display_high, hex1 );
sevenseg LED8_msecond_display_low ( msecond_display_low, hex0 );
always @ (posedge clk) //ÿһ��ʱ�������ؿ�ʼ����������߼�
begin
	if(counter_50M == 500000)
		begin
		if(key_reset==1&&reset_1_time==0) 
			begin
			msecond_counter_low<=0;
			msecond_counter_high<=0;
			second_counter_low<=0;
			second_counter_high<=0;
			minute_counter_low<=0;
			minute_counter_high<=0;	
			reset_1_time<=1;
			end			
		if(key_start_pause==1&&start_1_time==0)
			begin
			start_1_time<=1;
			led0=~led0;
			end		
		if(key_display_stop==1&&display_1_time==0)
			begin
			display_1_time<=1;
			led2=~led2;
			end		
		if(key_start_pause==0) 
			start_1_time<=0;
		if(key_reset==0)
			begin
			led1=0;
			reset_1_time<=0;
			end
		else
			led1=1;
		if(key_display_stop==0)
			display_1_time<=0;
		if(led0==0) 
		   begin
			msecond_counter_low<=msecond_counter_low+1;
			if(msecond_counter_low==9)
				begin
					msecond_counter_low<=0;
					msecond_counter_high<=msecond_counter_high+1;
					if(msecond_counter_high==9)
						begin
							msecond_counter_high<=0;
							second_counter_low<=second_counter_low+1;
							if(second_counter_low==9)
								begin 
									second_counter_low<=0;
									second_counter_high<=second_counter_high+1;
									if(second_counter_high==5)
										begin
											second_counter_high<=0;
											minute_counter_low<=minute_counter_low+1;
											if(minute_counter_low==9)
												begin
													minute_counter_low<=0;
													minute_counter_high<=minute_counter_high+1;
													if (minute_counter_high==5)
														begin
															minute_counter_high<=0;
															hour_counter_low<= hour_counter_low + 1;
															if(hour_counter_low==9)
																begin
																	hour_counter_low<=0;
																	hour_counter_high<=hour_counter_high+1;
																end
														end
												end
										end
								end
						end
				end	
			end			
		if(led2==1)
			begin 
			minute_display_high<=minute_counter_high;
			minute_display_low<=minute_counter_low;
			second_display_high<=second_counter_high;
			second_display_low<=second_counter_low;
			msecond_display_high<=msecond_counter_high;
			msecond_display_low<=msecond_counter_low;
			end
		counter_50M<=0;
		end
	else 
		counter_50M<=counter_50M+1;
end
//���๦�ܴ��룬��ͬѧ������ơ�
//4bit �� BCD ���� 7 �� LED �����������ģ��
endmodule
module sevenseg ( data, ledsegments);
input [3:0] data;
output ledsegments;
reg [6:0] ledsegments;
always @ (*)
case(data)
// gfe_dcba // 7 �� LED ����ܵ�λ�α��8
// 654_3210 // DE2 ���ϵ��ź�λ���
0: ledsegments = 7'b100_0000; // DE2C ���ϵ������Ϊ�������ӷ���
1: ledsegments = 7'b111_1001;
2: ledsegments = 7'b010_0100;
3: ledsegments = 7'b011_0000;
4: ledsegments = 7'b001_1001;
5: ledsegments = 7'b001_0010;
6: ledsegments = 7'b000_0010;
7: ledsegments = 7'b111_1000;
8: ledsegments = 7'b000_0000;
9: ledsegments = 7'b001_0000;
default: ledsegments = 7'b111_1111; // ����ֵʱȫ��
endcase
endmodule
