#!/usr/bin/env python3

import sys

# interpret a binary value as an IEEE 754 float
# and convert it to a decimal fraction

size = 8
k = 3
bias = 2**(k-1)-1

if len(sys.argv) != 2:
    print('Usage: %s <%d bit number>' % (sys.argv[0], size), file=sys.stderr)
    sys.exit(1)

s = sys.argv[1]
for ch in s:
    if ch not in '01':
        print('input must only consist of 1s and 0s', file=sys.stderr)
        sys.exit(1)
if len(s) != size:
    print('input must be exactly %d bits long' % size, file=sys.stderr)
    sys.exit(1)

# split it into pieces
sign = s[0]
exp = s[1:1+k]
frac = s[k+1:]
print('sign:%s exp:%s frac:%s' % (sign, exp, frac))

# handle the three main cases
if exp == '0'*k:
    # denormalized number
    print('exp bits are all zeros, so this is a denormalized number')
    expval = 1-bias
    print('exp value = 1-bias = 1-%d=%d' % (bias, expval))
    print('frac value has implicit 0. so 0.bits = 0.%s' % (frac))
    num, den = int(frac, 2), 2**len(frac)
    print('there are %d frac bits, so denominator is 2^%d or %d' % (len(frac), len(frac), den))
    print('numerator is %s = %d in base 10, so fractional part is %d/%d' % (frac, num, num, den))
elif exp != '1'*k:
    # normalized number
    print('exp bits are not all zeros nor all ones, so this is a normalized number')
    expbits = int(exp, 2)
    expval = expbits-bias
    print('exp bits are %s = %d in base 10' % (exp, expbits))
    print('exp value is bits-bias or %d-%d = %d' % (expbits, bias, expval))
    print('frac value has implicit 1. so 1.bits = 1.%s' % (frac))
    num, den = int(frac, 2), 2**len(frac)
    print('there are %d frac bits, so denominator is 2^%d or %d' % (len(frac), len(frac), den))
    print('numerator is %s = %d in base 10, so fractional part is 1 %d/%d' % (frac, num, num, den))
    num += den
    print('which is equal to %d/%d' % (num, den))
else:
    # special case
    print('exp bits are all ones, so this is a special case')
    if int(frac, 2) == 0:
        print('frac bits are all zeros, so this is infinity')
        if sign == '1':
            print('sign bit is one, so this is negative infinity')
        else:
            print('sign bit is zero, so this is positive infinity')
    else:
        print('frac bits are not all zeros, so this is not a number, i.e. NaN')
    sys.exit(0)

# apply the exponent and simplify
if expval >= 0:
    print('exp value is %d, so multiply the fraction by 2^%d or %d' % (expval, expval, 2**expval))
    print('%d*%d / %d = %d/%d' % (num, 2**expval, den, num * 2**expval, den))
    num *= 2**expval
else:
    print('exp value is %d, so multiply the fraction by 1 / 2^%d or 1/%d' % (expval, -expval, 2**(-expval)))
    print('%d / (%d*%d) = %d/%d' % (num, den, 2**(-expval), num, den * 2**(-expval)))
    den *= 2**(-expval)

while num > 0 and num%2 == 0 and den%2 == 0:
    num /= 2
    den /= 2

print('this simplifies to %d/%d' % (num, den))
if den == 1:
    print('or %d' % num)

if sign == '1':
    num = -num
print('sign is %s, so final result is' % sign)
if den == 1:
    print(num)
else:
    print('%d/%d' % (num, den))
