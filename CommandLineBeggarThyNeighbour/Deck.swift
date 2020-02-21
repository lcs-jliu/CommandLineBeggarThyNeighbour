//
//  Deck.swift
//  AlternateCommandLineWar
//
//  Created by Gordon, Russell on 2020-02-12.
//  Copyright © 2020 Gordon, Russell. All rights reserved.
//

import Foundation

// A deck of cards
struct Deck {
    
    // Properties
    var cards : [Card]
    
    // Initializer
    init() {
        
        // Initalize the deck of cards
        cards = []
        
        // Iterate through suits
        for suit in Suit.lowestRank...Suit.highestRank {
            
            // iterate through ranks
            for value in Rank.lowestRank...Rank.highestRank {
                
                // Attempt to create the suit and rank
                if let newSuit = Suit(rawValue: suit),
                    let newRank = Rank(rawValue: value) {
                    
                    // Make the card
                    let newCard = Card(suit: newSuit, rank: newRank)
                    
                    // Add the card to the deck
                    cards.append(newCard)
                    
                }
                
            }
        }

    }
    
    // Prints status of the deck
    func status() {
        
        // Iterate over the deck of cards
        for card in self.cards {
            
            print(card.simpleDescription())
            
        }
    }
    
    // Randomly deals out the specified number of cards
    mutating func randomlyDealOut(thisManyCards cardsToDeal : Int) -> [Card]? {
        
        // Track cards left to deal
        var cardsLeftToDeal = cardsToDeal
        
        // Make an array that will be passed back out of the function
        var cardsDealt : [Card] = []
        
        // "Shuffle" the deck and return requested count of cards
        while cardsLeftToDeal > 0 && self.cards.count > 0 {
            
            // Generate a random number between 0 and the count of cards still left in the deck
            let position = Int.random(in: 0...self.cards.count - 1)
            
            // Copy the card at this position in the deck to the cards being returned
            cardsDealt.append(self.cards[position])
            
            // Remove the card from the deck for this position
            self.cards.remove(at: position)
            
            // We've dealt a card
            cardsLeftToDeal -= 1
            
        }
        
        // Check that we could deal the requested number of cards, otherwise return nil
        if cardsDealt.count < cardsToDeal {
            
            // Return dealt cards to deck
            self.cards.append(contentsOf: cardsDealt)
            
            // Clear cards dealt
            cardsDealt = []
            
            // Return nothing, since we couldn't deal the requested number of cards
            return nil
            
        } else {
            
            // We successfully dealt the right number of cards
            return cardsDealt
        }
        
    }
    
}
