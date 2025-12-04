ALPHABET = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.chars.freeze
BASE = ALPHABET.length

SALT = 0x4F2A9B

# Encode an integer into Base62
def encode_base62(num)
  return ALPHABET[0] if num == 0

  s = []
  n = num.to_i

  while n > 0
    n, r = n.divmod(BASE)
    s.unshift(ALPHABET[r])
  end

  s.join
end

def obfuscate_id(id)
  id.to_i ^ SALT
end

def deobfuscate_id(obf)
  obf.to_i ^ SALT
end
