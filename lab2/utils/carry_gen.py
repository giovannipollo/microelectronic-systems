
a = 0x1
b = 0x3

def BITV(byte, pos):
    return (byte & (1 << pos)) >> pos;

cin = 0
for i in range(0, 4):
    cin = (BITV(a, i) and BITV(b, i)) or ((BITV(a, i) or BITV(b, i)) and cin)
    print(cin)


'''c0 = (a and b) or ((a or b) and )
c0 = (a and b) or ((a or b) and '0')
c0 = (a and b) or ((a or b) and '0')'''