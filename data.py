import random.randrange as rand
import random.getrandbits as randbits

a = rand(0, 1023)
b = randbits(8)
l_a = [rand(0, 1023) for i in range(1024)]
l_b = [randbits(8) for i in range(1024)]
