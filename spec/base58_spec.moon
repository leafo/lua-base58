base58 = require "base58"


assert_bytes = (str1, str2) ->
  assert.same {str1\byte 1, -1}, {str2\byte 1, -1}


encode_tests = {
  {"hello", "gZVe38U"}
  {"whath e@*#@(# heck is #($R@#($ this", "5emzSsfaVDcbgxVnUUS4ypBnMfdympo1B9ym9jfwtJr6MsvU"}
  {"there is ", "un5d6aEhBWA7p"}
  {"1", "i"}
  {"29999999992222222222222222222933392 22222222222222222732938923333229 29999999999923", "WWxciV8aqL7MW3c7R9145DnTsKMMcXHLnXqKsM6dT4MDsL8PpSqcusuu3QqFLADX3o98XAdNrtcN8qt4LgkiE1M78en7ihPr2fCdGbeMNJU9wFThF"}
  {string.char(1), "p"}
  {string.char(1,2,3), "FdL"}
}


describe "base58", ->
  it "should call encode_base58", ->
    assert.same "TvjnTzXAiTprExJ", base58.encode_base58 "Hello world"

  it "should call decode_base58", ->
    assert.same "Hello world", base58.decode_base58 "TvjnTzXAiTprExJ"

  for {input, expected} in *encode_tests
    it "encodes text", ->
      assert.same expected, base58.encode_base58 input

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
