//
//  Rank.swift
//  AlternateCommandLineWar
//
//  Created by Gordon, Russell on 2020-02-12.
//  Copyright © 2020 Gordon, Russell. All rights reserved.
//

import Foundation

// Create an enumeration for the values a card can have in a deck
//
// This enumeration is specific to the game of War
// e.g.: Aces are high
//
enum Rank : Int {
    
    // List possible cases
    case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
    // Computed property to return rank
    // Really just a convenience property to make code more readable, it returns the raw value of the enumeration case but using the property name of "rank"
    var rank : Int {
        switch self {
            default:
                return self.rawValue
        }
    }
    
    // Computed property to return lowest rank
    static var lowestRank: Int {
        return 2
    }

    // Computed property to return highest rank
    static var highestRank: Int {
        return 14
    }
    
    // Does one rank (this instance) beat another rank?
    func beats(_ otherRank: Rank) -> Bool {
        return self.rank > otherRank.rank
    }
    
    // Report the simple description of this rank
    func simpleDescription() -> String {
       switch self {
       case .ace:
         return "Ace"
       case .jack:
         return "Jack"
       case .queen:
         return "Queen"
       case .king:
         return "King"
       default:
         return String(self.rawValue)
       }
     }
    
}
