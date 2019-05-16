//
//  ArrayNotifier.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 10/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
infix operator <-: AssignmentPrecedence

public protocol ArrayNotifierDelegate{
    func didAppend(Element:Any)
}

public class ArrayNotifier<T> : Collection{
    private var contents:[T] = []
    public var delegate:ArrayNotifierDelegate?
    
    
    public typealias Index = Int
    
    public var startIndex: Index{
        return contents.startIndex
    }
    
    public var endIndex: Index{
        return contents.endIndex
    }
    
    public subscript (position:Index) -> T{
        return contents[position]
    }
    
    public func index(after i: Int) -> Int {
        return contents.index(after: i)
    }
    
    public func append(newElement:T){
        contents.append(newElement)
        delegate?.didAppend(Element: newElement)
    }
    
    static func <-(left:ArrayNotifier<T>, right:Array<T>){
        left.contents = right
    }
}
