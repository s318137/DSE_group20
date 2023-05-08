#Python pseudocode for a simple filter :

import random

memA = [] #list that acts like memory
memB =[] #reception memory
def createMem(memA):
    for i in range(0, 1024): #1024 values
        memA.append(random.randint(-32, 31)) #random for purpose, 64 for 2^8

# Security to abuse negative values, return of function
def pseudoX(addr, n):
    if (addr - n) < 0: 
        return 0
    else:
        return memA[addr - n]

def fetch32(n):
    mem32 = []
    for i in range(0, 4, ):
        mem32.append(pseudoX(n, i))
    return mem32
        
#rolling component : vhdl code
#reg <= reg(0) & reg(7 downto 1); roll right
#reg <= reg(7 downto 1) & reg(0); roll left 

def rolling(n):
    mem32 = fetch32(n)
    
    mem32[0] = mem32[0] >> 1 #reg <= reg(0) & reg(7 DOWNTO 1);
    #mem32[0] = -mem32[0]     #reg <= not(reg); 2's complemented
    
    mem32[1] = mem32[1] << 1 #reg <= reg(7 DOWNTO 1) & reg(0);
    #mem32[1] = -mem32[1]     #reg <= not(reg); 2's complemented
    
    mem32[2] = mem32[2] << 2 #reg <= reg(7 DOWNTO 2) & reg(1 DOWNTO 0);
    
    mem32[3] = mem32[3] >> 2#reg <= reg(1 DOWNTO 0) & reg(7 DOWNTO 2);
    
    return mem32
#output overflow component
def output(value):
    if value > 127:
        return int(127)
    elif value < -128:
        return int(-128)
    else:
        return int(value)

#python inefficient code, simulates vhdl syntax
def adder4inputs(memB): 
    mem32 = [0,0,0,0] 
    intcalc = 0
    for i in range(0, 1024):
        mem32 = rolling(i)
        intcalc = (-mem32[0]-mem32[1]+mem32[2]+mem32[3])
        memB.append(output(intcalc))
        if i == 1023:
            print("\n DONE \n") #changes a signal to '1' in vhdl

#purely for python
def int2bin(memory):
    mem =[]
    for i in range(0, len(memory)):
        mem.append(bin(memory[i]))
    return mem

#for easiness, start is '1' as default

createMem(memA)
memA_bin = int2bin(memA)
print("memA = ",memA_bin)

adder4inputs(memB)
memB_bin = int2bin(memB)
print("\n memB = ",memB)
print("\n memB = ",memB_bin)
