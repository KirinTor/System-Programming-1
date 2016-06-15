.586
.model flat, c

.data
cote dd ?

.code


Mul_N_32_LONGOP proc
	local ct:DWORD
	push ebp
	mov ebp,esp
	mov esi, [ebp+28] ;ESI = ������ ���������
	mov ebx, [ebp+24] ;EBX = �������
	mov edi, [ebp+20] ;EDI = ������ ����������
	mov ecx, [ebp+16] ;������� �����
	shr ecx, 2 ;������� �������� ���
	mov ct, ecx

	xor ecx, ecx
	cycle_p: ;��� ������ �������
	mov eax, [esi+4*ecx]
	mul ebx
	mov [edi+4*ecx], eax
	mov [edi+4*ecx+4], edx

	inc ecx
	inc ecx
	cmp ecx, ct
	jl cycle_p

	xor ecx, ecx
	inc ecx
	cycle_np: ;��� �������� �������
	mov eax, [esi+4*ecx]
	mul ebx
	add [edi+4*ecx], eax
	adc [edi+4*ecx+4], edx
	adc byte ptr [edi+4*ecx+8], 0
	inc ecx
	inc ecx
	cmp ecx, ct
	jl cycle_np

	pop ebp ;���������� �����
	ret 16
Mul_N_32_LONGOP endp



Mul_N_N_LONGOP proc
	local ct:DWORD
	push ebp
	mov ebp,esp
	mov esi, [ebp+28] ;ESI = ������ ���������
	mov ebx, [ebp+24] ;EBX = ������ ��������
	mov edi, [ebp+20] ;EDI = ������ ����������
	mov ecx, [ebp+16] ; ������� �����
	shr ecx, 2
	mov cote, ecx

	xor ecx, ecx
	cycle:
	push ebx
	push ecx
	push edi
	
	shl ecx, 2
	add ebx, ecx
	add edi, ecx
	shr ecx, 2
	xor ecx, ecx
	
	cycle_p: ;��� ������ �������
	mov eax, [esi+4*ecx]
	mul dword ptr [ebx]
	add [edi+4*ecx], eax
	adc [edi+4*ecx+4], edx
	adc byte ptr [edi+4*ecx+8], 0
	inc ecx
	inc ecx
	cmp ecx, cote
	jl cycle_p

	xor ecx, ecx
	inc ecx
	cycle_np: ;��� �������� �������
	mov eax, [esi+4*ecx]
	mul dword ptr [ebx]
	add [edi+4*ecx], eax
	adc [edi+4*ecx+4], edx
	adc byte ptr [edi+4*ecx+8], 0
	inc ecx
	inc ecx
	cmp ecx, cote
	jl cycle_np

	pop edi
	pop ecx
	pop ebx

	inc ecx
	cmp ecx, cote
	jl cycle

	pop ebp ;���������� �����
	ret 16
Mul_N_N_LONGOP endp

end
