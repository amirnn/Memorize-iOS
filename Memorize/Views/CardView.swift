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
    let shape = RoundedRectangle(cornerRadius: ControlPanel.roundedRectengaleCornerRadius)
    
    @ViewBuilder
    var preAspectedShape: some View {
        if !card.isMatched {
            if card.isFaceUp{
                ZStack{
                    shape.foregroundColor(ControlPanel.shapeFrontColor)
                    Text(card.content).foregroundColor(ControlPanel.textColor)
                }
            }
            else {
                shape.foregroundColor(ControlPanel.shapeBackColor)
            }
        }
        else {
            shape.opacity(0)
        }
    }
    var body: some View {
        preAspectedShape.aspectRatio(ControlPanel.aspectRatio ,contentMode: .fit)
    }
    
    struct ControlPanel {
        static let aspectRatio: CGFloat = 2/3
        static let roundedRectengaleCornerRadius: CGFloat = 10
        static let shapeFrontColor: Color = .white
        static let shapeBackColor: Color = .blue
        static let textColor: Color = .black
    }
}

struct preview: PreviewProvider {
    typealias Card = MemorizeModel<String>.Card
    static var previews: some View {
        let card = Card(content: ":-)", isFaceUp: true)
        CardView(card: card)
    }
}
