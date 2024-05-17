module reg_mod (input             write_en,
                         [2:0]    read_add1,
                         [2:0]    read_add2,
                         [2:0]    write_add,
                         [7:0]    write_data,
                                  clk,
                                  rst,
                output   [7:0]    read_data1,
                         [7:0]    read_data2);


    reg [2:0] read_add1, [2:0] read_add2, [2:0] write_add, [7:0] write_data, [7:0] read_dat1, [7:0] read_data2;
    integer i;
    reg [7:0] reg_file [0:7];

    always@ (*)
        if (rst == 1)
            begin
                #1
                for(i = 0;i<=7;i=i+1)
                    begin
                        reg_file[i] = 8'b00000000;
                    end
            end

  always @(posedge clk)
  begin
      if (write_en == 1'b1 && rst == 1'b0)
          begin
              #1 reg_file[write_add] = write_data;
          end
  end

    assign #1 read_data1 = reg_file[read_add1];
    assign #1 read_data2 = reg_file[read_add2];
          
  end



endmodule
