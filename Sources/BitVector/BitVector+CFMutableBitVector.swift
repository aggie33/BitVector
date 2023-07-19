//
//  File.swift
//  
//
//  Created by Eric Bodnick on 7/19/23.
//

import Foundation

extension BitVector {
    /// Flips the bit at `index`.
    public mutating func flipBit(at index: Int) {
        CFBitVectorFlipBitAtIndex(storage.mutable, index)
    }
    
    /// Flips the bits in `range`.
    public mutating func flipBits(in range: Range<Int>? = nil) {
        let range = range ?? 0..<count
        CFBitVectorFlipBits(storage.mutable, CFRangeMake(range.lowerBound, range.count))
    }
    
    /// Sets all the bits in the vector to `bit`.
    public mutating func setAllBits(to bit: Bit) {
        CFBitVectorSetAllBits(storage.mutable, bit.rawValue)
    }
    
    /// Sets the bits in `range` to `bit`.
    public mutating func setBits(in range: Range<Int>? = nil, to bit: Bit) {
        let range = range ?? 0..<count
        CFBitVectorSetBits(storage.mutable, CFRangeMake(range.lowerBound, range.count), bit.rawValue)
    }
}
