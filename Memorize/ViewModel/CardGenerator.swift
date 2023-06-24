//
//  CardGenerator.swift
//  Memorize
//
//  Created by Amir Nourinia on 24.06.23.
//

import Foundation

let emojis: [String] = [":-)", "-_-", "😃", "😆", "😎"]

func generateSomeCardContents(count: Int) -> [String] {
    let controledCount = count < emojis.count ? count : emojis.count
    let slice = emojis.shuffled()[0..<controledCount]
    return Array(slice)
}
