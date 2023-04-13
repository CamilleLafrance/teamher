//
//  IGDB_APICaller.swift
//  TeamHer
//
//  Created by apprenant45 on 27/03/2023.
//

import Foundation
import IGDB_SWIFT_API

class IGDB_APICaller {

    struct AccessToken: Decodable {
        var access_token: String
        var expires_in: Int
        var token_type: String
    }

    let clientID = "sw1pzjdk81v0zo269ifhny9gnlrz3x"
    let clientSecret = "gi6nsbd62dr55oilkttq8gb0bcgme1"
    var globalAccessToken = ""
    
    let gamesID = "(125174, 126459, 1905, 11085, 2115, 176552, 153700, 119133, 2963, 115, 204462, 134832, 119277, 114795, 198689, 1372, 26128, 1184, 19698, 891, 10233, 135243, 135915, 111469, 17832, 5082, 20331, 135400, 131800, 24985, 7292, 119313, 9567, 3278, 182278, 120, 103281, 26764, 138950, 7498, 107262, 90101)"
    let currentGamesID = "(125174, 126459, 204462, 1905, 119277, 2963, 115, 114795, 111469, 119313)"
    
    let selectedFields = "name, rating, summary, url"

    private func requestAccessToken() async throws -> String {
        let url = URL(string: "https://id.twitch.tv/oauth2/token?")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "client_id=\(clientID)&client_secret=\(clientSecret)&grant_type=client_credentials";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        return await withCheckedContinuation { continuation in
            let task = URLSession.shared.dataTask(with: request) { (data1, response, error) in
                if let error = error {
                    print("Error took place \(error)")

                }
                if let data = data1 {
                    let newAccessToken: AccessToken = try! JSONDecoder().decode(AccessToken.self, from: data)
                    continuation.resume(returning: newAccessToken.access_token)
                }
            }
            task.resume()
        }
    }

    private func convertJsonDataToGameObject(_ data: String) -> [GameAPI] {
        let decoder = JSONDecoder()
        var gamesList: [GameAPI] = []

        let jsonData = Data(data.utf8)
        do {
            gamesList = try decoder.decode([GameAPI].self, from: jsonData)
        } catch {
            print(error)
        }
        return gamesList
    }

    private func convertJsonDataToCoverObject(_ data: String) -> [GameCover] {
        let decoder = JSONDecoder()
        var coverList: [GameCover] = []

        let jsonData = Data(data.utf8)
        do {
            coverList = try decoder.decode([GameCover].self, from: jsonData)
//            print(" \nCOVERLIST: \(coverList)")
        }
        catch {
            print(error)
        }
        return coverList
    }



    
    
    func GetCurrentGames(_ limit: Int) async throws -> [GameAPI] {
        return await withCheckedContinuation { continuation in
            Task.init {
                do {
                    let accessToken = try await self.requestAccessToken()
                    let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
                    var gamesList: [GameAPI] = []
                    let apicalypse = APICalypse()
                        .limit(value: Int32(limit))
                        .sort(field: "cover", order: .ASCENDING)
                        .fields(fields: selectedFields)
                        .where(query: "id = \(currentGamesID)")
                    wrapper.jsonGames(apiCalypse: apicalypse) { games in
                        gamesList = self.convertJsonDataToGameObject(games)
                        continuation.resume(returning: gamesList)
//                        print("\n CURRENT GAMES LIST\(gamesList)")
                            
                        
                    } errorResponse: { error in
                        print("\(error)")
                    }
                } catch {
                    print("Error fetching access token: \(error)")
                }
            }
        }
    }
    
