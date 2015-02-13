
# base58

A Lua module for converting strings to
[base58](http://en.wikipedia.org/wiki/Base58). It works by converting your
string into an interal big integer representation, then diving out the base58
components.

## Example

```lua
local base58 = require("base58")
print(base58.encode_base58("Hello world"))
print(base58.decode_base58("TvjnTzXAiTprExJ"))
```

## Install

```
luarocks install base58
```

# Reference

All functions are available in the `base58` module:

```lua
local base58 = require("base58")
```

The following alphabet is included and used by default. It's currently not
possible to configure the alphabet without editing the source.

```
rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz
```

#### `encode_base58(string)`

Encodes the string into base58

#### `decode_base58(string)`

Decodes base58 back into original string

# Contact

Author: Leaf Corcoran (leafo) ([@moonscript](http://twitter.com/moonscript))  
Email: leafot@gmail.com  
Homepage: <http://leafo.net>  
License: MIT


