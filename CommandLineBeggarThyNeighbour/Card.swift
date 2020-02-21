//
//  Card.swift
//  AlternateCommandLineWar
//
//  Created by Gordon, Russell on 2020-02-12.
//  Copyright © 2020 Gordon, Russell. All rights reserved.
//

import Foundation

// Create a new datatype to represent a playing card
struct Card {

    // Properties
    var suit: Suit
    var rank: Rank
    
    // Does the value for this card beat another card?
    //
    func beats(_ otherCard: Card) -> Bool {
        
        // Use the beats method built into the Rank enumeration
        return self.rank.beats(otherCard.rank)
    }
    
    // Report the simple description of this card
    func simpleDescription() -> String {
        
        // Purely text-based description
        //return self.rank.simpleDescription() + " of " + self.suit.simpleDescription()
        
        // Description using the emoji
        return self.rank.simpleDescription() + " of " + self.suit.glyph
        
    }
    
}
