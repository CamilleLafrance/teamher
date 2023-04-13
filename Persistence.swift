//
//  Persistence.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        //------------------------------------------------------------------------------------------------------------------------------//

        let user1 = User(context: viewContext)
        user1.name = "Magalie"
        user1.alias = "MagalieFollie"
        user1.image = "magalie"
        user1.banner = "bmagalie"
        user1.location = "Tourcoing"
        user1.gender = 0
        user1.age = 44
        user1.userDescription = "Je suis une femme qui aime jouer et gagner. Hésitez pas à m’ajouter sur vos friendlists !"
        user1.personality1 = 14
        user1.personality2 = 17
        user1.personality3 = 6
        user1.pronoun = "Elle"

        let user2 = User(context: viewContext)
        user2.name = "Yoyo"
        user2.alias = "YoyoDu06"
        user2.image = "yoyo"
        user2.banner = "byoyo"
        user2.gender = 1
        user2.age = 18
        user2.userDescription = "LOL a ruiné ma vie mais tranquille. Venez jouer je suis cool 👌"
        user2.personality1 = 4
        user2.personality2 = 6
        user2.personality3 = 17
        user2.pronoun = "Il"
        
        let user3 = User(context: viewContext)
        user3.alias = "Lily"
        user3.image = "lily"
        user3.gender = 3
        user3.age = 30
        user3.userDescription = "🌈 Ici pour jouer avec des personnes comme moi."
        user3.personality1 = 3
        user3.personality2 = 15
        user3.personality3 = 1
        user3.pronoun = "Iel/ Elle"
        
        let user4 = User(context: viewContext)
        user4.alias = "TheoDu13"
        user4.image = "theo"
        user4.gender = 1
        user4.age = 23
        user4.userDescription = "Je suis un homme queer qui adore jouer aux jeux vidéos 🎮🏳️‍🌈"
        user4.personality1 = 12
        user4.personality2 = 13
        user4.personality3 = 14
        user4.pronoun = "N'importe"
        
        let user5 = User(context: viewContext)
        user5.alias = "Mel88"
        user5.image = "mel"
        user5.gender = 4
        user5.age = 19
        user5.userDescription = "Salut les amis, je suis un gamer queer qui aime partager sa passion sur les réseaux sociaux 🎮⭐️"
        user5.personality1 = 0
        user5.personality2 = 17
        user5.personality3 = 8
        user5.pronoun = "Il"
        
        
        let user6 = User(context: viewContext)
        user6.alias = "Jinxettte"
        user6.image = "jinxettte"
        user6.gender = 0
        user6.age = 37
        user6.userDescription = "Femme queer et gameuse ⚡️💁🏽‍♀️ toujours prête à relever de nouveaux défis 🌞"
        user6.personality1 = 14
        user6.personality2 = 11
        user6.personality3 = 10
        user6.pronoun = "Elle"
        
        let user7 = User(context: viewContext)
        user7.alias = "Oliv22"
        user7.image = "oliv"
        user7.gender = 1
        user7.age = 29
        user7.userDescription = "Yo je suis un joueur passionné de jeux de simulation. 🎮🚀🚗"
        user7.personality1 = 6
        user7.personality2 = 16
        user7.personality3 = 1
        user7.pronoun = "Il"
        /* Profils pour discussions d'équipes */
        let user8 = User(context: viewContext)
        user8.alias = "Les Vikings 🏔️"
        user8.image = "vikings"
        let user9 = User(context: viewContext)
        user9.alias = "Legends 👌"
        user9.image = "lol2"
        let user10 = User(context: viewContext)
        user10.alias = "Valorant"
        user10.image = "valorant2"
        let user11 = User(context: viewContext)
        user11.alias = "Overwatch"
        user11.image = "overwatch2"
        let user12 = User(context: viewContext)
        user12.alias = "FortniteTeam"
        user12.image = "fortnite"
        /*-------------------------------------*/
        let user13 = User(context: viewContext)
        user13.alias = "Avalone"
        user13.image = "avalone"
        user13.gender = 1
        user13.age = 33
        user13.userDescription = "Joueur qui adore les jeux de rôle et les jeux d'aventure. 🎮🗡️🐉 "
        user13.personality1 = 17
        user13.personality2 = 10
        user13.personality3 = 7
        user13.pronoun = "Il/ Iel"
        
        let user14 = User(context: viewContext)
        user14.alias = "BeBoy32"
        user14.image = "beboy"
        user14.gender = 1
        user14.age = 26
        user14.userDescription = "J'aime la compétition et gagner 💥"
        user14.personality1 = 5
        user14.personality2 = 6
        user14.personality3 = 7
        user14.pronoun = "Il"
        
        let user15 = User(context: viewContext)
        user15.alias = "Penny09"
        user15.image = "penny"
        user15.gender = 2
        user15.age = 26
        user15.userDescription = "Salut les amis, je suis une joueuse acharnée et une militante queer. 🎮👭💪 "
        user15.personality1 = 15
        user15.personality2 = 9
        user15.personality3 = 6
        user15.pronoun = "Ielle"
        
        let user16 = User(context: viewContext)
        user16.alias = "Xia"
        user16.image = "xia"
        user16.gender = 0
        user16.age = 28
        user16.userDescription = "Ma boisson préférée? Les larmes des rageux 🍹"
        user16.personality1 = 13
        user16.personality2 = 12
        user16.personality3 = 7
        user16.pronoun = "Elle"
        
        let user17 = User(context: viewContext)
        user17.alias = "Rita675"
        user17.image = "rita"
        user17.gender = 0
        user17.age = 25
        user17.userDescription = "Eh c'est la mort qui t'as assassinée Martia 🎶 Ou nan c'est juste moi 🔪"
        user17.personality1 = 16
        user17.personality2 = 14
        user17.personality3 = 0
        user17.pronoun = "Je sais pas"
        
        let user18 = User(context: viewContext)
        user18.alias = "Fairy69"
        user18.image = "fairy"
        user18.gender = 0
        user18.age = 17
        user18.userDescription = "Que des good vibes ici ✨🧚🏾‍♀️"
        user18.personality1 = 13
        user18.personality2 = 1
        user18.personality3 = 6
        user18.pronoun = "Elle"
        
        let user19 = User(context: viewContext)
        user19.alias = "Enzo👑"
        user19.image = "enzo"
        user19.gender = 1
        user19.age = 24
        user19.userDescription = "Le king est là 🤴🏼"
        user19.personality1 = 0
        user19.personality2 = 17
        user19.personality3 = 6
        user19.pronoun = "Sa/Majesté"
        
        let user20 = User(context: viewContext)
        user20.alias = "Sultana41"
        user20.image = "sultana"
        user20.gender = 0
        user20.age = 41
        user20.userDescription = "Les barbares... c'est barbant, si t'as la ref on est potes"
        user20.personality1 = 0
        user20.personality2 = 15
        user20.personality3 = 2
        user20.pronoun = "Elle"
        
        let user21 = User(context: viewContext)
        user21.alias = "Maxxou21"
        user21.image = "maxxou"
        user21.gender = 2
        user21.age = 39
        user21.userDescription = "Mec NB, je suis là juste pour les jeux 💀"
        user21.personality1 = 13
        user21.personality2 = 10
        user21.personality3 = 7
        user21.pronoun = "Iel"
        
        let user22 = User(context: viewContext)
        user22.alias = "Laravel"
        user22.image = "lara"
        user22.gender = 0
        user22.age = 23
        user22.userDescription = "Je suis un joueur queer et j'aime partager mes aventures sur les réseaux sociaux 🏳️‍🌈🎮"
        user22.personality1 = 1
        user22.personality2 = 11
        user22.personality3 = 16
        user22.pronoun = "Il/ Elle"
        
        let user23 = User(context: viewContext)
        user23.alias = "Klem78"
        user23.image = "klem"
        user23.gender = 0
        user23.age = 34
        user23.userDescription = "Klem comme la clémentine faites gaffe je pique 🎃"
        user23.personality1 = 8
        user23.personality2 = 9
        user23.personality3 = 10
        user23.pronoun = "Elle"
        
        let user24 = User(context: viewContext)
        user24.alias = "Nastasia👊"
        user24.image = "nastasia"
        user24.gender = 0
        user24.age = 28
        user24.userDescription = "Oubliez pas, y a qu'un seul Dieu sur cette terre et c'est la bouffe 🥓"
        user24.personality1 = 17
        user24.personality2 = 8
        user24.personality3 = 15
        user24.pronoun = "Iel/ Elle"
        
        let user25 = User(context: viewContext)
        user25.alias = "Deadpool"
        user25.image = "deadpool"
        user25.gender = 3
        user25.age = 22
        user25.userDescription = "👹"
        user25.personality1 = 12
        user25.personality2 = 3
        user25.personality3 = 10
        user25.pronoun = "Iel"
        
        let user26 = User(context: viewContext)
        user26.alias = "❄︎Kisscool❄︎"
        user26.image = "kisscool"
        user26.gender = 1
        user26.age = 25
        user26.userDescription = "Streamer Twitch et compétiteur E-Sport 🏆"
        user26.personality1 = 8
        user26.personality2 = 12
        user26.personality3 = 6
        user26.pronoun = "Iel/ Il"
        
        let user27 = User(context: viewContext)
        user27.alias = "NonStopPlaying"
        user27.image = "play"
        user27.gender = 0
        user27.age = 18
        user27.userDescription = "Je ne dors pas, je ne mange pas, je joue c'est tout"
        user27.personality1 = 9
        user27.personality2 = 12
        user27.personality3 = 8
        user27.pronoun = "Elle"
        
        let user28 = User(context: viewContext)
        user28.alias = "Rainbow77"
        user28.image = "rainbow"
        user28.gender = 4
        user28.age = 30
        user28.userDescription = "Queer 🌈 Gamer 🎮 Dev indé ⚙️"
        user28.personality1 = 14
        user28.personality2 = 1
        user28.personality3 = 6
        user28.pronoun = "Iel"
        
        let user29 = User(context: viewContext)
        user29.alias = "Groovy"
        user29.image = "groovy"
        user29.gender = 2
        user29.age = 21
        user29.userDescription = "Retrouvez moi sur youtube et twitch 🌈 Sinon juste venez chill avec moi ✨"
        user29.personality1 = 1
        user29.personality2 = 16
        user29.personality3 = 7
        user29.pronoun = "Il/ Elle/ Iel"
        
        let user30 = User(context: viewContext)
        user30.alias = "Biggy"
        user30.image = "biggy"
        user30.gender = 1
        user30.age = 41
        user30.userDescription = "Big boyyyy 🫃🏿"
        user30.personality1 = 14
        user30.personality2 = 17
        user30.personality3 = 6
        user30.pronoun = "Il"
        
        //------------------------------------------------------------------------------------------------------------------------------//

        let game1 = Game(context: viewContext)
        game1.name = "Overwatch"
        game1.image = "overwatch"
        game1.platform = 1
        game1.publisher = "Blizzard"
        game1.date = formatter.date(from: "14/10/2022")
        game1.genre = 1
        game1.price = 0
        game1.url = "https://overwatch.blizzard.com"
        
        let game2 = Game(context: viewContext)
        game2.name = "Baldur's Gate 3"
        game2.image = "bg3"
        game2.platform = 1
        game2.publisher = "Larian"
        game2.date = formatter.date(from: "06/10/2020")
        game2.genre = 6
        game2.price = 59.99
        game2.url = ""

        let game3 = Game(context: viewContext)
        game3.name = "Rocket League"
        game3.image = "rl"
        game3.platform = 2
        game3.publisher = "Psyonix"
        game3.date = formatter.date(from: "07/07/2015")
        game3.genre = 1
        game3.price = 9.99
        game3.url = ""
        
        let game4 = Game(context: viewContext)
        game4.name = "League of legends"
        game4.image = "lol"
        game4.platform = 1
        game4.publisher = "Riot Games"
        game4.date = formatter.date(from: "27/10/2009")
        game4.genre = 8
        game4.price = 29.95
        game4.url = "https://www.leagueoflegends.com/fr-fr/"
        
        let game5 = Game(context: viewContext)
        game5.name = "Genshin Impact"
        game5.image = "genshin"
        game5.platform = 2
        game5.publisher = "MiHoYo"
        game5.date = formatter.date(from: "28/09/2020")
        game5.genre = 6
        game5.price = 19.99
        game5.url = "https://genshin.hoyoverse.com/fr/"
        
        let game6 = Game(context: viewContext)
        game6.name = "Valorant"
        game6.image = "valorant"
        game6.platform = 1
        game6.publisher = "Riot Games"
        game6.date = formatter.date(from: "02/06/2020")
        game6.genre = 2
        game6.price = 0
        game6.url = "https://playvalorant.com/fr-fr/"
        
        //------------------------------------------------------------------------------------------------------------------------------//

        let gameReview1 = GameReview(context: viewContext)
        gameReview1.accessibility = 9
        gameReview1.difficulty = 5
        gameReview1.content = "Grande variété de personnages jouables, différents modes de jeux challengeants"
        gameReview1.author = user1
        gameReview1.game = game1
        user1.reviews?.adding(gameReview1)
        game1.reviews?.adding(gameReview1)
        
        //------------------------------------------------------------------------------------------------------------------------------//

        let favoriteGame1 = FavoriteGame(context: viewContext)
        favoriteGame1.userName = "MagalieFolie#8675"
        favoriteGame1.main = "Genji, Ana"
        favoriteGame1.role = "DPS"
        favoriteGame1.game = game1
        favoriteGame1.user = user1
        favoriteGame1.review = "Grande variété de personnages jouables,\ndifférents modes de jeux challengeants"
        user1.favoriteGames?.adding(favoriteGame1)
        game1.favorites?.adding(favoriteGame1)
        
        let favoriteGame2 = FavoriteGame(context: viewContext)
        favoriteGame2.userName = "MagalieFolie#8675"
        favoriteGame2.main = "Tav"
        favoriteGame2.role = "Cleric"
        favoriteGame2.game = game2
        favoriteGame2.user = user1
        favoriteGame2.review = "Un jeu que j'attendais depuis longtemps, très bonne adaptation de D&D"
        user1.favoriteGames?.adding(favoriteGame2)
        game2.favorites?.adding(favoriteGame2)

        let favoriteGame3 = FavoriteGame(context: viewContext)
        favoriteGame3.userName = "MagalieFolie#8675"
        favoriteGame3.role = "Attaquante"
        favoriteGame3.game = game3
        favoriteGame3.user = user1
        favoriteGame3.review = "J'adore y jouer avec mes enfants et les plus grands. Fun et facile à prendre en main."
        user1.favoriteGames?.adding(favoriteGame3)
        game3.favorites?.adding(favoriteGame3)
        
        let favoriteGame4 = FavoriteGame(context: viewContext)
        favoriteGame4.userName = "Yoyo06"
        favoriteGame4.main = "Genji, Ana"
        favoriteGame4.role = "DPS"
        favoriteGame4.game = game1
        favoriteGame4.user = user2
        user2.favoriteGames?.adding(favoriteGame4)
        game1.favorites?.adding(favoriteGame4)
        
        let favoriteGame5 = FavoriteGame(context: viewContext)
        favoriteGame5.userName = "Yoyo06"
        favoriteGame5.main = "Tav"
        favoriteGame5.role = "Cleric"
        favoriteGame5.game = game2
        favoriteGame5.user = user2
        user2.favoriteGames?.adding(favoriteGame5)
        game2.favorites?.adding(favoriteGame5)

        let favoriteGame6 = FavoriteGame(context: viewContext)
        favoriteGame6.userName = "Yoyo06"
        favoriteGame6.role = "Attaquante"
        favoriteGame6.game = game3
        favoriteGame6.user = user2
        user2.favoriteGames?.adding(favoriteGame6)
        game3.favorites?.adding(favoriteGame6)
        
        let favoriteGame7 = FavoriteGame(context: viewContext)
        favoriteGame7.userName = "MagalieFolie#8675"
        favoriteGame7.role = "Mag"
        favoriteGame7.game = game4
        favoriteGame7.user = user1
        favoriteGame7.review = "Appréciable à mon niveau mais \ncommunauté peu accueillante."
        user1.favoriteGames?.adding(favoriteGame7)
        game4.favorites?.adding(favoriteGame7)
        
        //------------------------------------------------------------------------------------------------------------------------------//

        let match1 = Match(context: viewContext)
        match1.thumb = true
        match1.matchedUser = user2
        match1.matchingUser = user1
        user1.matchesReceived?.adding(match1)
        user2.matchesSent?.adding(match1)

        let match2 = Match(context: viewContext)
        match2.thumb = true
        match2.matchedUser = user3
        match2.matchingUser = user1
        user1.matchesReceived?.adding(match2)
        user3.matchesSent?.adding(match2)
        
        let match3 = Match(context: viewContext)
        match3.thumb = true
        match3.matchedUser = user4
        match3.matchingUser = user1
        user1.matchesReceived?.adding(match3)
        user4.matchesSent?.adding(match3)

        let match4 = Match(context: viewContext)
        match4.thumb = true
        match4.matchedUser = user5
        match4.matchingUser = user1
        user1.matchesReceived?.adding(match4)
        user5.matchesSent?.adding(match4)
        
        let match5 = Match(context: viewContext)
        match5.thumb = true
        match5.matchedUser = user6
        match5.matchingUser = user1
        user1.matchesReceived?.adding(match5)
        user6.matchesSent?.adding(match5)
        
        let match6 = Match(context: viewContext)
        match6.thumb = true
        match6.matchedUser = user7
        match6.matchingUser = user1
        user1.matchesReceived?.adding(match6)
        user7.matchesSent?.adding(match6)
        
        let match7 = Match(context: viewContext)
        match7.thumb = false
        match7.matchedUser = user13
        match7.matchingUser = user1
        user13.matchesSent?.adding(match7)
        
        let match8 = Match(context: viewContext)
        match8.thumb = false
        match8.matchedUser = user14
        match8.matchingUser = user1
        user14.matchesSent?.adding(match8)
        
        let match9 = Match(context: viewContext)
        match9.thumb = true
        match9.matchedUser = user15
        match9.matchingUser = user1
        user1.matchesReceived?.adding(match9)
        user15.matchesSent?.adding(match9)
        
        let match10 = Match(context: viewContext)
        match10.thumb = false
        match10.matchedUser = user16
        match10.matchingUser = user1
        user16.matchesSent?.adding(match10)
        
        let match11 = Match(context: viewContext)
        match11.thumb = false
        match11.matchedUser = user17
        match11.matchingUser = user1
        user17.matchesSent?.adding(match11)
        
        let match12 = Match(context: viewContext)
        match12.thumb = false
        match12.matchedUser = user18
        match12.matchingUser = user1
        user18.matchesSent?.adding(match12)
        
        let match13 = Match(context: viewContext)
        match13.thumb = false
        match13.matchedUser = user19
        match13.matchingUser = user1
        user19.matchesSent?.adding(match13)
        
        let match14 = Match(context: viewContext)
        match14.thumb = false
        match14.matchedUser = user20
        match14.matchingUser = user1
        user20.matchesSent?.adding(match14)
        
        let match15 = Match(context: viewContext)
        match15.thumb = false
        match15.matchedUser = user21
        match15.matchingUser = user1
        user21.matchesSent?.adding(match15)
        
        let match16 = Match(context: viewContext)
        match16.thumb = false
        match16.matchedUser = user22
        match16.matchingUser = user1
        user22.matchesSent?.adding(match16)
        
        let match17 = Match(context: viewContext)
        match17.thumb = false
        match17.matchedUser = user23
        match17.matchingUser = user1
        user23.matchesSent?.adding(match17)
        
        let match18 = Match(context: viewContext)
        match18.thumb = false
        match18.matchedUser = user24
        match18.matchingUser = user1
        user24.matchesSent?.adding(match18)
        
        let match19 = Match(context: viewContext)
        match19.thumb = false
        match19.matchedUser = user25
        match19.matchingUser = user1
        user25.matchesSent?.adding(match19)
        
        let match20 = Match(context: viewContext)
        match20.thumb = false
        match20.matchedUser = user26
        match20.matchingUser = user1
        user26.matchesSent?.adding(match20)
        
        let match21 = Match(context: viewContext)
        match21.thumb = false
        match21.matchedUser = user27
        match21.matchingUser = user1
        user27.matchesSent?.adding(match21)
        
        let match22 = Match(context: viewContext)
        match22.thumb = false
        match22.matchedUser = user28
        match22.matchingUser = user1
        user28.matchesSent?.adding(match22)
        
        let match23 = Match(context: viewContext)
        match23.thumb = false
        match23.matchedUser = user29
        match23.matchingUser = user1
        user29.matchesSent?.adding(match23)
        
        let match24 = Match(context: viewContext)
        match24.thumb = false
        match24.matchedUser = user30
        match24.matchingUser = user1
        user30.matchesSent?.adding(match24)
        
        //------------------------------------------------------------------------------------------------------------------------------//

        let recommandation1 = Recommandation(context: viewContext)
        recommandation1.recommandedUser = user1
        recommandation1.recommandingUser = user2
        recommandation1.comment = "Très bon joueur, bienveillant"
        user1.recommandationsReceived?.adding(recommandation1)
        user2.recommandationsSent?.adding(recommandation1)
        
        //------------------------------------------------------------------------------------------------------------------------------//
                
        let discussion1 = Discussion(context: viewContext)
        let message1 = Message(context: viewContext)
        discussion1.discussionType = 1
        discussion1.user = user1
        discussion1.user?.messagesSent?.adding(message1)
        message1.author = user1
        message1.recipient = user2
        message1.content = "Hello Yoyo, je vois que tu joues à LOL. ça te dit qu’on joue ensemble ?"
        message1.dateCreated = formatter.date(from: "20/03/2023")
        message1.discussion = discussion1
        discussion1.messages?.adding(message1)
        let message2 = Message(context: viewContext)
        discussion1.user?.messagesReceived?.adding(message2)
        message2.author = user2
        message2.recipient = user1
        message2.content = "Yep"
        message2.dateCreated = formatter.date(from: "22/03/2023")
        message2.discussion = discussion1
        discussion1.messages?.adding(message2)
        let message3 = Message(context: viewContext)
        discussion1.user?.messagesReceived?.adding(message3)
        message3.author = user1
        message3.recipient = user2
        message3.content = "Cool"
        message3.dateCreated = formatter.date(from: "23/03/2023")
        message3.discussion = discussion1
        discussion1.messages?.adding(message3)
        
        let discussion2 = Discussion(context: viewContext)
        let message4 = Message(context: viewContext)
        discussion2.discussionType = 1
        discussion2.user = user1
        discussion2.user?.messagesReceived?.adding(message4)
        message4.author = user3
        message4.recipient = user1
        message4.content = "Je suis trop nulle 😭"
        message4.dateCreated = formatter.date(from: "19/03/2023")
        message4.discussion = discussion2
        discussion2.messages?.adding(message4)
        
        let discussion3 = Discussion(context: viewContext)
        let message5 = Message(context: viewContext)
        discussion3.discussionType = 1
        discussion3.user = user1
        discussion3.user?.messagesReceived?.adding(message5)
        message5.author = user4
        message5.recipient = user1
        message5.content = "Je sais pas trop"
        message5.dateCreated = formatter.date(from: "18/03/2023")
        message5.discussion = discussion3
        discussion3.messages?.adding(message5)
        
        let discussion4 = Discussion(context: viewContext)
        let message6 = Message(context: viewContext)
        discussion4.discussionType = 1
        discussion4.user = user1
        discussion4.user?.messagesReceived?.adding(message6)
        message6.author = user5
        message6.recipient = user1
        message6.content = "Non tu conseilles ?"
        message6.dateCreated = formatter.date(from: "17/03/2023")
        message6.discussion = discussion4
        discussion4.messages?.adding(message6)
        
        let discussion5 = Discussion(context: viewContext)
        let message7 = Message(context: viewContext)
        discussion5.discussionType = 1
        discussion5.user = user1
        discussion5.user?.messagesReceived?.adding(message7)
        message7.author = user6
        message7.recipient = user1
        message7.content = "Grave"
        message7.dateCreated = formatter.date(from: "16/03/2023")
        message7.discussion = discussion5
        discussion5.messages?.adding(message7)
        
        let discussion6 = Discussion(context: viewContext)
        let message8 = Message(context: viewContext)
        discussion6.discussionType = 1
        discussion6.user = user1
        discussion6.user?.messagesReceived?.adding(message8)
        message8.author = user7
        message8.recipient = user1
        message8.content = "Retourne dans la cuisine"
        message8.dateCreated = Date()
        message8.discussion = discussion6
        discussion6.messages?.adding(message8)
        
        let discussion7 = Discussion(context: viewContext)
        let message9 = Message(context: viewContext)
        discussion7.discussionType = 0
        discussion7.user = user1
        discussion7.user?.messagesReceived?.adding(message9)
        message9.author = user8
        message9.recipient = user1
        message9.content = "Il manque une personne"
        message9.dateCreated = formatter.date(from: "20/03/2023")
        message9.discussion = discussion7
        discussion7.messages?.adding(message9)
        
        let discussion8 = Discussion(context: viewContext)
        let message10 = Message(context: viewContext)
        discussion8.discussionType = 0
        discussion8.user = user1
        discussion8.user?.messagesReceived?.adding(message10)
        message10.author = user9
        message10.recipient = user1
        message10.content = "On les a bousillés"
        message10.dateCreated = formatter.date(from: "19/03/2023")
        message10.discussion = discussion8
        discussion8.messages?.adding(message10)
        
        let discussion9 = Discussion(context: viewContext)
        let message11 = Message(context: viewContext)
        discussion9.discussionType = 0
        discussion9.user = user1
        discussion9.user?.messagesReceived?.adding(message11)
        message11.author = user10
        message11.recipient = user1
        message11.content = "Impossible"
        message11.dateCreated = formatter.date(from: "18/03/2023")
        message11.discussion = discussion9
        discussion9.messages?.adding(message11)
        
        let discussion10 = Discussion(context: viewContext)
        let message12 = Message(context: viewContext)
        discussion10.discussionType = 0
        discussion10.user = user1
        discussion10.user?.messagesReceived?.adding(message12)
        message12.author = user11
        message12.recipient = user1
        message12.content = "T'es folle"
        message12.dateCreated = formatter.date(from: "17/03/2023")
        message12.discussion = discussion10
        discussion10.messages?.adding(message12)
        
        let discussion11 = Discussion(context: viewContext)
        let message13 = Message(context: viewContext)
        discussion11.discussionType = 0
        discussion11.user = user1
        discussion11.user?.messagesReceived?.adding(message13)
        message13.author = user12
        message13.recipient = user1
        message13.content = "😂😂😂"
        message13.dateCreated = formatter.date(from: "10/03/2023")
        message13.discussion = discussion11
        discussion11.messages?.adding(message13)
        
        //------------------------------------------------------------------------------------------------------------------------------//
        
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TeamHer")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension PersistenceController {
    
    static func userForPreview() -> User {
        let viewContext = PersistenceController.preview.container.viewContext
        let user = User(context: viewContext)
        user.image = "magalie"
        user.banner = "bmagalie"
        user.name = "Magalie"
        user.alias = "MagalieFollie"
        user.age = 44
        user.pronoun = "Elle"
        user.location = "Tourcoing"
        user.userDescription = "Je suis une femme qui aime jouer et gagner. Hésitez pas à m’ajouter sur vos friendlists !"
        user.personality1 = 14
        user.personality2 = 17
        user.personality3 = 6
        return user
    }
    
    static func game1ForPreview() -> Game {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let viewContext = PersistenceController.preview.container.viewContext
        let game = Game(context: viewContext)
        game.name = "Overwatch"
        game.image = "overwatch"
        game.platform = 1
        game.publisher = "Blizzard"
        game.date = formatter.date(from: "14/10/2022")
        game.genre = 1
        game.price = 0
        game.url = "https://overwatch.blizzard.com"
        return game
    }
    
    static func game2ForPreview() -> Game {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let viewContext = PersistenceController.preview.container.viewContext
        let game = Game(context: viewContext)
        game.name = "Baldur's Gate 3"
        game.image = "bg3"
        game.platform = 1
        game.publisher = "Larian"
        game.date = formatter.date(from: "06/10/2020")
        game.genre = 6
        game.price = 59.99
        game.url = ""
        return game
    }
    
    static func game3ForPreview() -> Game {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let viewContext = PersistenceController.preview.container.viewContext
        let game = Game(context: viewContext)
        game.name = "Rocket League"
        game.image = "rl"
        game.platform = 2
        game.publisher = "Psyonix"
        game.date = formatter.date(from: "07/07/2015")
        game.genre = 1
        game.price = 9.99
        game.url = ""
        return game
    }
    
    static func game4ForPreview() -> Game {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let viewContext = PersistenceController.preview.container.viewContext
        let game = Game(context: viewContext)
        game.name = "League of legends"
        game.image = "lol"
        game.platform = 1
        game.publisher = "Riot Games"
        game.date = formatter.date(from: "27/10/2009")
        game.genre = 8
        game.price = 29.95
        game.url = "https://www.leagueoflegends.com/fr-fr/"
        return game
    }
    
    static func profileForPreview() -> User {
        let viewContext = PersistenceController.preview.container.viewContext
        let user = userForPreview()
        let game1 = game1ForPreview()
        let game2 = game2ForPreview()
        let game3 = game3ForPreview()
        let game4 = game4ForPreview()

        let favoriteGame1 = FavoriteGame(context: viewContext)
        favoriteGame1.userName = "MagalieFolie#8675"
        favoriteGame1.main = "Genji, Ana"
        favoriteGame1.role = "DPS"
        favoriteGame1.game = game1
        favoriteGame1.user = user
        user.favoriteGames?.adding(favoriteGame1)
        game1.favorites?.adding(favoriteGame1)
        
        let favoriteGame2 = FavoriteGame(context: viewContext)
        favoriteGame2.userName = "MagalieFolie#8675"
        favoriteGame2.main = "Tav"
        favoriteGame2.role = "Cleric"
        favoriteGame2.game = game2
        favoriteGame2.user = user
        user.favoriteGames?.adding(favoriteGame2)
        game2.favorites?.adding(favoriteGame2)

        let favoriteGame3 = FavoriteGame(context: viewContext)
        favoriteGame3.userName = "MagalieFolie#8675"
        favoriteGame3.role = "Attaquante"
        favoriteGame3.game = game3
        favoriteGame3.user = user
        user.favoriteGames?.adding(favoriteGame3)
        game3.favorites?.adding(favoriteGame3)
        
        let favoriteGame7 = FavoriteGame(context: viewContext)
        favoriteGame7.userName = "MagalieFolie#8675"
        favoriteGame7.role = "Mag"
        favoriteGame7.game = game4
        favoriteGame7.user = user
        user.favoriteGames?.adding(favoriteGame7)
        game4.favorites?.adding(favoriteGame7)
        
        return user
    }
}
