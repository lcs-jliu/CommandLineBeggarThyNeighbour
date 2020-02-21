//
//  Hand.swift
//  AlternateCommandLineWar
//
//  Created by Gordon, Russell on 2020-02-12.
//  Copyright © 2020 Gordon, Russell. All rights reserved.
//

import Foundation

// Class to define a hand of cards
class Hand {
    
    // Properties
    var cards : [Card]
    var description : String

    // Initializer(s)
    init(description : String) {
        self.cards = []
        self.description = description
    }
    
    // Print status of this hand
    func status(verbose: Bool) {

        // Header
        print("The \(description) hand contains \(self.cards.count) card(s).")
        
        if verbose {
            print("Those cards are:")

            // Iterate over the deck of cards
            for card in self.cards {
                
                print(card.simpleDescription())
                
            }
        }
        
        
    }
    
    // Get a look at the top card in this hand
    var topCard : Card? {
        
        // Return the top card, if there is at least one in the hand
        if self.cards.count > 0 {
            return cards.last!
        } else {
            return nil
        }

    }
    
    // Remove the top card of this hand
    func dealTopCard() -> Card? {
        
        // Deal a card, if there is at least one in the hand
        if self.cards.count > 0 {
            let cardDealt = self.cards.removeLast()
            return cardDealt
        } else {
            return nil
        }
        
    }
    
}
