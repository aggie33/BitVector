//
//  File.swift
//  
//
//  Created by Eric Bodnick on 7/19/23.
//

import Foundation

extension BitVector: RandomAccessCollection {
    public func index(before i: Int) -> Int {
        i - 1
    }
    
    public func index(_ i: Int, offsetBy distance: Int) -> Int {
        i + distance
    }
}
