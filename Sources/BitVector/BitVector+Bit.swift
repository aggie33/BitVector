//
//  File.swift
//  
//
//  Created by Eric Bodnick on 7/19/23.
//

import Foundation

/// A bit, which is either on or off.
public enum Bit: Comparable, CaseIterable {
    /// An off bit, or `0`.
    case off
    
    /// An on bit, or `1`.
    case on
}

extension Bit: ExpressibleByBooleanLiteral {
    /// Creates a bit from a boolean literal.
    public init(booleanLiteral: Bool) {
        switch booleanLiteral {
            case true:
                self = .on
            case false:
                self = .off
        }
    }
}

extension Bit: ExpressibleByIntegerLiteral {
    /// Creates a bit from an integer literal.
    public init(integerLiteral value: UInt32) {
        switch value {
            case 0:
                self = .off
            case 1:
                self = .on
            default:
                fatalError("Integer out of bounds")
        }
    }
}

extension Bit {
    /// Flips a bit.
    public mutating func flip() {
        switch self {
            case .off:
                self = .on
            case .on:
                self = .off
        }
    }
    
    /// Checks whether `self` is on.
    public var isOn: Bool {
        switch self {
            case .on: return true
            case .off: return false
        }
    }
    
    /// Checks whether `self` is off.
    public var isOff: Bool {
        !isOn
    }
}

extension Bit: RawRepresentable {
    /// An integer containing the bit's value.
    public var rawValue: UInt32 {
        switch self {
            case .off:
                0
            case .on:
                1
        }
    }
    
    /// Creates a bit from an integer.
    public init?(rawValue: UInt32) {
        switch rawValue {
            case 0:
                self = .off
            case 1:
                self = .on
            default:
                return nil
        }
    }
}

extension Bit: Equatable, Hashable, Codable { }

extension Bit: CustomStringConvertible {
    public var description: String {
        rawValue.description
    }
}

extension Bit {
    /// Creates a bit from an integer.
    public init?(_ integer: some BinaryInteger) {
        switch integer {
            case 0:
                self = .off
            case 1:
                self = .on
            default:
                return nil
        }
    }
    
    /// Creates a bit from a boolean.
    public init(_ boolean: Bool) {
        switch boolean {
            case false:
                self = .off
            case true:
                self = .on
        }
    }
}

