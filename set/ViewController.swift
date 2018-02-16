//
//  ViewController.swift
//  set
//
//  Created by Yogesh Manghnani on 12/02/18.
//  Copyright © 2018 Yogesh Manghnani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Variables
    @IBOutlet var cardButtons: [UIButton]!
    var game = Set()
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    //MARK: Computed properties
    var cardAndButtonAssociation : [UIButton : Card]{
        var toReturn = [UIButton : Card]()
        for index in game.onTable.indices {
            toReturn[cardButtons[index]] = game.onTable[index]
        }
        return toReturn
    }
    
    
    
    //MARK: Actions
    @IBAction func touchCard(_ sender: UIButton) {
        if let card = cardAndButtonAssociation[sender] {
            game.chooseCard(cardElement: card)
            print(card.description)
        }
        updateViewFromModel()
        
        
    }
    
    
    @IBAction func drawCards(_ sender: UIButton) {
        game.drawCards()
        updateViewFromModel()
    }
    
    
    //MARK: Functions
    func updateViewFromModel(){
        //Updating score
        scoreLabel.text = "Score: \(game.score)"
        let currentAssociation = cardAndButtonAssociation
        for button in cardButtons{
            if let card = currentAssociation[button]{
                button.setAttributedTitle(getAttributedString(of: card), for: .normal)
                if card.isSelected{
                    button.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5411764706, blue: 0.9137254902, alpha: 1)
                } else {
                    button.backgroundColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
                }
            } else {
                button.setAttributedTitle(NSAttributedString(), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
    }
    
    func getAttributedString(of card: Card) -> NSAttributedString{
        let colorToView : [Color:UIColor] = [.blue:#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), .green:#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), .red:#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)]
        let strokeToView : [Fill:NSNumber] = [.outlined:10, .solid:-10, .stripe:-10]
        let alpha : [Fill:CGFloat] = [.outlined:0, .solid:1, .stripe:0.5]
        let numberToView : [Number:Int] = [.one:1, .two:2, .three:3]
        let size : [Number:CGFloat] = [.one:48, .two:36, .three:24]
        let shapeToView : [Shape:String] = [.square:"■", .circle:"●", .triangle:"▲"]
        let attributes : [NSAttributedStringKey: Any] = [
            .foregroundColor : colorToView[card.color]!.withAlphaComponent(alpha[card.fill]!),
            .strokeWidth : strokeToView[card.fill]!,
            .strokeColor : colorToView[card.color]!,
            .font : UIFont.init(name: "Arial", size: size[card.number]!) ?? UIFont()
        ]
        var string = String()
        for _ in 1...numberToView[card.number]!{
            string.append(shapeToView[card.shape]!)
        }
        return NSAttributedString.init(string: string, attributes: attributes)
    }
    
    
    
}

