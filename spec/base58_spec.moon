base58 = require "base58"


assert_bytes = (str1, str2) ->
  assert.same {str1\byte 1, -1}, {str2\byte 1, -1}

describe "base58", ->
  it "should call encode_base58", ->
    assert.same "TvjnTzXAiTprExJ", base58.encode_base58 "Hello world"

  it "should call decode_base58", ->
    assert.same "Hello world", base58.decode_base58 "TvjnTzXAiTprExJ"

  it "should fail to decode bad still", ->
    res, err = base58.decode_base58 "hello world"
    assert.falsy res
    assert.truthy err

  it "should preserve string with null byte in front", ->
    str = string.char 0, 20, 132
    assert_bytes str, base58.decode_base58 base58.encode_base58 str


  it "should preserve string with multiple passes", ->
    str = string.char 0, 20, 132
    assert_bytes base58.encode_base58(str),
      base58.encode_base58 base58.decode_base58 base58.encode_base58 str
