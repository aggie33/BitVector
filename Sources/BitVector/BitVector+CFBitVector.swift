//
//  File.swift
//  
//
//  Created by Eric Bodnick on 7/19/23.
//

import Foundation

extension BitVector {
    /// Creates a bit vector from an pointer to a buffer containing bytes.
    /// - Parameters:
    ///   - bytes: The bytes to create the vector from.
    ///   - numBits: The number of bits in `bytes` to use. Pass `nil` to use all of the bits.
    /// - Important: The bit indices are numbered left-to-right with `0` being the left-most, or most-significant, bit in the byte buffer.
    public init(
        bytes: UnsafePointer<UInt8>,
        numBits: Int
    ) {
        self.init(CFBitVectorCreate(nil, bytes, numBits))
    }
    
    /// Checks whether the bit vector contains `bit` in `range`.
    public func contains(_ bit: Bit, in range: Range<Int>? = nil) -> Bool {
        let range = range ?? 0..<count
        return CFBitVectorContainsBit(
            storage.immutable,
            CFRangeMake(range.lowerBound, range.count),
            bit.rawValue
        )
    }
    
    /// Gets the bit at a given index.
    public subscript(index: Int) -> Bit {
        get { Bit(rawValue: CFBitVectorGetBitAtIndex(storage.immutable, index))! }
        set { CFBitVectorSetBitAtIndex(storage.mutable, index, newValue.rawValue) }
    }
    
    /// Copies the bits in `range` to `pointer`.
    public func copyBits(in range: Range<Int>? = nil, to pointer: UnsafeMutablePointer<UInt8>) {
        let range = range ?? 0..<count
        CFBitVectorGetBits(storage.immutable, CFRangeMake(range.lowerBound, range.count), pointer)
    }
    
    /// The number of bits in the bit vector.
    public var count: Int {
        get { CFBitVectorGetCount(storage.immutable) }
        set { CFBitVectorSetCount(storage.mutable, newValue) }
    }
    
    /// Finds the number of times `bit` occurs in `range`.
    public func count(of bit: Bit, in range: Range<Int>? = nil) -> Int {
        let range = range ?? 0..<count
        return CFBitVectorGetCountOfBit(storage.immutable, CFRangeMake(range.lowerBound, range.count), bit.rawValue)
    }
    
    /// Finds the first index of `bit` in `range`, or `nil` if `bit` wasn't found.
    public func firstIndex(of bit: Bit, in range: Range<Int>? = nil) -> Int? {
        let range = range ?? 0..<count
        let index = CFBitVectorGetFirstIndexOfBit(storage.immutable, CFRangeMake(range.lowerBound, range.count), bit.rawValue)
        
        if index == kCFNotFound {
            return nil
        } else {
            return index
        }
    }
    
    /// Finds the last index of `bit` in `range`, or `nil` if `bit` wasn't found.
    public func lastIndex(of bit: Bit, in range: Range<Int>? = nil) -> Int? {
        let range = range ?? 0..<count
        let index = CFBitVectorGetLastIndexOfBit(storage.immutable, CFRangeMake(range.lowerBound, range.count), bit.rawValue)
        
        if index == kCFNotFound {
            return nil
        } else {
            return index
        }
    }
}

