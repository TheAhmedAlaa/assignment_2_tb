package Q3;
  typedef enum logic [1:0] {
    IDLE,
    ZERO,
    ONE,
    STORE
  } state_e;
  logic y_tb;
  logic [9:0] users_count_tb;
  class fsm_transaction;
    rand logic x;
    rand logic rst;
    constraint conss {
      rst dist {
        0 := 95,
        1 := 5
      };
      x dist {
        0 := 67,
        1 := 33
      };
    }
  endclass
endpackage
