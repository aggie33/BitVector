//
//  File.swift
//  
//
//  Created by Eric Bodnick on 7/19/23.
//

import Foundation
import CopyOnWrite

extension BitVector: RangeReplaceableCollection {
    public init() {
        self.storage = CopyOnWritePair(withoutCopying: CFBitVectorCreateMutable(nil, 0))
    }
    
    @inlinable
    public mutating func replaceSubrange<C>(
        _ subrange: Range<Int>,
        with newElements: C
    ) where C : Collection, Bit == C.Element {
        if subrange.count == newElements.count {
            // no need to change the size of the collection
            for (index, bit) in zip(subrange, newElements) {
                self[index] = bit
            }
        } else if subrange.count > newElements.count {
            // we'll need to reduce the size of the collection
            let difference = subrange.count - newElements.count // the number of items to remove
            
            // moves all the elements after the subrange back
            for index in subrange.upperBound..<endIndex {
                self[index - difference] = self[index]
            }
            
            // reduces the count of the bit vector
            count -= difference
            
            // actually replaces the elements
            for (index, element) in zip(subrange, newElements) {
                self[index] = element
            }
        } else {
            // we'll need to increase the size of the collection
            let difference = newElements.count - subrange.count // the number of items to add
            
            // increases the count of the bit vector
            count += difference
            
            // moves all the elements after the subrange forward
            for index in (subrange.upperBound..<endIndex).reversed() {
                self[index + difference] = self[index]
            }
            
            // actually replaces the elements
            for (index, element) in zip(subrange.lowerBound..., newElements) {
                self[index] = element
            }
        }
    }
}
