//
//  Suit.swift
//  AlternateCommandLineWar
//
//  Created by Gordon, Russell on 2020-02-12.
//  Copyright © 2020 Gordon, Russell. All rights reserved.
//

import Foundation

// Create an enumeration for the suits of a deck of cards
enum Suit : Int {
    
    // List possible cases
    // According to https://en.wikipedia.org/wiki/Playing_card_suit#Ranking_of_suits there is no standard ranking of suits (it varies by the game) so the rank in this enumeration is arbitrary
    case clubs = 1, diamonds = 2, hearts = 3, spades = 4
    
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
        return 1
    }

    // Computed property to return highest rank
    static var highestRank: Int {
        return 4
    }
    
    // Computed property to return glyph
    var glyph : String {
        switch self {
        case .spades:
            return "♠️"
        case .hearts:
            return "❤️"
        case .diamonds:
            return "♦️"
        case .clubs:
            return "♣️"
        }
    }
    
    // Does one rank (this instance) beat another rank?
    func beats(_ otherSuit: Suit) -> Bool {
        return self.rank > otherSuit.rank
    }
    
    // Report the simple description of this suit
    func simpleDescription() -> String {
      switch self {
      case .spades:
        return "Spades"
      case .hearts:
        return "Hearts"
      case .diamonds:
        return "Diamonds"
      case .clubs:
        return "Clubs"
      }
    }

    // Report the simple description of this suit
    func briefDescription() -> String {
      switch self {
      case .spades:
        return "S"
      case .hearts:
        return "H"
      case .diamonds:
        return "D"
      case .clubs:
        return "C"
      }
    }

    
}
