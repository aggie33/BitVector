# BitVector
A wrapper around CFBitVector and CFMutableBitVector.


| CF(Mutable)BitVector | BitVector |
----------------------- | ----------------
| `CFBitVectorCreate` | `init(bytes:bitCount:)`
| `CFBitVectorContainsBit` | `contains(_:in:)`
| `CFBitVectorGetBitAtIndex` | `subscript(_:)`
| `CFBitVectorGetBits` | `copyBits(in:to:)
