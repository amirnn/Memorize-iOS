//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Amir Nourinia on 27.06.23.
//

import SwiftUI

struct AspectVGrid<Item, ContentView>: View where Item: Identifiable, ContentView: View  {
    
    private let items: [Item]
    private let aspectRatio: CGFloat
    
    private let content: (Item) -> ContentView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ContentView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                let optimalWidth = AspectVGrid<Item, ContentView>.calculateMinLengthOfContent(itemCount: items.count, itemAspectRatio: aspectRatio, for: geometry)
                LazyVGrid(columns: [adaptiveGridItem(minWidth: optimalWidth)], spacing: 0){
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptiveGridItem(minWidth: CGFloat)-> GridItem {
        GridItem(.adaptive(minimum: minWidth), spacing: 0)
    }
    
    static private func myCalculateMinLengthOfContent(itemsCount:Int, itemAspectRatio: CGFloat ,for geometry: GeometryProxy) -> CGFloat {
        let gwidth = geometry.size.width * 0.9
        let gheight = geometry.size.height * 0.9
        let area =  gwidth * gheight // 2 //for some reason!
        let maximumAreaForEachItem = area / (CGFloat(itemsCount))
        let width: CGFloat = sqrt(maximumAreaForEachItem * itemAspectRatio)
        return floor(width)
    }
    
    static private func calculateMinLengthOfContent(itemCount: Int, itemAspectRatio:CGFloat, for geometry: GeometryProxy) -> CGFloat {
        
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = geometry.size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < geometry.size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(geometry.size.width / CGFloat(columnCount))
    }
}
