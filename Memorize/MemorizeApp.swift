//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Amir Nourinia on 23.06.23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let game = MemorizeGame.memorizeGameFactory()
    var body: some Scene {
        WindowGroup {
            MemorizeView(game: game)
        }
    }
}
