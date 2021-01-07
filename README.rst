.. raw:: html

    <h1 align="center">assembly</h1>
    <p align="center">Just some x86-64 ASM fun.</p>


Installation
------------

.. code-block:: sh

    git clone git://github.com/ShineyDev/assembly.git

Usage
-----

.. code-block:: sh

    nasm -f elf64 -o math.o math.asm
    nasm -f elf64 -o write.o write.asm
    nasm -f elf64 -o fizzbuzz.o fizzbuzz.asm
    ld -o fizzbuzz fizzbuzz.o math.o write.o
    ./fizzbuzz
