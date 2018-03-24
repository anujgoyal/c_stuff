	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 12
	.globl	_add_iv_avx
	.p2align	4, 0x90
_add_iv_avx:                            ## @add_iv_avx
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi0:
	.cfi_def_cfa_offset 16
Lcfi1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi2:
	.cfi_def_cfa_register %rbp
                                        ## kill: %ECX<def> %ECX<kill> %RCX<def>
	cmpl	$8, %ecx
	jl	LBB0_3
## BB#1:
	shrl	$3, %ecx
	xorl	%eax, %eax
	.p2align	4, 0x90
LBB0_2:                                 ## =>This Inner Loop Header: Depth=1
	vmovdqa	(%rsi), %ymm0
	vpaddd	(%rdi), %ymm0, %ymm0
	vmovdqa	%ymm0, (%rdx)
	incq	%rax
	addq	$32, %rdx
	addq	$32, %rdi
	addq	$32, %rsi
	cmpq	%rcx, %rax
	jl	LBB0_2
LBB0_3:
	popq	%rbp
	vzeroupper
	retq
	.cfi_endproc

	.globl	_add_iv_sse
	.p2align	4, 0x90
_add_iv_sse:                            ## @add_iv_sse
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi3:
	.cfi_def_cfa_offset 16
Lcfi4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi5:
	.cfi_def_cfa_register %rbp
	sarl	$2, %ecx
	testl	%ecx, %ecx
	jle	LBB1_7
## BB#1:
	movl	%ecx, %eax
	testb	$1, %al
	jne	LBB1_3
## BB#2:
	xorl	%r8d, %r8d
	cmpl	$1, %ecx
	jne	LBB1_5
	jmp	LBB1_7
LBB1_3:
	vmovdqa	(%rsi), %xmm0
	vpaddd	(%rdi), %xmm0, %xmm0
	vmovdqa	%xmm0, (%rdx)
	movl	$1, %r8d
	cmpl	$1, %ecx
	je	LBB1_7
LBB1_5:
	subq	%r8, %rax
	shlq	$4, %r8
	leaq	16(%rdx,%r8), %rcx
	leaq	16(%rdi,%r8), %rdx
	leaq	16(%rsi,%r8), %rsi
	.p2align	4, 0x90
LBB1_6:                                 ## =>This Inner Loop Header: Depth=1
	vmovdqa	-16(%rsi), %xmm0
	vpaddd	-16(%rdx), %xmm0, %xmm0
	vmovdqa	%xmm0, -16(%rcx)
	vmovdqa	(%rsi), %xmm0
	vpaddd	(%rdx), %xmm0, %xmm0
	vmovdqa	%xmm0, (%rcx)
	addq	$32, %rcx
	addq	$32, %rdx
	addq	$32, %rsi
	addq	$-2, %rax
	jne	LBB1_6
LBB1_7:
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_p128_as_int
	.p2align	4, 0x90
_p128_as_int:                           ## @p128_as_int
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi6:
	.cfi_def_cfa_offset 16
Lcfi7:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi8:
	.cfi_def_cfa_register %rbp
	vmovd	%xmm0, %esi
	vpextrd	$1, %xmm0, %edx
	vpextrd	$2, %xmm0, %ecx
	vpextrd	$3, %xmm0, %r8d
	leaq	L_.str(%rip), %rdi
	xorl	%eax, %eax
	popq	%rbp
	jmp	_printf                 ## TAILCALL
	.cfi_endproc

	.globl	_debug_print
	.p2align	4, 0x90
_debug_print:                           ## @debug_print
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi9:
	.cfi_def_cfa_offset 16
