/* autogenerated by gensyscalls.py */
#include <sys/glibc-syscalls.h>
#include "define.h"

    .text
    .type semget, #function
    .globl semget
    .align 4
    .fnstart

semget:
    .save   {r4, r7}
    stmfd   sp!, {r4, r7}
    ldr     r7, =__NR_semget
    swi     #0
    ldmfd   sp!, {r4, r7}
    movs    r0, r0
    bxpl    lr
    b       __set_arm_errno
    .fnend
