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
	push {r4, r5, r6, lr}

	@ if(R0 <= 0) goto .L3 (which returns 0)
	cmp r0, #0
	ble .L3

	@ r4, r5 = 0, 1, index r0
	mov r4, #0
	mov r5, #1
.LOOP:
	mov r6, r5
	adds r5, r4, r5
	mov r4, r6

	@ int overflow
	bvs .L3

	subs r0, r0, #1
	bne .LOOP

	mov r0, r4

	pop {r4, r5, r6, pc}		@EPILOG
.L3:
	mov r0, #0			@ R0 = 0
	pop {r4, r5, r6, pc}		@ EPILOG

	.size fibonacci, .-fibonacci
	.end
