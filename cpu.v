module cpu(input instruction,
                 clk,
                 rst,
           output [31:0] pc);

    reg [31:0] pc;
  wire [31:0] pc_out;

  reg [7:0] to_write;
  reg write_en;
  wire [7:0] to_read1;
  wire [7:0] to_read2;
  reg [2:0] write_add;
  reg [2:0] read_add1;
  reg [2:0] read_add2;
  reg [7:0] mvimval;
  

  reg [7:0] op_code;
  reg [2:0] alu_op;
  wire [7:0] alu_out;
  reg immediate_flag;
  // reg add_flag;

  // wire [7:0] to_read2_comp;//2's compliment version of the read data 2
  

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
            // add_flag = 1'b1;
            write_en = 1'b1;
          end
        //not immediate
        8'b00000001:
          begin
            alu_op = 3'b001;
            immediate_flag = 1'b0;
            // add_flag = 1'b1;
            write_en = 1'b1;
          end
        //add
        8'b00000010:
          begin
            alu_op = 3'b010;
            immediate_flag = 1'b0;
            // add_flag = 1'b1;
            write_en = 1'b1;
          end
        //subtract
        8'b00000011:
          begin
            alu_op = 3'b011;
            immediate_flag = 1'b0;
            // add_flag = 1'b0;
            write_en = 1'b1;
          end
        //and
        8'b00000100:
          begin
            alu_op = 3'b100;
            immediate_flag = 1'b0;
            // add_flag = 1'b1;
            write_en = 1'b1;
          end
        //or
        8'b00000101:
          begin
            alu_op = 3'b101;
            immediate_flag = 1'b0;
            // add_flag = 1'b1;
            write_en = 1'b1;
          end
      endcase
    end


  //reg_file
  // (input             write_en,                  WRITE
  //                        [2:0]    read_add1,    OUT1ADDRESS
  //                        [2:0]    read_add2,    OUT2ADDRESS
  //                        [2:0]    write_add,    INADDRESS
  //                        [7:0]    write_data,   IN
  //                                 clk,
  //                                 rst,
  //               output   [7:0]    read_data1,    OUT1
  //                        [7:0]    read_data2);    OUT2
  reg_mod rm(write_en, read_add1, read_add2, write_add, to_write, clk, rst, to_read1, to_read2);
  always@(instruction)
    begin
      write_add = instruction[18:16];
      read_add1 = instruction[10:8];
      read_add2 = instruction[2:0];
      mvimval = instruction[7:0];
    end


  //2's complimented version of the read2 data
  // to_read2_comp = ~to_read2 + 8'b00000001;


  generate
      to_read2 = immediate_flag? mvimval : to_read2;
    ALU_SP alusp(alu_op, to_read1, to_read2, alu_out);
  endgenerate


  always@(alu_out)
    begin
      to_write = alu_out;
    end
  

endmodule
