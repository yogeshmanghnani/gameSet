//
//  card.swift
//  set
//
//  Created by Yogesh Manghnani on 12/02/18.
//  Copyright © 2018 Yogesh Manghnani. All rights reserved.
//

import Foundation

class Card: Hashable, Equatable, CustomStringConvertible {
    //MARK: Variables
    var color: Color
    var fill: Fill
    var number: Number
    var shape: Shape
    static var identifierFactory = 0
    var isSelected = false
    var identifier: Int
    var description: String{
        return "Color:\(self.color.description), Fill:\(self.fill.description), Number:\(self.number.description), Shape:\(self.shape.description), Identifier:\(self.identifier)"
    }
    var hashValue: Int{
        return self.identifier
    }
    var properties: [Int]{
        return [self.color.rawValue, self.fill.rawValue, self.number.rawValue, self.shape.rawValue]
    }
    
    
    //MARK: Functions
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    private static func getIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(withColor color : Int, withFill fill : Int, withNumber number: Int, withShape shape: Int){
        self.color = Color(rawValue: color) ?? .blue
        self.fill = Fill(rawValue: fill) ?? .outlined
        self.number = Number(rawValue: number) ?? .one
        self.shape = Shape(rawValue: shape) ?? .circle
        self.identifier = Card.getIdentifier()
    }
    
}






//MARK: enums
enum Color : Int, CustomStringConvertible {
    case blue = 1
    case green = 2
    case red = 3
    var description: String {
        switch self {
        case .blue: return "blue"
        case .green: return "green"
        case .red: return "red"
        }
    }
}

enum Fill : Int, CustomStringConvertible{
    case outlined = 1
    case solid = 2
    case stripe = 3
    var description: String{
        switch self{
        case .outlined: return "outlined"
        case .solid: return "solid"
        case .stripe: return "stripe"
        }
    }
}

enum Number : Int, CustomStringConvertible{
    case one = 1
    case two = 2
    case three = 3
    var description: String{
        switch self{
        case .one: return "one"
        case .two: return "two"
        case .three: return "three"
        }
    }
}

enum Shape : Int, CustomStringConvertible {
    case circle = 1
    case square = 2
    case triangle = 3
    var description: String {
        switch self{
        case .circle: return "circle"
        case .square: return "square"
        case .triangle: return "triangle"
        }
    }
}
