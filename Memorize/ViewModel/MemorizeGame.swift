//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Amir Nourinia on 23.06.23.
//

import Foundation

class MemorizeGame: ObservableObject {
    
    static func MemorizeGameFactory() -> MemorizeGame {
        let model = MemorizeModel(contents: generateSomeCardContents(count: 4) )
        return MemorizeGame(model: model)
    }
    
    @Published
    private var model: MemorizeModel<String>
    typealias Card = MemorizeModel<String>.Card
    var cards: [Card] {
        model.cards
    }
    init(model: MemorizeModel<String>) {
        self.model = model
    }
    // MARK: Intents
    func choose(_ id: UUID) {
        model.chooseCard(id: id)
    }
}
