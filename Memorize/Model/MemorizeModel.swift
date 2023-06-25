//
//  MemorizeModel.swift
//  Memorize
//
//  Created by Amir Nourinia on 23.06.23.
//

import Foundation

struct MemorizeModel<ContentType> where ContentType: Equatable {
    private(set) var cards: [Card]
    private(set) var isGameFinished: Bool = false
    private var previouslyChosenCardIndex: Int?
    
    init(contents: [ContentType]) {
        cards = [Card]()
        contents.forEach({ content in
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        })
        cards.shuffle()
    }
    
    init(cardFactory: () -> [Card]) {
        self.cards = cardFactory()
    }
    
    mutating func chooseCard(id uuid: UUID) {
        
        let index = cards.firstIndex { card in
            card.id == uuid
        }
        // chosen card is not matched
        if let cIndex = index, !cards[cIndex].isMatched {
            
            // There is a previously chosen card
            if let pIndex = previouslyChosenCardIndex {
                // Chosen card is different than the previously chosen card, and the card is not matched.
                if cIndex != pIndex {
                    // turn all the cards down except the previously chosen card.
                    cards.indices.forEach({ if $0 != pIndex { cards[$0].isFaceUp = false } })
                    // turn the card over
                    cards[cIndex].isFaceUp = true
                    
                    // if the contents match, match the cards
                    if cards[cIndex].content == cards[pIndex].content {
                        
                        cards[cIndex].isMatched = true
                        cards[pIndex].isMatched = true
                        // unset the previously chosen card
                        // previouslyChosenCardIndex = .none
                        // turn down all the cards
                        // cards.forEach({$0.isFaceUp = false})
                        // check to see if game is finished.
                        self.isGameFinished = cards.reduce(true, {result, card in result && card.isMatched })
                    }
                    // else do nothing and turn down the cards and set the previously chosen card to nil.
                    // turn down all the cards
                    previouslyChosenCardIndex = .none
                    
                }
            }
            // There is no previously chosen card, so set the previously chosen card and flip it.
            // also check if card was not matched previously.
            else {
                previouslyChosenCardIndex = cIndex
                cards[cIndex].isFaceUp = true
                cards.indices.forEach({ if $0 != cIndex { cards[$0].isFaceUp = false } })
            }
        }
    }
    
    struct Card: Identifiable, Equatable {
        let id: UUID = UUID()
        let content: ContentType
        var isMatched: Bool = false
        var isFaceUp: Bool = false
    }
    
}
