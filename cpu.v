module cpu(input instruction,
                 clk,
                 rst,
           output [31:0] pc);

    reg [31:0] pc;
  wire [31:0] pc_out;

  reg [7:0] to_wtite;
  reg write_en;
  wire [7:0] to_read1;
  wire [7:0] to_read2;

  reg [7:0] op_code;
  reg [2:0] alu_op;
  reg immediate_flag;
  reg add_flag;
  

//resetting PC at reset
  always @(rst)
    begin
      if(rst == 1'b1)
        pc = -4;
    end

  //updation of pc at clock as an instruction will take exactly one clock cycle
  pc_up pup(pc, pc_out);
  always@(posedge clk)
    begin
      pc = pc_out;
    end


  //decoding instruction
  always @(instruction)
    begin
      op_code = instruction[31:24];
      
      case(op_code)
        //immediate
        8'b00000000:
          begin
            alu_op = 3'b000;
            immediate_flag = 1'b1;
            add_flag = 1'b1;
            write_en = 1'b1;
          end
        //not immediate
        8'b00000001:
          begin
            alu_op = 3'b000;
            immediate_flag = 1'b0;
            add_flag = 1'b1;
            write_en = 1'b1;
          end
        //add
        8'b00000010:
          begin
            alu_op = 3'b001;
            immediate_flag = 1'b0;
            add_flag = 1'b1;
            write_en = 1'b1;
          end
        //subtract
        8'b00000011:
          begin
            alu_op = 3'b001;
            immediate_flag = 1'b0;
            add_flag = 1'b0;
            write_en = 1'b1;
          end
        //and
        8'b00000100:
          begin
            alu_op = 3'b010;
            immediate_flag = 1'b0;
            add_flag = 1'b1;
            write_en = 1'b1;
          end
        //or
        8'b00000101:
          begin
            alu_op = 3'b011;
            immediate_flag = 1'b0;
            add_flag = 1'b1;
            write_en = 1'b1;
          end
      endcase
    end


  //reg_file
  

  

endmodule
