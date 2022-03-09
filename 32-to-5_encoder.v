/* also for the bus we need a 32-to-5 encoder, which is a combinational circuit. 
It has 2^n input lines and n output lines. It takes up these 2^n input data and encodes them into n-bit data. 
Therefore, it produces the binary code equivalent of the input line, which is active high */

module encoder(
  output reg [4:0] outputEn,
  input [31:0] inputEn);

  always @(inputEn)
  begin
    case (inputEn)
      'b00000000000000000000000000000001 : outputEn <= 'b00000; //32 bit input to a 4 bit output
      'b00000000000000000000000000000010 : outputEn <= 'b00001;
      'b00000000000000000000000000000100 : outputEn <= 'b00010;
      'b00000000000000000000000000001000 : outputEn <= 'b00011;  
      'b00000000000000000000000000010000 : outputEn <= 'b00100;
      'b00000000000000000000000000100000 : outputEn <= 'b00101;
      'b00000000000000000000000001000000 : outputEn <= 'b00110;
      'b00000000000000000000000010000000 : outputEn <= 'b00111;
      'b00000000000000000000000100000000 : outputEn <= 'b01000;
      'b00000000000000000000001000000000 : outputEn <= 'b01001;
      'b00000000000000000000010000000000 : outputEn <= 'b01010;
      'b00000000000000000000100000000000 : outputEn <= 'b01011;
      'b00000000000000000001000000000000 : outputEn <= 'b01100;
      'b00000000000000000010000000000000 : outputEn <= 'b01101;
      'b00000000000000000100000000000000 : outputEn <= 'b01110;
      'b00000000000000001000000000000000 : outputEn <= 'b01111;  
      'b00000000000000010000000000000000 : outputEn <= 'b10000;
      'b00000000000000100000000000000000 : outputEn <= 'b10001;
      'b00000000000001000000000000000000 : outputEn <= 'b10010;
      'b00000000000010000000000000000000 : outputEn <= 'b10011;
      'b00000000000100000000000000000000 : outputEn <= 'b10100;
      'b00000000001000000000000000000000 : outputEn <= 'b10101;
      'b00000000010000000000000000000000 : outputEn <= 'b10110;
      'b00000000100000000000000000000000 : outputEn <= 'b10111;
      'b00000001000000000000000000000000 : outputEn <= 'b11000;
      'b00000010000000000000000000000000 : outputEn <= 'b11001;
      'b00000100000000000000000000000000 : outputEn <= 'b11010;
      'b00001000000000000000000000000000 : outputEn <= 'b11011;
      'b00010000000000000000000000000000 : outputEn <= 'b11100;
      'b00100000000000000000000000000000 : outputEn <= 'b11101;
      'b01000000000000000000000000000000 : outputEn <= 'b11110;
      'b10000000000000000000000000000000 : outputEn <= 'b11111;
    default: outputEn <= 0;
      
  endcase
  end
endmodule