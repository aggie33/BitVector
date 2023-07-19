//
//  File.swift
//  
//
//  Created by Eric Bodnick on 7/19/23.
//

import Foundation

extension BitVector: MutableCollection {
    public var startIndex: Int { 0 }
    public var endIndex: Int { count }
    
    public func index(after i: Int) -> Int { i + 1 }
}
