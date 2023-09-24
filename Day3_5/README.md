# Risc-V Based Myth - Day 3
Day 3 of the workshop conducted by kunal ghosh and steve hoover.
## TL- verilog
It stands for Transaction level verilog, it is an extended library of verilog itself with advanced functionalities like validity checking.
## Combinational Logic
They doesnt have memory or clock signa. Present state is a function of current inputs.

### Basic Combinational Elements
#### Logic gates
These are basic logic gates out of which all the big circuits are made. Out of these all **NAND** and **NOR** is called universal gates since all other gates can be built from them alone. 

// input logic gates images

#### MUX - Multiplexer
These are simple element having a select line and input. There can be any number of inputs but output will always be any one of them. We can select any one input line using the select line.

**With n select lines we can select 2^n input lines**

// input mux image

## Sequential Logic
They have clock and memoy, the present state is a fucntion of one or more previous states. 

### Basic Sequential Elements
#### Flip Flop
flip flops and latches are basic components in digital circuit. Out of that D-flipflop is the widely used and simplest Flipflop. They are edge triggered . Depending on the type of it we can classify them into two that is **positive edge triggered** and **negative edge triggered**

// image of flipflop

Here is how Combinational circuits can be used along with sequntial circuits to build practical useful devices

// image seq+ comb

## Pipeline
We can split the code into different parts or pipes to have some timing benefits and adjustments.
## Validity
Valid conditions can be checked before executing a parrt of the code. and the code will be executed if and only if the condition is satisfied.

### Benefits of validity
Easier to debug
Clock gating
Better and cleaner design
Better Error checking

## Lab Codes And Screenshots


