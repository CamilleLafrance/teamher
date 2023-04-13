//
//  MessagesDetailView.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import SwiftUI

struct MessagesDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var discussions: FetchedResults<Discussion>
    
    @State private var newMessage: String = ""
    
    var discussion: Discussion?
    var user: User
    var match: Match?
    @FocusState var messageIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 1) {
            ZStack {
                Color("IndigoClair")
                    .ignoresSafeArea()
                HStack(spacing: 20) {
                    Image(discussion?.partnerImage ?? (match?.matchImage)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(50)
                    Text(discussion?.partnerName ?? (match?.matchAlias)!)
                        .font(.title).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            .frame(height: 80)
            
            ZStack {
                Color("IndigoClair")
                ScrollView {
                    ForEach(discussion?.allMessages ?? []) { message in
                        if let message = message {
                            MessageItem(message: message, user: user)
                        }
                    }
                }
                .padding(.top, 10)
                .background(.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .onTapGesture {
                    messageIsFocused = false
                }
            }

            HStack {
                CustomTextField(placeholder: Text("Message"), text: $newMessage)
                    .focused($messageIsFocused)
                    .onSubmit {
                        guard !newMessage.isEmpty else { return }
                        addMessage(user: user, content: newMessage)
                        do {
                            try viewContext.save()
                        } catch {
                            print(error)
                        }
                        newMessage = ""
                    }
                Button {
                    guard !newMessage.isEmpty else { return }
                    addMessage(user: user, content: newMessage)
                    do {
                        try viewContext.save()
                    } catch {
                        print(error)
                    }
                    newMessage = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.accentColor)
                        .opacity(newMessage.isEmpty ? 0.3 : 1)
                        .cornerRadius(50)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color("IndigoClair"))
            .cornerRadius(50)
            .padding()
        }
        .toolbar {
            NavigationLink {
                OtherProfileView(match: match ?? Match(context: viewContext))
            } label: {
                Text("Voir profil")
            }
        }
    }
    
    private func addMessage(user: User, content: String) {
        if let match = match, let discussion {
            if let index = discussions.firstIndex(of: discussion ) {
                let discussion = discussions[index]
                let message = Message(context: viewContext)
                discussion.user?.messagesSent?.adding(message)
                message.author = user
                message.recipient = match.matchedUser
                message.content = content
                message.dateCreated = Date()
                message.discussion = discussion
                discussion.messages?.adding(message)
                return
            }
        } else if let discussion = discussion {
            if let index = discussions.firstIndex(of: discussion ) {
                let discussion = discussions[index]
                let message = Message(context: viewContext)
                discussion.user?.messagesSent?.adding(message)
                message.author = user
                message.recipient = discussion.partner
                message.content = content
                message.dateCreated = Date()
                message.discussion = discussion
                discussion.messages?.adding(message)
                return
            }
        }
        let discussion = Discussion(context: viewContext)
        let message = Message(context: viewContext)
        discussion.discussionType = 1
        discussion.user = user
        discussion.user?.messagesSent?.adding(message)
        message.author = user
        message.recipient = match?.matchedUser
        message.content = content
        message.dateCreated = Date()
        message.discussion = discussion
        discussion.messages?.adding(message)
        return
    }
}

struct MessagesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let discussion = Discussion(context: viewContext)
        let user = User(context: viewContext)
        let match = Match(context: viewContext)
        return NavigationStack {
            MessagesDetailView(discussion: discussion, user: user, match: match).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}

// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
