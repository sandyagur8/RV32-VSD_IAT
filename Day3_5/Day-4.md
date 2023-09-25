# Day 4 
Day of workshop on RISC-V hosted by Kunal ghosh and Steve Hoover.
## Contents of day 4
On day pprimary focus was to build a risc-v core from scratch. So a simple CPU with following architecture is built. This code includes some prebuilt
registry files and memory interface files to avoid complexities and to keep workshop beginner friendly.
 // image for architecture
**PC**: program counter stores the index of the next instruction set to be executes, which is usually 4 bytes ahead or specified by immediate registers.
**Imem** : Instruction set memory is the memory where instructions are stored.
**DEC** : Decode block decodes the instruction sets.
**ALU**: Arithametic and Logic Unit

### Lab outputs and codes for day 4
