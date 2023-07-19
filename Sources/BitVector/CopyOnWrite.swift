//
//  File.swift
//  
//
//  Created by Eric Bodnick on 7/19/23.
//

import Foundation

/// An immutable type that can make a mutable copy of itself.
protocol ImmutableReferenceCopyable: ReferenceCopyable where Mutable.Immutable == Immutable, Mutable: PairReferenceCopyable {
    associatedtype Immutable: ImmutableReferenceCopyable = Self where Immutable.Mutable == Mutable, Immutable.Immutable == Immutable
    
    func mutableCopy() -> Mutable
}

/// A type that can be copied.
protocol ReferenceCopyable: AnyObject {
    associatedtype Mutable: ReferenceCopyable = Self where Mutable.Mutable == Mutable
    
    func mutableCopy() -> Mutable
}

/// A mutable type that can copy itself and provide an immutable version without copying.
protocol PairReferenceCopyable: ReferenceCopyable where Mutable: PairReferenceCopyable, Mutable.Immutable == Immutable, Immutable.Mutable == Mutable {
    associatedtype Immutable: ImmutableReferenceCopyable
    var immutable: Immutable { get }
}

/// A type that is immutable, but can make a mutable copy and has a mutable subclass that provides an immutable version.
typealias InheritanceReferenceCopyable = ImmutableReferenceCopyable & PairReferenceCopyable

/// A type that implements copy-on-write for `Copied`.
struct CopyOnWrite<Copied: ReferenceCopyable>: CustomStringConvertible {
    private class Box {
        var rawValue: Copied.Mutable
        
        init(rawValue: Copied.Mutable) {
            self.rawValue = rawValue
        }
    }
    
    private var box: Box
    
    public init(_ value: Copied.Mutable) {
        self.box = Box(rawValue: value)
    }
    
    /// A property meant for reading. If you modify this property, copy-on-write will not happen.
    public var reading: Copied.Mutable { box.rawValue }
    
    /// A property meant for writing. If you access this property, the type will be copied if it has multiple references.
    public var writing: Copied.Mutable {
        mutating get {
            if !isKnownUniquelyReferenced(&box) {
                box = Box(rawValue: box.rawValue.mutableCopy())
            }
            
            return box.rawValue
        }
    }
    
    public var description: String {
        String(describing: reading)
    }
}

/// A type that implements copy-on-write for a immutable-mutable pair.
struct CopyOnWritePair<Copied: ImmutableReferenceCopyable>: CustomStringConvertible {
    public typealias Mutable = Copied.Mutable
    public typealias Immutable = Copied.Immutable
    
    private enum Storage {
        case immutable(Immutable)
        case mutable(CopyOnWrite<Mutable>)
        
        var immutable: Immutable {
            switch self {
                case let .immutable(value):
                    return value
                case let .mutable(value):
                    return value.reading.immutable
            }
        }
        
        var mutable: CopyOnWrite<Mutable> {
            get {
                switch self {
                    case let .immutable(value):
                        return CopyOnWrite(value.mutableCopy())
                    case let .mutable(value):
                        return value
                }
            }
            set {
                self = .mutable(newValue)
            }
        }
    }
    
    private var storage: Storage
    
    public init(_ immutable: Immutable) {
        self.storage = .immutable(immutable)
    }
    
    public init(_ mutable: Mutable) {
        self.storage = .mutable(CopyOnWrite(mutable.mutableCopy()))
    }
    
    public init(withoutCopying mutable: Mutable) {
        self.storage = .mutable(CopyOnWrite(mutable))
    }
    
    public var immutable: Immutable {
        return storage.immutable
    }
    
    public var mutable: Mutable {
        mutating get {
            return storage.mutable.writing
        }
    }
    
    public var description: String {
        String(describing: immutable)
    }
}
