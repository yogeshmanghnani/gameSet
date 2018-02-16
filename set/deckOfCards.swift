//
//  deckOfCards.swift
//  set
//
//  Created by Yogesh Manghnani on 13/02/18.
//  Copyright © 2018 Yogesh Manghnani. All rights reserved.
//

import Foundation

class DeckOfCards: CustomStringConvertible{
    //MARK: Variables
    var deck = [Card]()
    var description: String{
        var toReturn = String()
        for card in deck{
            toReturn.append("\(card.description)\n")
        }
        return toReturn
    }
    
    
    func drawCards(noOfCards: ValidDraws) -> [Card]{
        if deck.count < noOfCards.rawValue {return []}
        var toReturn = [Card]()
        for _ in 1...noOfCards.rawValue{
            let randomIndex = deck.count.arc4random
            toReturn.append(deck.remove(at: randomIndex))
        }
        return toReturn
    }
    
    
    
    
    
    //MARK: init
    init() {
        for color in 1...3 {
            for fill in 1...3{
                for number in 1...3{
                    for shape in 1...3{
                        self.deck.append(Card(withColor: color, withFill: fill, withNumber: number, withShape: shape))
                    }
                }
            }
        }
    }
}

//MARK: enum Valid Draws
enum ValidDraws: Int, CustomStringConvertible{
    case three = 3
    case twelve = 12
    var description: String{
        switch self{
        case .three: return "three"
        case .twelve: return "twelve"
        }
    }
}


//MARK: arc4random
extension Int{
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
