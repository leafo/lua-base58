local alphabet = "rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz"
local alphabet_i_to_char
do
  local _tbl_0 = { }
  for i = 1, #alphabet do
    _tbl_0[i] = alphabet:sub(i, i)
  end
  alphabet_i_to_char = _tbl_0
end
local alphabet_char_to_i
do
  local _tbl_0 = { }
  for i = 1, #alphabet do
    _tbl_0[alphabet:sub(i, i)] = i
  end
  alphabet_char_to_i = _tbl_0
end
local BigInt
do
  local _base_0 = {
    is_zero = function(self)
      local _list_0 = self.bytes
      for _index_0 = 1, #_list_0 do
        local b = _list_0[_index_0]
        if b ~= 0 then
          return false
        end
      end
      return true
    end,
    to_string = function(self)
      return string.char(unpack(self.bytes)):reverse()
    end,
    to_number = function(self)
      local sum = 0
      local k = 1
      local _list_0 = self.bytes
      for _index_0 = 1, #_list_0 do
        local val = _list_0[_index_0]
        sum = sum + (val * k)
        k = k * 256
      end
      return sum
    end,
    add = function(self, num)
      local k = 1
      while true do
        self.bytes[k] = (self.bytes[k] or 0) + num
        if self.bytes[k] < 256 then
          break
        end
        num = math.floor(self.bytes[k] / 256)
        self.bytes[k] = self.bytes[k] % 256
        k = k + 1
      end
    end,
    mul = function(self, mul)
      local last_idx = 1
      local r = 0
      for idx = 1, #self.bytes do
        local cur = self.bytes[idx] * mul + r
        self.bytes[idx] = cur % 256
        r = math.floor(cur / 256)
        last_idx = idx
      end
      if r > 0 then
        self.bytes[last_idx + 1] = r
      end
      return nil
    end,
    div = function(self, div)
      local r
      for idx = #self.bytes, 1, -1 do
        local b = self.bytes[idx]
        if r then
          b = b + (r * 256)
        end
        local q
        q, r = math.floor(b / div), b % div
        self.bytes[idx] = q
      end
      return self, r
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, bytes)
      if bytes == nil then
        bytes = { }
      end
      self.bytes = bytes
    end,
    __base = _base_0,
    __name = "BigInt"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.from_string = function(self, str)
    return self({
      str:reverse():byte(1, -1)
    })
  end
  BigInt = _class_0
end
local encode_base58
encode_base58 = function(str)
  local buffer = { }
  local int = BigInt:from_string(str)
  while not int:is_zero() do
    local _, r = int:div(58)
    table.insert(buffer, alphabet_i_to_char[r + 1])
  end
  return table.concat(buffer)
end
local decode_base58
decode_base58 = function(str)
  local out = BigInt()
  for i = #str, 1, -1 do
    local char = str:sub(i, i)
    local char_byte = alphabet_char_to_i[char] - 1
    out:mul(58)
    out:add(char_byte)
  end
  return out:to_string()
end
return {
  BigInt = BigInt,
  encode_base58 = encode_base58,
  decode_base58 = decode_base58
}
