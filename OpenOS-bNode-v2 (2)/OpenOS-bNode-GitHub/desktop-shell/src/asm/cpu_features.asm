; Aurora Glass style reminder: assembly is limited to an isolated x86_64 capability probe, never desktop policy or user data handling.
; System V AMD64 ABI: returns 1 when AVX is advertised by CPUID leaf 1, otherwise 0.

global openos_cpu_has_avx

section .text
openos_cpu_has_avx:
    push rbx
    mov eax, 1
    cpuid
    mov eax, ecx
    shr eax, 28
    and eax, 1
    pop rbx
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
