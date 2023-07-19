# BitVector
A wrapper around CFBitVector and CFMutableBitVector.


| CF(Mutable)BitVector | BitVector |
----------------------- | ----------------
| `CFBitVectorCreate` | `init(bytes:bitCount:)`
| `CFBitVectorContainsBit` | `contains(_:in:)`
| `CFBitVectorGetBitAtIndex` | `subscript(_:)`
| `CFBitVectorGetBits` | `copyBits(in:to:)`
| `CFBitVectorGetCount` | `count`
| `CFBitVectorGetCountOfBit` | `count(of:in:)`
| `CFBitVectorGetFirstIndexOfBit` | `firstIndex(of:in:)`
| `CFBitVectorGetLastIndexOfBit` | `lastIndex(of:in:)`
| `CFBitVectorCreateMutable` | `init()`
| `CFBitVectorFlipBitAtIndex` | `flipBit(at:)`
| `CFBitVectorFlipBits` | `flipBits(in:)`
| `CFBitVectorSetAllBits` | `setAllBits(to:)`
| `CFBitVectorSetBitAtIndex` | `subscript(_:)`
| `CFBitVectorSetBits` | `setBits(in:to:)`
| `CFBitVectorSetCount` | `count`
------------

In addition, `BitVector` conforms to `Equatable`, `Hashable`, `CustomStringConvertible`, `Sequence`, `Collection`, `MutableCollection`, `RangeReplaceableCollection`, `BidirectionalCollection`, and `RandomAccessCollection`. Bit vectors can also be created with an array literal. 

Bits are represented with the new `Bit` type, which is an enum. They can be created with an integer or boolean literal.
