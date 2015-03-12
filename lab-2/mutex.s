	.syntax unified
	.arch armv7-a
	.text

	.equ locked, 1
	.equ unlocked, 0

	.global lock_mutex
	.type lock_mutex, function
lock_mutex:

	ldr r1, =locked

.try_mutex:
	ldrex r2, [r0]

	cmp r2, r1

	@ mutex is locked, wait
	beq .try_mutex

	@ try lock
	strexne r2, r1, [r0]
	cmpne r2, #1

	beq .try_mutex

	dmb

	bx lr

	.size lock_mutex, .-lock_mutex

	.global unlock_mutex
	.type unlock_mutex, function
unlock_mutex:

	ldr r2, =unlocked

	dmb

	str r2, [r0]

	bx lr
	.size unlock_mutex, .-unlock_mutex

	.end
