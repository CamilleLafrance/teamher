//
//  MessagesRow.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import SwiftUI

struct MessagesRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var discussions: FetchedResults<Discussion>
    
    var discussion: Discussion
    
    var body: some View {
        HStack {
            Image(discussion.partnerImage)
                .resizable()
                .scaledToFill()
                .mask(Circle())
                .frame(width: 50, height: 15)
                .padding()
                .overlay(Circle().stroke((Color.accentColor), lineWidth: 3))
            VStack(alignment: .leading) {
                Text(discussion.partnerName)
                    .bold()
                    .foregroundColor(.accentColor)
                Text(discussion.lastMessage)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            Spacer()
            Text(getDate(from: discussion.lastDate))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(height: 50)
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

struct MessagesRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let discussion = Discussion(context: viewContext)
        return List {
            MessagesRow(discussion: discussion)
        }
        .listStyle(.plain)
    }
}
