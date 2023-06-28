//
//  MemorizeView.swift
//  Memorize
//
//  Created by Amir Nourinia on 23.06.23.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject
    private var game: MemorizeGame
    
    var body: some View {
        if !game.isFinished {
            AspectVGrid(items: game.cards, aspectRatio: ControlPanel.cardAspectRatio) { card in
                CardView(card: card)
                    .padding(ControlPanel.cardPadding)
                    .onTapGesture {
                        game.choose(card.id)
                    }
            }
        }
        else{
            Text("Game Finished! Well Done!").foregroundColor(.green).font(.largeTitle)
            Button {game.restart()}
            label: {
                Text("Restart").foregroundColor(.blue).font(.title)
            }
        }
    }
    init(game: MemorizeGame) {
        self.game = game
    }
    
    struct ControlPanel {
        static let cardAspectRatio: CGFloat = 2/3
        static let cardPadding: CGFloat = 3
    }
}

struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemorizeGame.memorizeGameFactory()
        MemorizeView(game: game)
    }
}
