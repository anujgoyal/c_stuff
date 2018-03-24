	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 12
	.globl	_add_iv
	.p2align	4, 0x90
_add_iv:                                ## @add_iv
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
	movdqa	(%rsi), %xmm0
	paddd	(%rdi), %xmm0
	popq	%rbp
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
	movdqa	(%rsi), %xmm0
	paddd	(%rdi), %xmm0
	movdqa	%xmm0, (%rdx)
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
	movdqa	-16(%rsi), %xmm0
	paddd	-16(%rdx), %xmm0
	movdqa	%xmm0, -16(%rcx)
	movdqa	(%rsi), %xmm0
	paddd	(%rdx), %xmm0
	movdqa	%xmm0, (%rcx)
	addq	$32, %rcx
	addq	$32, %rdx
	addq	$32, %rsi
	addq	$-2, %rax
	jne	LBB1_6
LBB1_7:
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_add_iv_nosse
	.p2align	4, 0x90
_add_iv_nosse:                          ## @add_iv_nosse
	.cfi_startproc
## BB#0:
                                        ## kill: %ECX<def> %ECX<kill> %RCX<def>
	testl	%ecx, %ecx
	jle	LBB2_9
## BB#1:
	movl	%ecx, %eax
	cmpl	$7, %ecx
	jbe	LBB2_2
## BB#5:
	andl	$7, %ecx
	movq	%rax, %r8
	subq	%rcx, %r8
	je	LBB2_2
## BB#6:
	pushq	%rbp
Lcfi6:
	.cfi_def_cfa_offset 16
Lcfi7:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi8:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
Lcfi9:
	.cfi_offset %rbx, -24
	leaq	16(%rdi), %r9
	leaq	16(%rsi), %r10
	leaq	16(%rdx), %r11
	movq	%r8, %rbx
	.p2align	4, 0x90
LBB2_7:                                 ## =>This Inner Loop Header: Depth=1
	movdqu	-16(%r9), %xmm0
	movdqu	(%r9), %xmm1
	movdqu	-16(%r10), %xmm2
	movdqu	(%r10), %xmm3
	paddd	%xmm0, %xmm2
	paddd	%xmm1, %xmm3
	movdqu	%xmm2, -16(%r11)
	movdqu	%xmm3, (%r11)
	addq	$32, %r9
	addq	$32, %r10
	addq	$32, %r11
	addq	$-8, %rbx
	jne	LBB2_7
## BB#8:
	testl	%ecx, %ecx
	popq	%rbx
	popq	%rbp
	jne	LBB2_3
	jmp	LBB2_9
LBB2_2:
	xorl	%r8d, %r8d
LBB2_3:
	leaq	(%rdi,%r8,4), %rcx
	leaq	(%rsi,%r8,4), %rsi
	leaq	(%rdx,%r8,4), %rdx
	subq	%r8, %rax
	.p2align	4, 0x90
LBB2_4:                                 ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %edi
	addl	(%rcx), %edi
	movl	%edi, (%rdx)
	addq	$4, %rcx
	addq	$4, %rsi
	addq	$4, %rdx
	decq	%rax
	jne	LBB2_4
LBB2_9:
	retq
	.cfi_endproc

	.globl	_p128_as_int
	.p2align	4, 0x90
_p128_as_int:                           ## @p128_as_int
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi10:
	.cfi_def_cfa_offset 16
Lcfi11:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi12:
	.cfi_def_cfa_register %rbp
	movd	%xmm0, %esi
	pextrd	$1, %xmm0, %edx
	pextrd	$2, %xmm0, %ecx
	pextrd	$3, %xmm0, %r8d
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
Lcfi13:
	.cfi_def_cfa_offset 16
