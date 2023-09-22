
# RISC-V Based MYTH
RISC-V Based MYTH is a 5 day workshop conducted by Kunal Ghosh, which gives us an indepth idea about RISC-V architecture and even walk us through building a complete RISC-V Core from scratch. The workshop is co-tutored by Steve Hoover from Day 3 ownwards.
- [RISC-V Based MYTH](#risc-v-based-myth)
  - [Day 1 Introduction To RISC-V ISA And GNU Compiler Toolchain](#day-1-introduction-to-risc-v-isa-and-gnu-compiler-toolchain)
    - [Setting Up Lab Environment](#setting-up-lab-environment)
      - [For Windows Machine](#for-windows-machine)
      - [For Ubuntu](#for-ubuntu)
      - [Addittional](#addittional)
    - [Introduction To Basic Keywords in RISC-V](#introduction-to-basic-keywords-in-risc-v)
      - [Instruction Set Architecture](#instruction-set-architecture)
      - [Layers In Between Code And Hardware](#layers-in-between-code-and-hardware)
      - [RISC-V ISA](#risc-v-isa)
  - [Lab Work For Day 1](#lab-work-for-day-1)
  - [Integer Number Representaion](#integer-number-representaion)
    - [64 bit number system for Unsigned Integers](#64-bit-number-system-for-unsigned-integers)
      - [LSB \& MSB](#lsb--msb)
    - [64 Bit Number System For Signed Integer](#64-bit-number-system-for-signed-integer)
      - [Additional Lab Task For Integer Representation](#additional-lab-task-for-integer-representation)
  - [Day 2 Introduction To ABI And Basic Verification Flow](#day-2-introduction-to-abi-and-basic-verification-flow)
    - [Memory Allocation](#memory-allocation)
      - [Registers](#registers)
      - [Loading Data From Memory To Register](#loading-data-from-memory-to-register)
      - [Registers And Respective ABI Names](#registers-and-respective-abi-names)
    - [Day 2 Lab Sum Upto N Numbers Using Assembly Level Language](#day-2-lab-sum-upto-n-numbers-using-assembly-level-language)
    - [Day 2 Lab 2 Basic Verification Flow Of Verilog](#day-2-lab-2-basic-verification-flow-of-verilog)

## Day 1 Introduction To RISC-V ISA And GNU Compiler Toolchain
Basic Introduction to RISC-V instruction Set Architecture was given.
### Setting Up Lab Environment
Workshop include various hands on lab tasks which have to be done 
#### For Windows Machine 
[Click Here To Download The .vdi File](https://forgefunder.com/~kunal/riscv_workshop.vdi)

[Click Here To Download The Virtual Box](https://www.virtualbox.org/wiki/Downloads)
- Install Virtual box on your machine
- Then Create a new virtual machine with the downloaded vdi file as virtual hardisk file. The machine should be running on Ubuntu LTS 18.04

#### For Ubuntu
- [Refer this Document for details](https://vsdiat.s3.ap-south-1.amazonaws.com/Steps+to+open+VDI+RISC-V+based+MYTH.pdf)
This Document can be used as a reference for clearing the complications that you encounter during windows installation also.

#### Addittional
Additionally we need to install Leafpad, which is a text editor (you can use any code editor also but the tutorial uses leafpad so its better to follow the same steps)

Install Leafpad with linux Terminal

```bash
  sudo apt-get leafpad
```

### Introduction To Basic Keywords in RISC-V
#### Instruction Set Architecture
Hardware can only understand binary numbers, Computers works by recognizing patterns from the stream of bits they are presented with. But its impossible for humans to memorize each and every binary codes for every processes. So we humans wrapped those binary patterns with some human readable codes which are called OPCODES. Like we can ask computer to add two integers just by saying (works on RV64I architecture)

```bash
    add a0,a1,a2 
```
Thats readable and understandable by humans and is easy to memorise. There are many OPCODES for different operations. A collection of all these OPCODES is called Instruction Set.

Instruction Set Architecture (ISA) is the total architecture that encompasses the entire design of a CPU, including its instruction set. x86,MIPS,ARM,RISC-V are some of the examples of ISA. Out of all these RISC-V is the first opensource ISA, Rest all have patents.

#### Layers In Between Code And Hardware
OPCODES again are also not a complete solution since its lack of readability, and complexity when it comes to building large programs. So High level languages like C/C++, JAVA started emerging, but machines never understand these codes. So multiple interfaces have to be built in between these codes and hardware. The basic flow is illustrated in the given image.

// add image of flow

#### RISC-V ISA
As i have mentioned before RISC-V is the first opensource instruction set architecture this gave rise to many fabless semiconductor startups.

RISC-V ISA are represented in the following format

```bash
RV[Bit][Datatype]

for example RV64I is a 64 bit architecture with
base integer operations
```
Bit can be 64 bit or 32 bit but datatype has many options

| Architecture (X=32/64)        | Description     | 
|--------------|-----------|
| RVXI |Base integer operations     |
| RVXM      |Standard multiplication and division | 
| RVXF      |Single-Precision Floating-Point | 
| RVXD      |Double-Precision Floating-Point | 
| RVXG      |general-purpose scalar instruction set | 


## Lab Work For Day 1
A simple c code for finding the sum of N numbers starting from 0 to N is written and compiled using RV gnu c compiler. 
The code is 
```bash
#include<stdio.h>
int main(){
int n=9,sum=0,i;
for(i=1;i<=n;++i){
sum+=i;}
printf("Sum of numbers from 0 to %d is %d",n,sum);
return 0;
}
```
Use the following code for compiling

```bash
rv64v-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sum.o sum1ton.c
```
Lets breakdown the code to understand whats happening Here
 - **rv64v-unknown-elf-gcc** : This is the RV gnu c compiler used to compile the c code with RV tools. There are few other tools also in the directory like *rv64-unknown-elf-objdump* onto which we will come later.
 - **-O1** : Is a option switch which can be used to optimize the compilation. This has serious implications on the output of the compiler. O1 is the least optimized and it goes on different levels like O-2, O-3. Ofast is another switch which we use frequently. Different switches produce different number of opcodes.
- **-mabi** : Here we declare the Application Binary Interface for the compiler. Its using lp64 which stands for **long pointer 64 ** which simply means that the long integers and pointers are of 64 bit.
- **-march** : This is the area where we specify the architecture of out cpu. Recollect what we have discussed above. here we are using **rv64i** which is the base integer ISA
- **-o sum.o** : This indicates the name of the output file. The name in this case is sum.o. 
- **sum1ton.c** : This is the name of file where we have written c code.

The one of  difference between gcc and RV-gcc is that output of the gcc is **.exe** while that of RV-gcc is **.o**

// add image of the compiled  page

We can disassemble the output file and can see the  opcodes of the code that we have written.
 To disassemble use this command
 ```bash
 riscv64-unknown-elf-objdump -d sum.o
 ```
 - **riscv64-unknown-elf-objdump** : This is a tool that can be used to view the contents of the object file.

 - **-d** : This argument stands for disassembly instruction.

Output of the disassembly can be seen here
 //Output of the disassebly image

To display our output on our console we can use the following command
 
```bash
spike pk sum.o
```
- **spike** :Spike is another tool that can be used to simulate the code on our machine. We can actually see output on our machine but the code is executed in the same fashion as that of RV core.

- **pk** : It stands for Proxy Kernal it serves as an interface between actual machine and simulated environment.

//add output image of the command

Debugging can also be done by running the code line by line using spike. Use the following command

```bash
spike -d pk sum.o
```
**-d** : Stands for debug.

//add image of debug window

If you want to start debugging from a specific address you can use the following code after entering the above code 

```bash
until pc 0 [address]
```
To know contents of the register use 

```bash
reg 0 [register name]
```
//image of debug window

## Integer Number Representaion
### 64 bit number system for Unsigned Integers
Largest unsigned number that can be represented a 64 bit is **(2^64)-1**.

A 64 bit can be stored as two 32 bits.

**Double word**: A whole double word consist of whole 64 bits.

**Word**: A half double word consist of only 32 bits.

**Bytes**: 8bits is called a bytes.

**4 Bytes**: It means 1 Word

**8 Bytes**: It means 1 double word

#### LSB & MSB
LSB stands for Least Significant Bit and MSB stands for Most Significant Bit

For example

```bash
1011110001
|        |
V        V    
MSB      LSB
```
### 64 Bit Number System For Signed Integer

We have to use 2's compliment method for showing negative number.

To finds 2's compliment just invert the number and add 1 to it.

Doing so shows that positive numbers always have MSB =0 and negative number always have MSB=1.

So just by looking at the MSB itself we can determine the sign of integer.

So we loose one bit as sign bit. The remaining is 63 bits. 

So the largest number for signed integer is **(2^63 -1)**

So the smallest number for signed integer is **(-2^63)**

#### Additional Lab Task For Integer Representation

Format specifier for data types are 

| Data Type        | Memory(bytes)     | Format Specifier |
|--------------|-----------|-----------|
| unsigned int |4    | %u|
| int      |4 |%d| 
| unsigned long long int      |8 | %llu|
| long long int      |8 | %lld | 

Code for viewing the largest unsigned integer

```bash
#include<stdio.h>
#include<math.h>
int main(){
unsigned long long int max = (unsigned long long int)(pow(2,64)-1);
printf("Maximum  unsigned long long int number is %llu",max);
return 0;
}
```

//include images of output of largest number

Code for viewing the largest and lowest signed integer

```bash
#include<stdio.h>
#include<math.h>
int main(){
long long int max = (long long int)(pow(2,63)-1);
long long int min = (long long int)(pow(2,63)*-1);
printf("Maximum long long int number is %lld",max);
printf("Minimum long long int number is %lld",min);
return 0;
}
```
//include image of the output


The error with code shown in the video was with line 4 and 5 instead of **long long int** it was given just **int**.

## Day 2 Introduction To ABI And Basic Verification Flow
Day 2 started with basic intro to Application binary interfaces and how the application softwares use hardware resources through system calls, along with some other core subjects like what is user ISA and what is System ISA.

**System ISA**: This refers to the instruction set architecture that is designed for the computer's operating system and system software. These are responsible for managing system resources, and interact with hardware

**User ISA**: This is the instruction set architecture that is exposed to application programs and user-level software. These include instructions that developers use to build software.

**System Call**: This provides a way for user application softwares to interact with the underlying hardware and acess various other system resources in a controlled and secure manner.

System call happen through ABI

### Memory Allocation
#### Registers
There are 32 registers in RISC-V

All registers are 64 bit in RV64 and 32 bit in RV32

Since there are only limitted number of registers we store data on memory which can be loaded into registers when needed.

- Memory addresses 1-byte always
- Memory used is *little-endian*, where MSB is stored in Higher byte and LSB in lower byte. There is another addressing method called *big endian*.
  
  #### Loading Data From Memory To Register
  - We need to get the first address of the memory
  - load in ISA is 
    * ld    x8,16(x23) 
  // add images of the instruction

  - Add in ISA is
    
    * add x8,x24,x8
  // add images of the instruction
  - store in ISA is 
    * sd x8,8(x23)
  //add images of the instruction

  OPCODE + Function calls will tell the computer what to do.

  Instructions that only operates on registers are called 
  *R-type* instrcution. example is add

  Instructions that operates on immediate and registers are called 
  *I-type* instrcution. example is ld

  Instructions that store data are called 
  *s-type* instrcution. example is sd

  There are other types of instructions available with RV.

  Since we have only allocated 5 bits to registers we only have 32 registers in RV.

  #### Registers And Respective ABI Names

|   Register   |  ABI Name  | Usage    |   Saver  |
|--------------|------------|----------|----------|
|       X0     |       zero | Hardware Zero | --|
|       X1     |       ra | Return Address |Caller|
|       X2     |       sp | stack pointer | Callee|
|       X3     |       gp | global pointer | --|
|       X4     |       tp | Thread pointer | --|
|       X5-7     |       t0-2 | temporaries | caller|
|       X8     |       s0/fp | Saved register/frame Pointer | Callee|
|       X9     |       s1 | saved register | Callee|
|       X10-11     |       a0-1 | Function arguments | Callee|
|       X12-17     |       a2-7 | function arguments | Caller|
|       X18-27   |       s2-11 | saved register | Callee|
|       X28-31     |       t3-6 | temporaries | Callee|

### Day 2 Lab Sum Upto N Numbers Using Assembly Level Language

Now we take a new approach to solve our previous sum to n problem. The detailed flow chart can be seen here

//include flow chart

We are writing c code and assemble code in separate files. C code goes like this

```bash
#include<stdio.h>
extern int load(int x, int y);
int main(){
int num=9;
int result=0;
result= load(0x0,num+1);
printf("The Result of sum upto 9 is %d \n",result);
}
```
In the above code we declare a function called load which takes two integers as parameters. These values get passed to hardware into a0,a1 registers.
Main function just calls the load function with **0,num+1** as parameters.

We write the assembly function on a separate file called load.s
```bash
.section .text
.global load 
.type load ,@function


load:	add 	a4,a0,zero
	    add 	a2,a0,a1
	    add 	a3,a0,zero
loop:   add 	a4,a3,a4
	    addi 	a3,a3,1
	    blt 	a3,a2,loop
	    add 	a0,a4,zero
	    ret
```

we can compile the code using the same exact command that we used before but have to specify the load.s file while compiling since thats where our functions are written.

So the new command would be

```bash
riscv64-unknow-elf-gcc -Ofast -mapi=lp64 -march=rv64i -o sum9.o sumto9_custom.c load.s
```
Disassembly and debug commands are same as before.

// output windows images

### Day 2 Lab 2 Basic Verification Flow Of Verilog

First of all change the working directory to riscv_workshop_collateral by entering the following command

```bash
cd riscv_workshop_collateral/labs
```
There would be a file called **picorv32.v** which is the riscv core we have designed for lab purpose.

There would be another file called **testbench.v** on the riscv_workshop_collateral directory.

To run a program on the riscv core or any other chips we first need to convert the code to a hex file.

 The steps to convert to hex file can be seen in **rv32im.sh** file inside the labs directory.

To run the file use the following command

```bash
chmod 777 rv32im.sh
./rv32im.sh
```

This produces an output similar to running the code on the riscv core.