    func GetGames(_ limit: Int) async throws -> [GameAPI] {
        return await withCheckedContinuation { continuation in
            Task.init {
                do {
                    let accessToken = try await self.requestAccessToken()
                    let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
                    var gamesList: [GameAPI] = []
                    let apicalypse = APICalypse()
                        .limit(value: Int32(limit))
                        .sort(field: "cover", order: .ASCENDING)
                        .fields(fields: selectedFields)
                        .where(query: "id = \(gamesID)")
                    wrapper.jsonGames(apiCalypse: apicalypse) { games in
                        gamesList = self.convertJsonDataToGameObject(games)
                        continuation.resume(returning: gamesList)
//                    print("\n GAMES LIST\(gamesList)")
                            
                        
                    } errorResponse: { error in
                        print("\(error)")
                    }
                } catch {
                    print("Error fetching access token: \(error)")
                }
            }
        }
    }
    
    func GetGamesAlpha(_ limit: Int) async throws -> [GameAPI] {
        return await withCheckedContinuation { continuation in
            Task.init {
                do {
                    let accessToken = try await self.requestAccessToken()
                    let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
                    var gamesList: [GameAPI] = []
                    let apicalypse = APICalypse()
                        .limit(value: Int32(limit))
                        .sort(field: "name", order: .ASCENDING)
                        .fields(fields: selectedFields)
                        .where(query: "id = \(gamesID)")
                    wrapper.jsonGames(apiCalypse: apicalypse) { games in
                        gamesList = self.convertJsonDataToGameObject(games)
                        continuation.resume(returning: gamesList)
//                    print("\n GAMES LIST ALPHA\(gamesList)")
                            
                        
                    } errorResponse: { error in
                        print("\(error)")
                    }
                } catch {
                    print("Error fetching access token: \(error)")
                }
            }
        }
    }
    
    
    func GetGame(_ GameID: Int) async throws -> GameAPI {
        return await withCheckedContinuation { continuation in
            Task.init {
                do {
                    let accessToken = try await self.requestAccessToken()
                    let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
                    var gamesList: [GameAPI] = []
                    let apicalypse = APICalypse()
                        .fields(fields: selectedFields)
                        .where(query: "id = \(GameID)")
                    wrapper.jsonGames(apiCalypse: apicalypse) { games in
                        gamesList = self.convertJsonDataToGameObject(games)
                        continuation.resume(returning: gamesList[0])
                    } errorResponse: { error in
                        print("\(error)")
                    }
                } catch {
                    print("Error fetching access token: \(error)")
                }
            }
        }
    }

    func GetCovers(_ limit: Int) async throws -> [GameCover] {
        return await withCheckedContinuation { continuation in
            Task.init {
                do {
                    let accessToken = try await self.requestAccessToken()
                    let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
                    var coversList: [GameCover] = []
                    let apicalypse = APICalypse()
                        .fields(fields: "game.name, height, image_id, url, width" )
                        .limit(value: Int32(limit))
                        .where(query: "game = \(gamesID)")
                        .sort(field: "image_id", order: .ASCENDING)
                    wrapper.jsonCovers(apiCalypse: apicalypse) { covers in
                        coversList = self.convertJsonDataToCoverObject(covers)
                        continuation.resume(returning: coversList)
//                        print("\nCOVERS LIST: \(coversList)")
                        
                        
                    } errorResponse: { error in
                        print("\(error)")
                    }
                } catch {
                    print("\(error)")
                }
            }
        }
    }
    
    func GetCurrentCovers(_ limit: Int) async throws -> [GameCover] {
        return await withCheckedContinuation { continuation in
            Task.init {
                do {
                    let accessToken = try await self.requestAccessToken()
                    let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
                    var coversList: [GameCover] = []
                    let apicalypse = APICalypse()
                        .fields(fields: "game.name, image_id, url" )
                        .limit(value: Int32(limit))
                        .where(query: "game = \(currentGamesID)")
                        .sort(field: "image_id", order: .ASCENDING)
                    wrapper.jsonCovers(apiCalypse: apicalypse) { covers in
                        coversList = self.convertJsonDataToCoverObject(covers)
                        continuation.resume(returning: coversList)
//                        print("\n CURRENT COVERS LIST: \(coversList)")
                        
                        
                    } errorResponse: { error in
                        print("\(error)")
                    }
                } catch {
                    print("\(error)")
                }
            }
        }
    }
    
