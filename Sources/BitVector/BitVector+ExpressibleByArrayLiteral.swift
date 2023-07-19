//
//  File.swift
//  
//
//  Created by Eric Bodnick on 7/19/23.
//

import Foundation

extension BitVector: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: UInt8...) {
        self.init(bytes: elements, numBits: elements.count * 8)
    }
}