Lcfi14:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi15:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
Lcfi16:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	leaq	L_.str.1(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movaps	(%rbx), %xmm0
	callq	_p128_as_int
	leaq	L_.str.2(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movaps	131056(%rbx), %xmm0
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	jmp	_p128_as_int            ## TAILCALL
	.cfi_endproc

	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi17:
	.cfi_def_cfa_offset 16
Lcfi18:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi19:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$393224, %rsp           ## imm = 0x60008
Lcfi20:
	.cfi_offset %rbx, -56
Lcfi21:
	.cfi_offset %r12, -48
Lcfi22:
	.cfi_offset %r13, -40
Lcfi23:
	.cfi_offset %r14, -32
Lcfi24:
	.cfi_offset %r15, -24
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	8(%rsi), %rdi
	callq	_atoi
	movl	%eax, %ebx
	leaq	L_.str.3(%rip), %rdi
	xorl	%eax, %eax
	movl	%ebx, %esi
	callq	_printf
	leaq	-131120(%rbp), %r14
	movl	$131072, %esi           ## imm = 0x20000
	movq	%r14, %rdi
	callq	___bzero
	movabsq	$17179869186, %rax      ## imm = 0x400000002
	movq	%rax, -131116(%rbp)
	leaq	-262192(%rbp), %r12
	movl	$131072, %esi           ## imm = 0x20000
	movq	%r12, %rdi
	callq	___bzero
	movl	$1, -262192(%rbp)
	movl	$3, -262188(%rbp)
	movl	%ebx, -262184(%rbp)
	movl	$33, -60(%rbp)
	movl	$34, -56(%rbp)
	movl	$35, -52(%rbp)
	movabsq	$137438953503, %rax     ## imm = 0x200000001F
	movq	%rax, -131132(%rbp)
	movl	$33, -131124(%rbp)
	movl	$10000, %ebx            ## imm = 0x2710
	callq	_clock
	movq	%rax, %r15
	leaq	-393264(%rbp), %r13
	.p2align	4, 0x90
LBB5_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	$32768, %ecx            ## imm = 0x8000
	movq	%r14, %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	_add_iv_sse
	decl	%ebx
	jne	LBB5_1
## BB#2:
	callq	_clock
	subq	%r15, %rax
	imulq	$1000, %rax, %rax       ## imm = 0x3E8
	movabsq	$4835703278458516699, %rcx ## imm = 0x431BDE82D7B634DB
	mulq	%rcx
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
	xorl	%eax, %eax
                                        ## kill: %ESI<def> %ESI<kill> %RSI<kill>
                                        ## kill: %EDX<def> %EDX<kill> %RDX<kill>
	callq	_printf
	leaq	-393264(%rbp), %r15
	movq	%r15, %rdi
	callq	_debug_print
	movl	$10000, %r13d           ## imm = 0x2710
	callq	_clock
	movq	%rax, %r14
	leaq	-131120(%rbp), %r12
	leaq	-262192(%rbp), %rbx
	.p2align	4, 0x90
LBB5_3:                                 ## =>This Inner Loop Header: Depth=1
	movl	$32768, %ecx            ## imm = 0x8000
	movq	%r12, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_add_iv_nosse
	decl	%r13d
	jne	LBB5_3
## BB#4:
	callq	_clock
	subq	%r14, %rax
	imulq	$1000, %rax, %rax       ## imm = 0x3E8
	movabsq	$4835703278458516699, %rcx ## imm = 0x431BDE82D7B634DB
	mulq	%rcx
	shrq	$18, %rdx
	movslq	%edx, %rdx
	imulq	$274877907, %rdx, %rsi  ## imm = 0x10624DD3
	movq	%rsi, %rax
	shrq	$63, %rax
	sarq	$38, %rsi
	addl	%eax, %esi
	imull	$1000, %esi, %eax       ## imm = 0x3E8
	subl	%eax, %edx
	leaq	L_.str.5(%rip), %rdi
	xorl	%eax, %eax
                                        ## kill: %ESI<def> %ESI<kill> %RSI<kill>
                                        ## kill: %EDX<def> %EDX<kill> %RDX<kill>
	callq	_printf
	leaq	-393264(%rbp), %rdi
	callq	_debug_print
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	-48(%rbp), %rax
	jne	LBB5_6
## BB#5:
	xorl	%eax, %eax
	addq	$393224, %rsp           ## imm = 0x60008
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB5_6:
	callq	___stack_chk_fail
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"int: %i %i %i %i\n"

L_.str.1:                               ## @.str.1
	.asciz	"vector+vector:begin "

L_.str.2:                               ## @.str.2
	.asciz	"vector+vector:end "

L_.str.3:                               ## @.str.3
	.asciz	"n: %d\n"

L_.str.4:                               ## @.str.4
	.asciz	"  SSE Time taken: %d seconds %d milliseconds\n"

L_.str.5:                               ## @.str.5
	.asciz	"NOSSE Time taken: %d seconds %d milliseconds\n"


.subsections_via_symbols
