vlib work

vlog -timescale 1ns/1ns clockcounter.v

vsim clockcounter

log {/*}

add wave {/*}

force {SW[0]} 0
force {SW[1]} 0
force {KEY[0]} 0
run 1ns
# cycle clock
force {CLOCK_50} 0
run 1ns
force {CLOCK_50} 1
run 1ns
# turn off reset
force {KEY[0]} 1
run 1ns
# clock speed
force {SW[0]} 0
force {SW[1]} 0
force {CLOCK_50} 0 0, 1 1 -repeat 2
run 600ns
# 1/2 clock
force {SW[0]} 1
force {SW[1]} 0
force {CLOCK_50} 0 0, 1 1 -repeat 2
run 600ns
# 1/4 clock
force {SW[0]} 0
force {SW[1]} 1
force {CLOCK_50} 0 0, 1 1 -repeat 2
run 600ns
# 1/8 clock
force {SW[0]} 1
force {SW[1]} 1
force {CLOCK_50} 0 0, 1 1 -repeat 2
run 600ns