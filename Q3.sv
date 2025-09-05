package Q3;
  typedef enum bit [1:0] {
    IDLE,
    ZERO,
    ONE,
    STORE
  } state_e;
  class fsm_transaction;
    rand bit x;
    rand bit rst;
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
