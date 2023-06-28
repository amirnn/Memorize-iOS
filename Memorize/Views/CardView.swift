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
    private func getTextSize(in size: CGSize) -> CGFloat {
        min(size.width, size.height) * ControlPanel.textSizeFactor
    }
    
//    private func removeSpacing(shape: Shape) -> any Shape {
//        
//    }
    
    @ViewBuilder
    var finalView: some View {
        GeometryReader { geometry in
            if !card.isMatched {
                if card.isFaceUp{
                    ZStack{
                        shape.foregroundColor(ControlPanel.shapeFrontColor)
                        shape.strokeBorder(lineWidth: ControlPanel.strokeBorderLength).foregroundColor(.blue)
                        Text(card.content)
                            .foregroundColor(ControlPanel.textColor)
                            .font(.system(size: getTextSize(in: geometry.size)))
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
    }
    var body: some View {
        finalView
    }
    
    struct ControlPanel {
        static let roundedRectengaleCornerRadius: CGFloat = 10
        static let strokeBorderLength: CGFloat = 5
        static let shapeFrontColor: Color = .white
        static let shapeBackColor: Color = .blue
        static let textColor: Color = .black
        static let textSizeFactor: CGFloat = 0.8
    }
}

struct preview: PreviewProvider {
    typealias Card = MemorizeModel<String>.Card
    static var previews: some View {
        let card = Card(content: "😎", isFaceUp: true)
        CardView(card: card)
    }
}
