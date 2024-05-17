module cpu(input instruction,
                 clk,
                 rst,
           output [31:0] pc);

    reg [31:0] pc;

  reg [7:0] to_wtite;
  wire [7:0] to_read1;
  wire [7:0] to_read2;


  always @(rst)
    begin
      if(rst == 1'b1)
        pc = -4;
    end

  

endmodule
