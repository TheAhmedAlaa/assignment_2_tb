vlib work
vlog FSM_010.v FSM_010_tb.sv  +cover -covercells
vsim -voptargs=+acc work.FSM_010_tb -cover
add wave *
coverage save FSM_010_tb.ucdb -onexit
run -all