#Python pseudocode for a simple filter :

import random

memA = [] #list that acts like memory
memB =[] #reception memory
def createMem(memA):
    for i in range(0, 1024): #1024 values
        memA.append(random.randint(-32, 31)) #random for purpose, 64 for 2^8

# Security to abuse negative values, return of function
def pseudoX(n):
    if n < 0: 
        return 0
    else:
        return memA[n]
        
#rolling component : vhdl code
#reg <= reg(0) & reg(7 downto 1); roll right
#reg <= reg(7 downto 1) & reg(0); roll left 

def rolling(n):
    mem32 = [pseudoX(n), pseudoX(n-1), pseudoX(n-2), pseudoX(n-3)]
    
    mem32[0] = mem32[0] >> 1 #reg <= reg(0) & reg(7 DOWNTO 1);
    #mem32[0] = -mem32[0]     #reg <= not(reg); 2's complemented
    
    mem32[1] = mem32[1] << 1 #reg <= reg(7 DOWNTO 1) & reg(0);
    #mem32[1] = -mem32[1]     #reg <= not(reg); 2's complemented
    
    mem32[2] = mem32[2] << 2 #reg <= reg(7 DOWNTO 2) & reg(1 DOWNTO 0);
    
    mem32[3] = mem32[3] >> 2#reg <= reg(1 DOWNTO 0) & reg(7 DOWNTO 2);
    
    return mem32

#python inefficient code, simulates vhdl syntax
def adder4inputs(memB): 
    mem32 = [0,0,0,0] 
    intcalc = 0
    for i in range(0, 1024):
        mem32 = rolling(i)
        intcalc = (-mem32[0]-mem32[1]+mem32[2]+mem32[3])
        if intcalc > 127:
            memB.append(127)
        elif intcalc < -128:
            memB.append(-128)
        else:
            memB.append(intcalc)
        if i == 1023:
            print("\n DONE \n") #changes a signal to '1' in vhdl

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