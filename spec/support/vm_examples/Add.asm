// push constant 42
@42
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 42
@42
D=A
@SP
A=M
M=D
@SP
M=M+1
// add
@SP
M=M-1
@SP
A=M
D=M
@SP
M=M-1
@SP
A=M
M=M+D
@SP
M=M+1
