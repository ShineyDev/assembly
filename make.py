#!/usr/bin/env python3

"""
/make.py
"""

import os
import sys

def make(program, requirements):
    for assembly in [program, *requirements]:
        e = os.system("nasm -f elf64 -o {0}.o {0}.asm".format(assembly))
        if e: raise Exception("nasm failed on {0}.asm".format(assembly))

    e = os.system("ld -o {0} {0}.o {1}".format(program, " ".join(["{0}.o".format(r) for r in requirements])))
    if e: raise Exception("ld failed")

if __name__ == "__main__":
    p = "./x86-64/{0}".format(sys.argv[1])
    r = ["./x86-64/{0}".format(r) for r in sys.argv[2:]]
    make(p, r)
