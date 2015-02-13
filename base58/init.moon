alphabet = "rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz"

alphabet_i_to_char = { i, alphabet\sub(i,i) for i=1,#alphabet }
alphabet_char_to_i = { alphabet\sub(i,i), i for i=1,#alphabet }

-- TODO: null byte in string seems to break things

-- represents number as array of bytes (unpacked string)
class BigInt
  @from_string: (str) =>
    @ { str\reverse!\byte 1, -1 }

  new: (@bytes={}) =>

  is_zero: =>
    for b in *@bytes
      return false if b != 0

    true

  to_string: =>
    string.char(unpack @bytes)\reverse!

  -- will overflow if the number is truly big
  to_number: =>
    sum = 0
    k = 1
    for val in *@bytes
      sum += val * k
      k *= 256

    sum

  add: (num) =>
    k = 1
    while true
      @bytes[k] = (@bytes[k] or 0) + num
      break if @bytes[k] < 256

      num = math.floor @bytes[k] / 256
      @bytes[k] = @bytes[k] % 256
      k += 1

  -- mul must be < 256
  mul: (mul) =>
    last_idx = 1
    r = 0
    for idx=1,#@bytes
      cur = @bytes[idx] * mul + r
      @bytes[idx] = cur % 256
      r = math.floor cur / 256
      last_idx = idx

    if r > 0
      @bytes[last_idx + 1] = r

    nil

  -- div must be < 256
  div: (div) =>
    local r
    for idx=#@bytes,1,-1
      b = @bytes[idx]
      b += r * 256 if r
      q, r = math.floor(b / div), b % div
      @bytes[idx] = q

    @, r

encode_base58 = (str) ->
  buffer = {}

  int = BigInt\from_string str
  while not int\is_zero!
    _, r = int\div 58
    table.insert buffer, alphabet_i_to_char[r + 1]

  table.concat buffer

decode_base58 = (str) ->
  out = BigInt!

  for i=#str,1,-1
    char = str\sub i,i
    char_i = alphabet_char_to_i[char]
    return nil, "invalid string" unless char_i
    char_byte = char_i - 1
    out\mul 58
    out\add char_byte

  out\to_string!

{ :BigInt, :encode_base58, :decode_base58 }
