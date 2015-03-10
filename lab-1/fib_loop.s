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
	push {r3, r4, r5, lr}

	@ if(R0 <= 0) goto .L3 (which returns 0)
	cmp r0, #0
	ble .L3

	@ r3, r4 = 0, 1, index r0
	mov r3, #0
	mov r4, #1
.LOOP:
	mov r5, r4
	add r4, r3, r4
	mov r3, r5

	@ int overflow
	cmp r4, #0
	blt .L3

	sub r0, r0, #1
	cmp r0, #1
	bgt .LOOP

	mov r0, r4

	pop {r3, r4, r5, pc}		@EPILOG
.L3:
	mov r0, #0			@ R0 = 0
	pop {r3, r4, r5, pc}		@ EPILOG

	.size fibonacci, .-fibonacci
	.end
