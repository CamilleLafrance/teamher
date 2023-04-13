//
//  MessageItem.swift
//  TeamHer
//
//  Created by Imen Ksouri on 25/03/2023.
//

import SwiftUI

struct MessageItem: View {
    var message: Message
    var user: User
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            HStack {

                if message.authorName == user.userName {
                    Spacer()
                }

                HStack {
                    VStack(alignment: message.authorName == user.userName ? .trailing : .leading) {
                        Text(message.messageContent)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(message.authorName == user.userName ? Color.accentColor : Color("IndigoClair"))
                            .foregroundColor(message.authorName == user.userName ? Color.white : Color.black)
                            .cornerRadius(16)
                            .overlay(
                                Image(systemName: "arrowtriangle.left.fill")
                                    .foregroundColor(message.authorName == user.userName ? Color.accentColor : Color("IndigoClair"))
                                    .rotationEffect(Angle(degrees: message.authorName == user.userName ? 230 : -40))
                                    .offset(x: message.authorName == user.userName ? 5 : -5, y: message.authorName == user.userName ? 3 : 3)
                                ,alignment: message.authorName == user.userName ? .bottomTrailing : .bottomLeading)
                            .frame(maxWidth: .infinity, alignment: message.authorName == user.userName ? .trailing : .leading)
                            .frame(width: 300)
                        
                        Text(getDate(from: message.dateCreated ?? Date()))
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(message.authorName == user.userName ? .trailing : .leading, 4)
                    }
                }

                if message.authorName != user.userName {
                    Spacer()
                }
            }
            .padding(.horizontal, 8)
        }
    }
    
    private func getDate(from date: Date) -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let minutes = minute < 10 ? "0\(minute)" : "\(minute)"
        return Calendar.current.isDateInToday(date) ? "\(hour):\(minutes)" :  "\(day)/\(month)/\(year)"
    }
}

struct MessageItem_Previews: PreviewProvider {
    static var previews: some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let viewContext = PersistenceController.preview.container.viewContext
        let message = Message(context: viewContext)
        let user = User(context: viewContext)
        message.author = user
        message.content = "Test message"
        message.dateCreated = formatter.date(from: "20/03/2023")
        return MessageItem(message: message, user: user)
    }
}