        func getTopGames(_ numOfGames: Int) async throws -> [GameAPI] {
            return await withCheckedContinuation { continuation in
                Task.init {
                    do {
                        let accessToken = try await self.requestAccessToken()
                        let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
                        var gamesList: [GameAPI] = []
                        let apicalypse = APICalypse()
                            .fields(fields: "name, rating, summary, release_dates, cover, game_engines, game_modes, genres.name, involved_companies, multiplayer_modes, platforms, themes")
                            .limit(value: Int32(numOfGames))
                            .sort(field: "rating", order: .DESCENDING)
                            .where(query: "rating > 90")
    
                        wrapper.jsonGames(apiCalypse: apicalypse) { games in
                            gamesList = self.convertJsonDataToGameObject(games)
                            continuation.resume(returning: gamesList)
                        } errorResponse: { error in
                            print("\(error)")
                        }
                    } catch {
                        print("Error fetching access token: \(error)")
                    }
                }
            }
        }

//    func GetCover(_ GameID: Int) async throws -> Cover {
//        return await withCheckedContinuation { continuation in
//            Task.init {
//                do {
//                    let accessToken = try await self.requestAccessToken()
//                    let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
//                    var coversList: [Cover] = []
//                    let apicalypse = APICalypse()
//                        .fields(fields: "game, height, image_id, url, width" )
//                        .limit(value: Int32(1))
//                        .where(query: "game = \(gamesID)")
//                    wrapper.jsonCovers(apiCalypse: apicalypse) { covers in
//                        coversList = self.convertJsonDataToCoverObject(covers)
//                        continuation.resume(returning: coversList[0])
//                    } errorResponse: { error in
//                        print("\(error)")
//                    }
//                } catch {
//                    print("\(error)")
//                }
//            }
//        }
//    }

    private func convertJsonDataToArtworkObject(_ data: String) -> [GameArtwork] {
        let decoder = JSONDecoder()
        var artworkList: [GameArtwork] = []

        let jsonData = Data(data.utf8)
        do {
            artworkList = try decoder.decode([GameArtwork].self, from: jsonData)
        }
        catch {
            print(error)
        }
        return artworkList
    }
    
    func GetArtworks(_ limit: Int) async throws -> [GameArtwork] {
        return await withCheckedContinuation { continuation in
            Task.init {
                do {
                    let accessToken = try await self.requestAccessToken()
                    let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
                    var artworkList: [GameArtwork] = []
                    let apicalypse = APICalypse()
                        .fields(fields: "game, height, image_id, url, width" )
                        .limit(value: Int32(limit))
                        .where(query: "game = \(gamesID)")
                        .sort(field: "game", order: .ASCENDING)
                    wrapper.jsonArtworks(apiCalypse: apicalypse) { artwork in
                        artworkList = self.convertJsonDataToArtworkObject(artwork)
                        continuation.resume(returning: artworkList)
//                        print("\n ARTWORKS URL: \(artworkList)")
                    } errorResponse: { error in
                        print("\(error)")
                    }
                } catch {
                    print("\(error)")
                }
            }
        }
    }

    func GetArtwork(_ GameID: Int) async throws -> GameArtwork {
        return await withCheckedContinuation { continuation in
            Task.init {
                do {
                    let accessToken = try await self.requestAccessToken()
                    let wrapper: IGDBWrapper = IGDBWrapper(clientID: self.clientID, accessToken: accessToken)
                    var artworkList: [GameArtwork] = []
                    let apicalypse = APICalypse()
                        .fields(fields: "game, height, image_id, url, width" )
                        .limit(value: Int32(1))
                        .where(query: "game = \(GameID)")
                    wrapper.jsonCovers(apiCalypse: apicalypse) { artwork in
                        artworkList = self.convertJsonDataToArtworkObject(artwork)
                        continuation.resume(returning: artworkList[0])
                    } errorResponse: { error in
                        print("\(error)")
                    }
                } catch {
                    print("\(error)")
                }
            }
        }
    }
    
}




