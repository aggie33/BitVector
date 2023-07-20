// The Swift Programming Language
// https://docs.swift.org/swift-book

import CoreFoundation
import CopyOnWrite

extension CFBitVector: PairReferenceCopyable {
    public var immutable: CFBitVector {
        self
    }
    
    public func mutableCopy() -> CFMutableBitVector {
        CFBitVectorCreateMutableCopy(nil, 0, self)
    }
}

/// An ordered collection of bits, which are either on or off.
public struct BitVector {
    var storage: CopyOnWritePair<CFBitVector>
    
    init(_ vector: CFBitVector) {
        self.storage = CopyOnWritePair(vector)
    }
    
    init(withoutCopying mutableVector: CFMutableBitVector) {
        self.storage = CopyOnWritePair(withoutCopying: mutableVector)
    }
}

