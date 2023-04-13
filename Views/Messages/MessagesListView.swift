//
//  MessagesView.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import SwiftUI

struct MessagesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var discussions: FetchedResults<Discussion>
    
    @State var showNewMessageModal: Bool = false
    @State var searchText = ""
    
    var filteredPrivateDiscussions: [Discussion] {
        discussions
            .filter { $0.discussionType == 1 }
            .filter { searchText.isEmpty ? true : $0.partnerName.lowercased().contains(searchText.lowercased())}
            .sorted { $0.lastDate > $1.lastDate }
    }
    
    var filteredTeamDiscussions: [Discussion] {
        discussions
            .filter { $0.discussionType == 0 }
            .filter { searchText.isEmpty ? true : $0.partnerName.lowercased().contains(searchText.lowercased())}
            .sorted { $0.lastDate > $1.lastDate }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("DISCUSSIONS PRIVÉES") {
                    ForEach(filteredPrivateDiscussions) { discussion in
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
                    .onDelete(perform: { offsets in
                        withAnimation {
                            offsets.map { filteredPrivateDiscussions[$0] }.forEach(viewContext.delete)

                            do {
                                try viewContext.save()
                            } catch {
                                print(error)
                            }
                        }
                    })
                    .listRowInsets(.init(top: 10, leading: 3, bottom: 10, trailing: 15))
                }
                
                Section("DISCUSSIONS D'ÉQUIPES") {
                    ForEach(filteredTeamDiscussions) { discussion in
                        if let _ = discussion.partner {
                            NavigationLink {
                                MessagesDetailView(discussion: discussion, user: discussion.user ?? User(context: viewContext))
                            } label: {
                                MessagesRow(discussion: discussion)
                            }
                        }
                    }
                    .onDelete(perform: { offsets in
                        withAnimation {
                            offsets.map { filteredTeamDiscussions[$0] }.forEach(viewContext.delete)

                            do {
                                try viewContext.save()
                            } catch {
                                print(error)
                            }
                        }
                    })
                    .listRowInsets(.init(top: 10, leading: 3, bottom: 10, trailing: 15))
                }
            }
            .searchable(text: $searchText)
            .listStyle(.plain)
            .navigationBarTitle("Messagerie", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showNewMessageModal = true
                    } label: {
                        Text("Nouveau")
                    }
                }
            }
            .sheet(isPresented: $showNewMessageModal, content: {
                AddNewMessageView(showModal: $showNewMessageModal)
            })
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