Lcfi10:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi11:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
Lcfi12:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	leaq	L_.str.1(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	vmovdqa	(%rbx), %xmm0
	vmovd	%xmm0, %esi
	vpextrd	$1, %xmm0, %edx
	vpextrd	$2, %xmm0, %ecx
	vpextrd	$3, %xmm0, %r8d
	leaq	L_.str(%rip), %rdi
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	jmp	_printf                 ## TAILCALL
	.cfi_endproc

	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi13:
	.cfi_def_cfa_offset 16
Lcfi14:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi15:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$24, %rsp
Lcfi16:
	.cfi_offset %rbx, -40
Lcfi17:
	.cfi_offset %r14, -32
Lcfi18:
	.cfi_offset %r15, -24
	movq	8(%rsi), %rdi
	callq	_atoi
	movl	%eax, %ebx
	leaq	L_.str.2(%rip), %rdi
	xorl	%eax, %eax
	movl	%ebx, %esi
	callq	_printf
	leaq	-48(%rbp), %rdi
	movl	$32, %esi
	movl	$65536, %edx            ## imm = 0x10000
	callq	_posix_memalign
	testl	%eax, %eax
	je	LBB4_3
## BB#1:
	movq	-48(%rbp), %rdi
	jmp	LBB4_2
LBB4_3:
	leaq	-40(%rbp), %rdi
	movl	$32, %esi
	movl	$65536, %edx            ## imm = 0x10000
	callq	_posix_memalign
	testl	%eax, %eax
	je	LBB4_5
## BB#4:
	movq	-40(%rbp), %rdi
	jmp	LBB4_2
LBB4_5:
	leaq	-32(%rbp), %rdi
	movl	$32, %esi
	movl	$65536, %edx            ## imm = 0x10000
	callq	_posix_memalign
	testl	%eax, %eax
	je	LBB4_7
## BB#6:
	movq	-32(%rbp), %rdi
LBB4_2:
	callq	_free
	movl	$1, %ebx
LBB4_16:
	movl	%ebx, %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB4_7:
	movq	-48(%rbp), %rax
	movl	$0, (%rax)
	movl	$2, 4(%rax)
	movl	$4, 8(%rax)
	movq	-40(%rbp), %rcx
	movl	$1, (%rcx)
	movl	$3, 4(%rcx)
	movl	%ebx, 8(%rcx)
	movq	-32(%rbp), %rdx
	movl	$1, 2048(%rax)
	movl	$1, 2048(%rcx)
	movl	$1, 2048(%rdx)
	movl	$1, 4096(%rax)
	movl	$1, 4096(%rcx)
	movl	$1, 4096(%rdx)
	movl	$1, 6144(%rax)
	movl	$1, 6144(%rcx)
	movl	$1, 6144(%rdx)
	movl	$1, 8192(%rax)
	movl	$1, 8192(%rcx)
	movl	$1, 8192(%rdx)
	movl	$1, 10240(%rax)
	movl	$1, 10240(%rcx)
	movl	$1, 10240(%rdx)
	movl	$1, 12288(%rax)
	movl	$1, 12288(%rcx)
	movl	$1, 12288(%rdx)
	movl	$1, 14336(%rax)
	movl	$1, 14336(%rcx)
	movl	$1, 14336(%rdx)
	movl	$1, 16384(%rax)
	movl	$1, 16384(%rcx)
	movl	$1, 16384(%rdx)
	movl	$1, 18432(%rax)
	movl	$1, 18432(%rcx)
	movl	$1, 18432(%rdx)
	movl	$1, 20480(%rax)
	movl	$1, 20480(%rcx)
	movl	$1, 20480(%rdx)
	movl	$1, 22528(%rax)
	movl	$1, 22528(%rcx)
	movl	$1, 22528(%rdx)
	movl	$1, 24576(%rax)
	movl	$1, 24576(%rcx)
	movl	$1, 24576(%rdx)
	movl	$1, 26624(%rax)
	movl	$1, 26624(%rcx)
	movl	$1, 26624(%rdx)
	movl	$1, 28672(%rax)
	movl	$1, 28672(%rcx)
	movl	$1, 28672(%rdx)
	movl	$1, 30720(%rax)
	movl	$1, 30720(%rcx)
	movl	$1, 30720(%rdx)
	movl	$1, 32768(%rax)
	movl	$1, 32768(%rcx)
	movl	$1, 32768(%rdx)
	movl	$1, 34816(%rax)
	movl	$1, 34816(%rcx)
	movl	$1, 34816(%rdx)
	movl	$1, 36864(%rax)
	movl	$1, 36864(%rcx)
	movl	$1, 36864(%rdx)
	movl	$1, 38912(%rax)
	movl	$1, 38912(%rcx)
	movl	$1, 38912(%rdx)
	movl	$1, 40960(%rax)
	movl	$1, 40960(%rcx)
	movl	$1, 40960(%rdx)
	movl	$1, 43008(%rax)
	movl	$1, 43008(%rcx)
	movl	$1, 43008(%rdx)
	movl	$1, 45056(%rax)
	movl	$1, 45056(%rcx)
	movl	$1, 45056(%rdx)
	movl	$1, 47104(%rax)
	movl	$1, 47104(%rcx)
	movl	$1, 47104(%rdx)
	movl	$1, 49152(%rax)
	movl	$1, 49152(%rcx)
	movl	$1, 49152(%rdx)
	movl	$1, 51200(%rax)
	movl	$1, 51200(%rcx)
	movl	$1, 51200(%rdx)
	movl	$1, 53248(%rax)
	movl	$1, 53248(%rcx)
	movl	$1, 53248(%rdx)
	movl	$1, 55296(%rax)
	movl	$1, 55296(%rcx)
	movl	$1, 55296(%rdx)
	movl	$1, 57344(%rax)
	movl	$1, 57344(%rcx)
	movl	$1, 57344(%rdx)
	movl	$1, 59392(%rax)
	movl	$1, 59392(%rcx)
	movl	$1, 59392(%rdx)
	movl	$1, 61440(%rax)
	movl	$1, 61440(%rcx)
	movl	$1, 61440(%rdx)
	movl	$1, 63488(%rax)
	movl	$1, 63488(%rcx)
	movl	$1, 63488(%rdx)
	movl	$50000, %ebx            ## imm = 0xC350
	.p2align	4, 0x90
LBB4_8:                                 ## =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movl	$16384, %ecx            ## imm = 0x4000
	callq	_add_iv_avx
	decl	%ebx
	jne	LBB4_8
## BB#9:
	movl	$50000, %ebx            ## imm = 0xC350
	callq	_clock
	movq	%rax, %r14
	.p2align	4, 0x90
LBB4_10:                                ## =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movl	$16384, %ecx            ## imm = 0x4000
	callq	_add_iv_avx
	decl	%ebx
	jne	LBB4_10
## BB#11:
	callq	_clock
	subq	%r14, %rax
	imulq	$1000, %rax, %rax       ## imm = 0x3E8
	movabsq	$4835703278458516699, %r14 ## imm = 0x431BDE82D7B634DB
	mulq	%r14
	shrq	$18, %rdx
	movslq	%edx, %rdx
	imulq	$274877907, %rdx, %rsi  ## imm = 0x10624DD3
	movq	%rsi, %rax
	shrq	$63, %rax
	sarq	$38, %rsi
	addl	%eax, %esi
	imull	$1000, %esi, %eax       ## imm = 0x3E8
	subl	%eax, %edx
	leaq	L_.str.3(%rip), %rdi
	xorl	%eax, %eax
                                        ## kill: %ESI<def> %ESI<kill> %RSI<kill>
                                        ## kill: %EDX<def> %EDX<kill> %RDX<kill>
	callq	_printf
	movq	-32(%rbp), %rdi
	callq	_debug_print
	movl	$50000, %ebx            ## imm = 0xC350
	.p2align	4, 0x90
LBB4_12:                                ## =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movl	$16384, %ecx            ## imm = 0x4000
	callq	_add_iv_sse
	decl	%ebx
	jne	LBB4_12
## BB#13:
	movl	$50000, %ebx            ## imm = 0xC350
	callq	_clock
	movq	%rax, %r15
	.p2align	4, 0x90
LBB4_14:                                ## =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rdi
	movq	-40(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movl	$16384, %ecx            ## imm = 0x4000
	callq	_add_iv_sse
	decl	%ebx
	jne	LBB4_14
## BB#15:
	callq	_clock
	subq	%r15, %rax
	imulq	$1000, %rax, %rax       ## imm = 0x3E8
	mulq	%r14
	shrq	$18, %rdx
	movslq	%edx, %rdx
	imulq	$274877907, %rdx, %rsi  ## imm = 0x10624DD3
	movq	%rsi, %rax
	shrq	$63, %rax
	sarq	$38, %rsi
	addl	%eax, %esi
	imull	$1000, %esi, %eax       ## imm = 0x3E8
	subl	%eax, %edx
	leaq	L_.str.4(%rip), %rdi
	xorl	%ebx, %ebx
	xorl	%eax, %eax
                                        ## kill: %ESI<def> %ESI<kill> %RSI<kill>
                                        ## kill: %EDX<def> %EDX<kill> %RDX<kill>
	callq	_printf
	movq	-32(%rbp), %rdi
	callq	_debug_print
	jmp	LBB4_16
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"int: %i %i %i %i\n"

L_.str.1:                               ## @.str.1
	.asciz	"vector+vector:begin "

L_.str.2:                               ## @.str.2
	.asciz	"n: %d\n"

L_.str.3:                               ## @.str.3
	.asciz	"  AVX Time taken: %d seconds %d milliseconds\n"

L_.str.4:                               ## @.str.4
	.asciz	"\n  SSE Time taken: %d seconds %d milliseconds\n"


.subsections_via_symbols
