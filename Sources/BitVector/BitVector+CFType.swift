//
//  File.swift
//  
//
//  Created by Eric Bodnick on 7/19/23.
//

import Foundation

extension BitVector: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        CFEqual(lhs.storage.immutable, rhs.storage.immutable)
    }
}

extension BitVector: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(CFHash(storage.immutable))
    }
}

extension BitVector: CustomStringConvertible {
    /// The description of the bit vector.
    /// - Note: This property is `O(n)` where `n` is the number of bits in the vector.
    public var description: String {
        "BitVector(count: \(count), bits: \(map(\.description).joined()))"
    }
}
