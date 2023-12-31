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
                return 0
            case .on:
                return 1
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

extension Bit {
    /// Performs a bitwise AND operation.
    public static func & (lhs: Self, rhs: Self) -> Self {
        switch (lhs, rhs) {
            case (.on, .on):
                return .on
            case (.off, .on), (.off, .off), (.on, .off):
                return .off
        }
    }
    
    /// Peforms a bitwise OR operation.
    public static func | (lhs: Self, rhs: Self) -> Self {
        switch (lhs, rhs) {
            case (.off, .off):
                return .off
            case (.on, .on), (.on, .off), (.off, .on):
                return .on
        }
    }
    
    /// Performs a bitwise XOR operation.
    public static func ^ (lhs: Self, rhs: Self) -> Self {
        switch (lhs, rhs) {
            case (.off, .on), (.on, .off):
                return .on
            case (.off, .off), (.on, .on):
                return .off
        }
    }
    
    /// Performs a bitwise NOT operation.
    public static prefix func ! (rhs: Self) -> Self {
        switch rhs {
            case .on:
                return .off
            case .off:
                return .on
        }
    }
}
