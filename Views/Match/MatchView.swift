//
//  MatchView.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import SwiftUI

struct MatchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var matchDone: Bool
    @State var isMatchPage = false
    
    var lorem = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet tincidunt sem. Mauris finibus vehicula massa. Ut dignissim enim eu ex ultricies
    """
    
    @State var confirmMatch = false
    @State var offset = CGSize.zero
    
    // Fetched matches
    var match: Match
    
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "thumb == FALSE"),
        animation: .default)
    private var matches: FetchedResults<Match>
    
    // Fetched discussions
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)

    private var discussions: FetchedResults<Discussion>

    var allDiscussions: [Discussion] {
        discussions.map { $0 }
    }

    var discussion : Discussion? { match.getDiscussion(in: allDiscussions)}
    
    // Fetched user
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "name == 'Magalie'"),
        animation: .default)
    
    private var users: FetchedResults<User>
    
    var user : User {
        users[0]
    }
    
    // Filter matches
//    enum FilterType {
//        case none, matched, unmatched
//    }
//    let filter: FilterType
//
//    var filteredMatches: [Match] {
//        switch filter {
//        case .none:
//            return [match]
//        case .matched:
//            return matches.filter { $0.thumb }
//        case .unmatched:
//            return matches.filter { !$0.thumb }
//        }
//    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Capsule()
                    .fill(Color("IndigoClair"))
                    .frame(width: geometry.size.width * 3, height: geometry.size.height * 3)
                
                VStack {
                    Text((match.matchAlias)) // MATCH ALIAS
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color.white)
                        .bold()
                        .frame(maxWidth: 330.0, maxHeight: 36)
                        .background(Color("AccentColor"))
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 2, x: 1, y: 1)
                    NavigationLink(destination: OtherProfileView(match: match)) {
                        Image((match.matchedUser?.userImage ?? "magalie"))
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 330, maxHeight: 353)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .gray, radius: 2, x: 1, y: 1)
                    }
                        
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.white)
                            .frame(maxWidth: 330.0, maxHeight: 110)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 4, x: -2, y: 1)
                        Text((match.matchedUser?.userDescription ?? lorem))
                            .frame(maxWidth: 320.0, maxHeight: 90)
                            .minimumScaleFactor(0.01)
                            .font(.system(size: 20))
                            .scaledToFill()
                    }
                    HStack {
                        ZStack {
                            Circle()
                                .frame(maxWidth: 90, maxHeight: 90)
                                .foregroundColor(Color.white)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                            Button {
                                deleteMatch(match: match)
                            } label: {
                                Image(systemName: "hand.thumbsdown.fill")
                                    .foregroundColor(Color("AccentColor"))
                                    .font(.system(size: 60))
                            }
                        }
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(maxWidth: 90, maxHeight: 90)
                                .foregroundColor(Color.white)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                            Button {
                                acceptMatch(match: match)
                                self.confirmMatch.toggle()
                            } label: {
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundColor(Color("AccentColor"))
                                    .font(.system(size: 60))
                            }
                        }
                    }
                    .padding()
                }
                .offset(x: offset.width * 1, y: offset.height * 0.4)
                .rotationEffect(.degrees(Double(offset.width / 40)))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            withAnimation {
                                swipeCard(width: offset.width)
                            }
                        }
                )
            }
        }
        .sheet(isPresented: $confirmMatch) {
            MatchViewModal(matchDone: $isMatchPage, match: match)
        }
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            print("\(match.matchAlias) unmatched")
            offset = CGSize(width: -500, height: 0)
            deleteMatch(match: match)
        case 150...500:
            print("\(match.matchAlias) matched")
            offset = CGSize(width: 500, height: 0)
            acceptMatch(match: match)
            self.confirmMatch.toggle()
        default:
            offset = .zero
        }
    }
    
    func deleteMatch(match: Match) {
        viewContext.delete(match)
        self.presentationMode.wrappedValue.dismiss()
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    func acceptMatch(match: Match) {
        match.thumb = true
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        let match = Match(context: PersistenceController.preview.container.viewContext)
        return MatchView(matchDone: .constant(false), match: match).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
