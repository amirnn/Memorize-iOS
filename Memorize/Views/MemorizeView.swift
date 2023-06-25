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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: ControlPanel.minimumCardWidth))]){
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                game.choose(card.id)
                            }
                    }
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
        static let minimumCardWidth: CGFloat = 65
    }
}

struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemorizeGame.memorizeGameFactory()
        MemorizeView(game: game)
    }
}
