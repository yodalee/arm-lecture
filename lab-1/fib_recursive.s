	.syntax unified
	.arch armv7-a
	.text
	.align 2
	.thumb
	.thumb_func

	.global fibonacci
	.type fibonacci, function

fibonacci:
	@ PROLOG
	push {r4, r5, lr}

	@ if(R0 <= 0) goto .L3 (which returns 0)
	@ if(R0 == 1) goto .L4 (which returns 1)
	mov r4, r0
	cmp r4, #1
	blt .L3
	beq .L4

	@ R0 = R4 - 1
	sub r0, r4, #1

	@ Recursive call to fibonacci with R4 - 1 as parameter
	bl fibonacci
	mov r5, r0

	@ Recursive call to fibonacci with R4 - 2 as parameter
	sub r0, r4, #2
	bl fibonacci

	@ R0 = R5 + R0 (update flags)
	adds r0, r5, r0

	pop {r4, r5, pc}		@EPILOG
.L3:
	mov r0, #0			@ R0 = 0
	pop {r4, r5, pc}		@ EPILOG

.L4:
	mov r0, #1			@ R0 = 1
	pop {r4, r5, pc}		@ EPILOG

	.size fibonacci, .-fibonacci
	.end
