base58 = require "base58"

describe "base58", ->
  it "should call encode_base58", ->
    assert.same "TvjnTzXAiTprExJ", base58.encode_base58 "Hello world"

  it "should call decode_base58", ->
    assert.same "Hello world", base58.decode_base58 "TvjnTzXAiTprExJ"

  it "should fail to decode bad still", ->
    res, err = base58.decode_base58 "hello world"
    assert.falsy res
    assert.truthy err

