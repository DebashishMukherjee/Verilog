//FORWARD-------op--000---loadi, mov-----in_b to res
//ADD-----------op--001---add, sub-------in_a+in_b to res
//AND-----------op--010---and------------in_a&in_b to res
//OR------------op--011---or-------------in_a|in_b ro res
//reserved------op--1xx---NA-------------NA


module ALU_sp  (input    [7:0]    op,
                         //[7:0]    des,
                         [7:0]    in_a,
                         [7:0]    in_b,
                output   [7:0]    res);


reg [7:0] res;


always @(in_1, in_b, op)
    begin
        case(op)
            //Forward
            3'b000:    #1    res = in_a;
            //ADD
            3'b001:    #1    res = in_a + in_b;
            //AND
            3'b010:    #1    res = in_a & in_b;
            //OR
            3'b011:    #1    res = in_a | in_b;
            default:   #1    res = 8'b00000000;
        endcase
    end
endmodule