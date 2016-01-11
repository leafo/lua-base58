base58 = require "base58"


assert_bytes = (str1, str2) ->
  assert.same {str1\byte 1, -1}, {str2\byte 1, -1}


encode_tests = {
  {"hello", "gZVe38U"}
  {"whath e@*#@(# heck is #($R@#($ this", "5emzSsfaVDcbgxVnUUS4ypBnMfdympo1B9ym9jfwtJr6MsvU"}
  {"there is ", "un5d6aEhBWA7p"}
  {"1", "i"}
  {"29999999992222222222222222222933392 22222222222222222732938923333229 29999999999923", "WWxciV8aqL7MW3c7R9145DnTsKMMcXHLnXqKsM6dT4MDsL8PpSqcusuu3QqFLADX3o98XAdNrtcN8qt4LgkiE1M78en7ihPr2fCdGbeMNJU9wFThF"}

  { string.char(1), "p" }
  { string.char(1,2,3), "FdL" }

  { string.char(101, 200, 204, 233, 51, 86, 196, 71, 142, 122, 161, 94, 131, 243, 234, 163, 183, 37, 155, 5, 62, 35, 206, 40, 103, 34, 28, 255, 56, 131, 214, 157), "3iWeXEyuAYpTn1qPajtXynE8YKbojEygAUZg119TmKif" }
  { string.char(163, 134, 126, 249, 75, 197, 135, 197, 103, 228, 73), "asC2GaNDBZjquY6" }
  { string.char(206, 235, 18, 243, 135, 22, 50, 170, 228, 89, 17, 6, 117, 17), "cc9BFp52Ak3xoq3fnnKp" }
  { string.char(248, 231, 217, 68, 138, 96, 194, 131, 171), "FCsGCFD4Mykwh" }
  { string.char(11, 112, 238, 238, 184, 73, 189, 164, 91, 176, 43, 113, 225, 212, 85, 59, 228, 90, 176, 244), "swBnqh66WKA8MxrkHU5cgWzkUEw" }
  { string.char(168, 219, 113, 236, 102, 208, 175, 233, 124, 56, 243, 235, 38, 225, 164, 111, 158, 72, 201, 79, 114, 58), "sm6uocpt22g8AxNaZ64NdGig9433q8" }
  { string.char(71, 142, 107, 44, 232, 27, 33), "NK9fhBsH5s" }
  { string.char(194, 252, 239, 175, 98, 192, 95, 76, 60, 150, 63, 39, 187, 32, 203, 42, 190, 20, 243), "hVTBM2B6dzk2brzNXSy4qHYQ6c" }
  { string.char(133, 45), "F3B" }
  { string.char(204, 187, 168, 247, 164, 194, 24, 35, 133), "L74BLpVqkX9cs" }
  { string.char(18, 53, 118), "jjff" }
  { string.char(147, 193, 14, 41, 255, 53, 227, 32, 255, 14, 222, 19, 2, 236, 152, 46, 42, 100, 233, 210, 92, 141, 148, 116, 176, 26, 136, 194, 78, 254, 148), "ZqeyfBTQRwdNsYCcMtbthH66avFZRVwxYzhCHsr3gEs" }
  { string.char(191, 161, 10, 191, 213, 236, 223, 212, 250, 190, 231, 251, 171, 127, 42, 212, 227, 20, 166, 64, 161, 59, 179, 81, 84, 60, 19, 162, 58, 167, 131, 248, 72), "Zfksc9UYLSCwaAr8bCvgHrxU2vJLTPekYKTFFZNHA36vy" }
  { string.char(184, 29, 121, 152, 241, 115, 86, 217, 111, 1, 88, 153, 213, 60, 173, 124, 123, 78, 182, 47, 159), "ScoyAXUaeJRoZFZ19u6QRK8VeceKU" }
  { string.char(106, 178), "Af9" }
  { string.char(163, 89, 48, 156, 160, 187, 84, 189, 52, 235, 175, 167, 66, 136, 23, 67, 224, 175, 24, 29, 93, 148, 152, 170, 74), "jyRB1SWSGdAaPB6j4socYT2o1613P1uDj3p" }
  { string.char(74, 85, 49, 252, 1, 211, 85, 48, 112, 245, 235, 196, 179, 31, 175, 98, 198, 241, 234, 220, 52, 203, 140, 76, 231, 232, 223, 128, 147), "va3ufySpeecPnwKmckNHD419dhhmX9UBi7e1m54h" }
  { string.char(70, 221, 126, 119, 217, 127, 75), "cfpcYBAkgs" }
  { string.char(175, 186, 36, 154, 126, 214, 185), "SbSwoY8NCf" }
  { string.char(57, 128, 31, 36, 92, 83, 238), "d2VP4hUPBs" }

}

decode_tests = {
  {"r", {0}}
  {"rr", {0}} -- hmm
  {"p", {1}}
  {"pp", {59}}
  {"abc", {1, 211, 165}}
}

describe "base58", ->
  it "should call encode_base58", ->
    assert.same "TvjnTzXAiTprExJ", base58.encode_base58 "Hello world"

  it "should call decode_base58", ->
    assert.same "Hello world", base58.decode_base58 "TvjnTzXAiTprExJ"

  for {input, expected} in *encode_tests
    it "encodes text", ->
      assert.same expected, base58.encode_base58 input

  for {input, expected} in *decode_tests
    it "encodes to bytes", ->
      assert.same expected, { string.byte base58.decode_base58(input), 1, -1 }

  it "should fail to decode bad still", ->
    res, err = base58.decode_base58 "hello world"
    assert.falsy res
    assert.truthy err

  it "should preserve string with null byte", ->
    pending "is broken"
    str = string.char 0, 20, 132
    assert_bytes str, base58.decode_base58 base58.encode_base58 str

  it "should preserve string with multiple passes", ->
    str = string.char 0, 20, 132
    assert_bytes base58.encode_base58(str),
      base58.encode_base58 base58.decode_base58 base58.encode_base58 str
