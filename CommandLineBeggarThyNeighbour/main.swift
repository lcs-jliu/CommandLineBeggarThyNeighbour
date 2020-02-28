//
//  main.swift
//  CommandLineBeggarThyNeighbour
//
//  Created by Gordon, Russell on 2020-02-20.
//  Copyright © 2020 Gordon, Russell. All rights reserved.
//

import Foundation

// Add functionality to the String structure
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

// Add functionality to the Card structure
extension Card {
    
    // Computed property that returns true when the card is a face card
    var isFaceCard: Bool {
        if self.rank == .ace ||
            self.rank == .king ||
            self.rank == .queen ||
            self.rank == .jack {
                return true
        } else {
            return false
        }
    }
    
}

// Create a new datatype to represent a game of Beggar Thy Neighbour
class BeggarThyNeighbour {
    
    // The deck of cards
    var deck : Deck
    
    // The hands for each player
    var player : Hand
    var computer : Hand
    var offence : Hand
    var defence : Hand
    
    // The pot
    var pot : Hand
    
    // Whether to wait for user input while game is played
    var interactiveMode : Bool
    
    // How many levels of recursion we have running (how many times did a showdown get initiation)
    var recursionLevel : Int
    
    // Set up and simulate the game
    init(interactiveMode: Bool = false) {
        
        // Wait for user input while playing?
        self.interactiveMode = interactiveMode

        // Make a deck of cards
        deck = Deck()
        
        // Initialize the hands
        player = Hand(description: "player")
        computer = Hand(description: "computer")
        pot = Hand(description: "pot")
        
        // Deal to the player
        if let newCards = self.deck.randomlyDealOut(thisManyCards: 26) {
            player.cards = newCards
        }
        
        // Deal to the computer
        if let newCards = self.deck.randomlyDealOut(thisManyCards: 26) {
            computer.cards = newCards
        }
        
        // Pot is empty to begin
        pot.cards = []
        
        // Recursion level is 0 to start
        recursionLevel = 0
        
        // Player is on offence to begin (deals first)
        offence = player
        defence = computer

        // Game is about to start
        print("==========")
        print("Game start")
        print("==========\n")
        
        reportCardCount()
        
        print("Offence: Player")
        print("Defence: Computer\n")
        
        // Play the game
        play()
        
    }
    
    // This function implements the primary logic for the game of Beggar Thy Neighbour
    private func play() {
        
        // This loop will repeat until one of the players is out of cards
        while gameNotOver() {
            
            // Wait for ENTER before continuing
            waitForUserInput()
            
            // Deal a card
            deal()
            
        }
        
        // Report the ultimate winner
        reportWinner()
        
    }
    
    // Deal a card from the offence's hand
    private func deal() {
        
        // Deal from offence's hand to the pot
        pot.cards.append(offence.dealTopCard()!)
        
        // What's in the pot?
        describeCards(in: pot)
        
        // Check for showdown
        if pot.topCard!.isFaceCard {
            showDown()
        }
        
        // No showdown, so change roles
        changeWhoIsOnOffence()
        
    }
    
    /// The defence has up to four chances to trigger a new showdown (recursion!)
    func showDown() {
        
        // Increment recursion level
        recursionLevel += 1
        
        // Determine how many chances defence has to force a new showdown
        var chances = 0
        switch pot.topCard!.rank {
        case .ace:
            chances = 4
        case .king:
            chances = 3
        case .queen:
            chances = 2
        case .jack:
            chances = 1
        default:
            break
        }
        
        // Showdown begins!
        print("Showdown... with \(chances) chance(s) for the \(defence.description) on defence, recursion level is \(recursionLevel)\n")
        
        // Wait for ENTER before continuing
        waitForUserInput()
        
        // The defence deals cards to the pot...
        for chance in 1...chances {
            
            print("Chance \(chance) for \(defence.description)...")
            
            // Deal from defence to the pot, if the defence has any cards
            guard let newCard = defence.dealTopCard() else {
                
                // Report out of cards
                print("\nShowdown ended prematurely with \(defence.description) running out of cards at recursion level \(recursionLevel).\n")
                
                // Give all cards to offence
                givePotCardsToOffence()

                // End this level of recursion, offence won and got the pot
                recursionLevel -= 1
                return
                
            }
            pot.cards.append(newCard)
            
            // What's in the pot?
            describeCards(in: pot)
            
            // Wait for ENTER before continuing
            waitForUserInput()

            // Does the defence become the offence?
            if pot.topCard!.isFaceCard {
                
                // Change roles
                changeWhoIsOnOffence()
                
                // New showdown has been triggered
                showDown()
                
                // Break the loop so that the defence, at this recursion level, doesn't get another chance
                break
                
            }
            
        }
        
        // The defence did not force a new showdown before chances ran out
        // The offence has won the cards in the pot
        if pot.cards.count > 0 {
            print("\nShowdown ended when \(defence.description) on defence ran out of chances at recursion level \(recursionLevel).\n")
            givePotCardsToOffence()
        } else {
            print("Recursion level is \(recursionLevel); showdown ended at a higher recursion level.")
            print("No cards change hands.\n")
        }
        
        // End this level of recursion, offence won and got the pot
        recursionLevel -= 1
        return        
        
    }
    
    // Changes the current offence to become the defence, and vice versa
    func changeWhoIsOnOffence() {
        
        print("\nChanging roles...")
        
        if offence === player {
            print("\nOffence: Computer")
            offence = computer
            print("Defence: Player\n")
            defence = player
        } else {
            print("\nOffence: Player")
            offence = player
            print("Defence: Computer\n")
            defence = computer
        }

        reportCardCount()

    }
    
    // What's in the pot?
    func describeCards(in hand: Hand) {
        
        print("\n--- The \(hand.description) hand has \(hand.cards.count) card(s). They are...")
        
        for card in hand.cards {
            print(card.simpleDescription())
        }
        
        print("---")
        
    }
    
    // Report the winner
    func reportWinner() {
        
        print("=== GAME OVER ===")
        
        describeCards(in: player)
        describeCards(in: computer)

        if computer.cards.count == 0 {
            print("The player wins.")
        } else {
            print("The computer wins.")
        }
        
    }
    
    // Let the user see what's happening before carrying on
    func waitForUserInput() {
        
        if interactiveMode {
            print("Press ENTER to continue...", terminator: "")
            readLine()
        }
        
    }
        
    func reportCardCount() {
        print("Player has \(player.cards.count) cards.")
        print("Computer has \(computer.cards.count) cards.\n")
    }
    
    func givePotCardsToOffence() {
        
        reportCardCount()
        print("\(offence.description.capitalizingFirstLetter()) on offence will get \(pot.cards.count) cards from the pot.\n")
        // Add new cards to bottom of deck
        offence.cards.insert(contentsOf: pot.cards, at: 0)
        //offence.cards.append(contentsOf: pot.cards)
        pot.cards.removeAll()
        reportCardCount()
        
    }
    
    // Game is over when either player has no more cards
    func gameNotOver() -> Bool {
        
        if player.cards.count == 0 || computer.cards.count == 0 {
            return false
        } else {
            return true
        }
        
    }

}

// Start a game...
BeggarThyNeighbour(interactiveMode: false)
