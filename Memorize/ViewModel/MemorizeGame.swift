//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Amir Nourinia on 23.06.23.
//

import Foundation

class MemorizeGame: ObservableObject {
    
    static func memorizeGameFactory() -> MemorizeGame {
        let model = createModel()
        return MemorizeGame(model: model)
    }
    
    private static func createModel() -> MemorizeModel<String> {
        let emojiTheme: EmojiTheme = .animals
//        generateSomeCardContents(count: 4)
        return MemorizeModel(contents: emojiTheme.getEmojis()[0..<16].reduce([String](), {(result, string) in  result + [string]}) )
    }
    
    @Published
    private var model: MemorizeModel<String>
    typealias Card = MemorizeModel<String>.Card
    
    var cards: [Card] {
        model.cards
    }
    
    var isFinished: Bool {
        model.isGameFinished
    }
    
    init(model: MemorizeModel<String>) {
        self.model = model
    }
    // MARK: Intents
    func choose(_ id: UUID) {
        model.chooseCard(id: id)
    }
    func restart(){
        model = MemorizeGame.createModel()
    }
}
