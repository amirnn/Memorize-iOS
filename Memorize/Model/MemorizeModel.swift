//
//  MemorizeModel.swift
//  Memorize
//
//  Created by Amir Nourinia on 23.06.23.
//

import Foundation

struct MemorizeModel<ContentType> {
    private(set) var cards: Array<Card>
    
    init(contents: [ContentType]) {
        cards = [Card]()
        contents.forEach({ content in
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        })
        cards.shuffle()
    }
    
    init(cardFactory: () -> [Card]){
        self.cards = cardFactory()
    }
    
    mutating func chooseCard(id uuid: UUID){
        let index = cards.firstIndex { card in
            card.id == uuid
        }
        if let index {
            cards[index].isFaceUp.toggle()
            print(cards)
        }
        else {
            print("Card with uuid:\(uuid), was not found!")
        }
    }
    
    struct Card: Identifiable {
        let id: UUID = UUID()
        let content: ContentType
        var isMatched: Bool = false
        var isFaceUp: Bool = false
    }
    
}
