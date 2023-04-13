//
//  AddNewMessageView.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import SwiftUI

struct AddNewMessageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var discussions: FetchedResults<Discussion>
    
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "thumb == TRUE"),
        animation: .default)
    private var matches: FetchedResults<Match>
    
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "name == 'Magalie'"),
        animation: .default)
    private var users: FetchedResults<User>
    
    @State private var searchText = ""
    @Binding var showModal: Bool
    
    var user: User { users[0] }
    
    var allDiscussions: [Discussion] {
        discussions.map { $0 }
    }
    
    var mostRecentPersonalDiscussions: [Discussion] {
        var mostRecent: [Discussion] = []
        let sortedDiscussions = discussions
            .map { $0 }
            .filter{ $0.discussionType == 1 }
            .filter { searchText.isEmpty ? true : $0.partnerName.lowercased().contains(searchText.lowercased())}
            .sorted { $0.lastDate > $1.lastDate }
        for i in 0..<3 {
            if i < sortedDiscussions.count {
                mostRecent.append(sortedDiscussions[i])
            }
        }
        return mostRecent
    }
    
    var mostRecentTeamDiscussions: [Discussion] {
        var mostRecent: [Discussion] = []
        let sortedDiscussions = discussions
            .map { $0 }
            .filter{ $0.discussionType == 0 }
            .filter { searchText.isEmpty ? true : $0.partnerName.lowercased().contains(searchText.lowercased())}
            .sorted { $0.lastDate > $1.lastDate }
        for i in 0..<3 {
            if i < sortedDiscussions.count {
                mostRecent.append(sortedDiscussions[i])
            }
        }
        return mostRecent
    }
    
    var sortedMatches: [Match] {
        matches.sorted { $0.matchAlias < $1.matchAlias }
            .filter { searchText.isEmpty ? true : $0.matchAlias.lowercased().contains(searchText.lowercased())}
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("DISCUSSIONS PRIVÉES RÉCENTES") {
                    ForEach(mostRecentPersonalDiscussions) { discussion in
                        if let partner = discussion.partner {
                            if let match = discussion.retrieveMatchFor(alias: partner.userAlias) {
                                NavigationLink {
                                    MessagesDetailView(discussion: discussion, user: discussion.user ?? User(context: viewContext), match: match)
                                } label: {
                                    MessagesRow(discussion: discussion)
                                }
                            }
                        }
                    }
                    .listRowInsets(.init(top: 10, leading: 5, bottom: 10, trailing: 15))
                }

                Section("DISCUSSIONS D'ÉQUIPES RÉCENTES") {
                    ForEach(mostRecentTeamDiscussions) { discussion in
                        if let _ = discussion.partner {
                            NavigationLink {
                                MessagesDetailView(discussion: discussion, user: discussion.user ?? User(context: viewContext))
                            } label: {
                                MessagesRow(discussion: discussion)
                            }
                        }
                    }
                    .listRowInsets(.init(top: 10, leading: 5, bottom: 10, trailing: 15))
                }
                
                Section("CONTACTER UN MATCH") {
                    ForEach(sortedMatches) { match in
                        let discussion = match.getDiscussion(in: allDiscussions)
                        NavigationLink {
                            MessagesDetailView(discussion: discussion, user: user, match: match)
                        } label: {
                            ContactsRow(match: match)
                        }
                    }
                    .onDelete(perform: { offsets in
                        withAnimation {
                            offsets.map { sortedMatches[$0] }.forEach(viewContext.delete)

                            do {
                                try viewContext.save()
                            } catch {
                                print(error)
                            }
                        }
                    })
                    .listRowInsets(.init(top: 10, leading: 5,bottom: 10, trailing: 15))
                }
            }
            .searchable(text: $searchText)
            .listStyle(.plain)
            .navigationBarTitle("Nouveau Message", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showModal = false
                    } label: {
                        Text("Annuler")
                    }
                }
            }
        }
    }
}

struct AddNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
            AddNewMessageView(showModal: .constant(true)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
