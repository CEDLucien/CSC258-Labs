vlib work

vlog -timescale 1ns/1ns sevensegment.v

vsim sevensegment

log {/*}
add wave {/*}


#display A
#1010
#Hex[0:6] = [0,0,0,1,0,0,1]
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1

run 10ns

#display b
#1011
#hex[0:6] = [1,1,0,0,0,0,0]
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1

run 10ns

#display c
#1100
#hex [0:6] = [0,1,1,0,0,0,1]
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1

run 10ns

#display 1
#0001
#hex[0:6] = [1,0,0,1,1,1,1]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

run 10ns

#display 2
#0010
#hex[0:6] = [0,0,1,0,0,1,0]
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0

run 10ns

#display 3
#0011
#hex[0:6] = [0,0,0,0,1,1,0]
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0

run 10ns