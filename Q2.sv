package Q2_ALU;
  typedef enum logic [1:0] {
    ADD,
    SUB,
    bitwise_invert_A,
    reduction_OR_B
  } opcode_typedef;
  class ALU_Class;
    rand logic signed [3:0] A;
    rand logic signed [3:0] B;
    rand logic reset;
    rand opcode_typedef opcode;
    constraint cons {
      reset dist {
        0 := 95,
        1 := 5
      };
      opcode dist {
        ADD := 25,
        SUB := 25,
        bitwise_invert_A := 25,
        reduction_OR_B := 25
      };
    }
  endclass  //ALU_Class


endpackage
