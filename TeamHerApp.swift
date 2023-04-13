//
//  TeamHerApp.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import SwiftUI

@main
struct TeamHerApp: App {
    let persistenceController = PersistenceController.preview
    @StateObject var currentGames: AllCurrentGames = AllCurrentGames(allCurrentGamesArray: currentGamesList)

    var body: some Scene {
        WindowGroup {
            TabView {
                MatchesView()
                    .tabItem {
                        Label("Match", systemImage: "eyes") }

                CatalogView()
                    .tabItem {
                        Label("Let's play", systemImage: "gamecontroller") }

                MessagesView()
                    .tabItem {
                        Label("Messages", systemImage: "bubble.right") }

                ProfileView()
                    .tabItem {
                        Label("Profil", systemImage: "person") }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .environmentObject(currentGames)
        }
    }
}
