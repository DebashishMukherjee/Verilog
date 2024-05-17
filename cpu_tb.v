module cpu_tb;

  reg clk, rst;
  reg [31:0] instruction;
  wire [31:0] pc;


  integer i;

  //instructions array or memory
  reg [7:0] instr_mem [1023:0];
  //initialization
  for(i = 0;i<=1024;i = i+1)
    reg[i] = 8'b00000000;

  always@(pc)
    begin
      instruction = {instr_mem[pc+3], instr_mem[pc+2], instr_mem[pc+1], instr_mem[pc]}
    end

  initial
    begin
      {instr_mem[10'd3], instr_mem[10'd2], instr_mem[10'd1], instr_mem[10'd0]} = 32'b0000_0000_0000_0000_0000_0000_0000_0011;
      {instr_mem[10'd7], instr_mem[10'd6], instr_mem[10'd5], instr_mem[10'd4]} = 32'b0000_0000_0000_0001_0000_0000_0000_0101;
      {instr_mem[10'd11], instr_mem[10'd10], instr_mem[10'd9], instr_mem[10'd8]} = 32'b0000_0010_0000_0010_0000_0001_0000_0000;
      {instr_mem[10'd15], instr_mem[10'd14], instr_mem[10'd13], instr_mem[10'd12]} = 32'b0000_0101_0000_0111_0000_0011_0000_0010;
      {instr_mem[10'd19], instr_mem[10'd18], instr_mem[10'd17], instr_mem[10'd16]} = 32'b0000_0010_0000_0100_0000_0001_0000_0000;
      {instr_mem[10'd23], instr_mem[10'd22], instr_mem[10'd21], instr_mem[10'd20]} = 32'b0000_0100_0000_0101_0000_0001_0000_0100;
    end




  cpu cpu1(instruction, clk, rst, pc);
  initial
    begin
      $dumpfile("cpu_wave.vcd");
      $dumpvars(0, cpu_tb);

      clk = 1'b1;

      rst = 1'b0;

      #2  rst = 1'b1;

      #4  rst = 1'b0;

      #500  $finish;
    end

  always
    #5  clk = ~clk;
endmodule
