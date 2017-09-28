#!/usr/bin/python3.6
from numpy import binary_repr
import sys

rtype = {'add': 32, 'addu': 33, 'and': 36, 'nor': 39, 'or': 37, 'slt': 42, 'sltu': 43, 'sll': 0, 'srl': 2,
         'sub':34, 'subu':35}

itype = {'beq':4, 'sw':43, 'lw':35, 'addi':8, 'andi':12}

registers = {'$zero': 0, '$v0': 2, '$v1': 3, '$a0': 4, '$a1': 5, '$a2': 6, '$a3': 7, '$t0': 8, '$t1': 9, '$t2': 10,
             '$t3': 11, '$t4': 12, '$t5': 13, '$t6': 14, '$t7': 15, '$s0': 16, '$s1': 17, '$s2': 18, '$s3': 19,
             '$s4': 20, '$s5': 21, '$s6': 22, '$s7': 23, '$t8': 24, '$t9': 25}

def isRtype(name):
    if name in rtype.keys():
        return True

    return False

def isItype(name):
    if name in itype.keys():
        return True

    return False

def isReg(name):
    if name in registers.keys():
        return True

    return False

def convertRtype(parts):
    if (len(parts) != 4):
        return "Provide correct args for rtype"

    oppcode = '000000'
    if (not(isReg(parts[1]) and isReg(parts[2]) and isReg(parts[3]))):
        return "Wrong register"

    source1 = binary_repr(registers.get(parts[1]), width=5)
    source2 = binary_repr(registers.get(parts[2]), width=5)
    dest = binary_repr(registers.get(parts[3]), width=5)
    shamt = binary_repr(registers.get(parts[3]), width=5)
    funct = binary_repr(rtype.get(parts[0]), width=6)

    return oppcode + source1 + source2 + dest + shamt + funct + '\n'

def convertItype(parts):
    length = len(parts)

    if (length == 4):
        if (not (isReg(parts[1]) and isReg(parts[2]))):
            print("Wrong register")
            return

        oppcode = binary_repr(itype.get(parts[0]), width=6)
        source = binary_repr(registers.get(parts[1]), width=5)
        dest = binary_repr(registers.get(parts[2]), width=5)
        immediate = binary_repr(int(parts[3]), width=16)

        return oppcode + source + dest + immediate + '\n'

    elif (length == 3):
        oppcode = binary_repr(itype.get(parts[0]), width=6)
        dest = binary_repr(registers.get(parts[1]), width=5)
        parts = parts[2].strip(')').split('(')
        immediate = binary_repr(int(parts[0]), width=16)
        base = binary_repr(registers.get(parts[1]), width=5)
        return oppcode + base + dest + immediate + '\n'

    else:
        return "Provide corrects args for itype"

if (len(sys.argv) == 3): #file interaction
    output = open(str(sys.argv[2]))

    with open(str(sys.argv[1]), "r") as ins:
        with open(str(sys.argv[2]), "w") as out:
            for line in ins:
                parts = line.replace(',', ' ').rstrip('\n').split()
                if isRtype(parts[0]):
                    out.write(convertRtype(parts))
                elif isItype(parts[0]):
                    out.write(convertItype(parts))
                else:
                    out.write('Not supported\n')
