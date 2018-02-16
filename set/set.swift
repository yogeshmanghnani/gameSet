//
//  set.swift
//  set
//
//  Created by Yogesh Manghnani on 13/02/18.
//  Copyright © 2018 Yogesh Manghnani. All rights reserved.
//

import Foundation

class Set{
    //MARK: Variables
    var deck = DeckOfCards()
    lazy var onTable = deck.drawCards(noOfCards: .twelve)
    var selectedCards = [Card]()
    var setCards = [Card]()
    var score = 0
    
    
    //MARK: Functions
    func chooseCard(cardElement card: Card){
        //Changing the status of card
        if card.isSelected {
            card.isSelected = false
            if let index = selectedCards.index(of: card){
                selectedCards.remove(at: index)
            }
        } else {
            card.isSelected = true
            selectedCards.append(card)
        }
        ifSetRemoveFromTable(cards: selectedCards)
    }
    
    func drawCards(){
        if onTable.count <= 21 {
            onTable.append(contentsOf: deck.drawCards(noOfCards: .three))
        }
    }
    
    func checkIfSet(cards: [Card]) -> Bool{
        if cards.count != 3 {return false}
        var isSet = true
        for property in 0...3{
            isSet = checkProperties(of: cards, withPropertyNumber: property) && isSet
        }
        selectedCards = []
        for card in onTable{
            card.isSelected = false
        }
        if isSet{
            score += 3
        } else {
            score -= 2
        }
        return isSet
    }
    
    func checkProperties(of cards: [Card], withPropertyNumber property: Int) -> Bool {
        var propertySet = [Int]()
        for cardNumber in cards.indices{
            let currentPropertyValue = cards[cardNumber].properties[property]
            if !propertySet.contains(currentPropertyValue) {propertySet.append(currentPropertyValue)}
        }
        let isSet = propertySet.count == 1 || propertySet.count == cards.count
        return isSet
    }
    
    func ifSetRemoveFromTable(cards: [Card]){
        if checkIfSet(cards: cards){
            for card in cards{
                if let index = onTable.index(of: card){
                    setCards.append(onTable.remove(at: index))
                }
            }
        }
    }
}


//MARK: enums
enum resultOfCheck: CustomStringConvertible{
    case allSame
    case allDifferent
    case notUniform
    var description: String{
        switch self{
        case .allDifferent: return "All Different"
        case .allSame: return "All Same"
        case .notUniform: return "Not Uniform"
        }
    }
}



