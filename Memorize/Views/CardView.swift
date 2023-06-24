//
//  CardView.swift
//  Memorize
//
//  Created by Amir Nourinia on 23.06.23.
//

import Foundation
import SwiftUI


struct CardView: View {
    typealias Card = MemorizeModel<String>.Card
    let card: Card
    var body: some View {
        if card.isFaceUp{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: 5)
                    .foregroundColor(.blue)
                Text(card.content)
            }
            .aspectRatio(2/3 ,contentMode: .fit)
        }
        else {
            RoundedRectangle(cornerRadius: 10).foregroundColor(.blue)
                .aspectRatio(2/3 ,contentMode: .fit)
        }
    }
}

struct preview: PreviewProvider {
    typealias Card = MemorizeModel<String>.Card
    static var previews: some View {
        let card = Card(content: ":-)", isFaceUp: true)
        CardView(card: card)
    }
}
