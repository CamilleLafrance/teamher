//
//  RatingView.swift
//  TeamHer
//
//  Created by Fania Ibouroihim on 24/03/2023.
//

import SwiftUI

struct RatingView: View {
    @Environment(\.presentationMode) var presentationMode

    let title : String
    @State private var rating = 0
    @State private var comment = ""
    @State private var showAlert = false
    @State private var showCommentConfirmation = false
    let maxRating = 5

    var body: some View {
        VStack {
            Text("Donne une note à ce/cette joueur.se")
                .font(.title2)
            HStack {
                ForEach(1..<maxRating + 1) { number in
                    Image(systemName: number <= rating ? "star.fill" : "star")
                        .foregroundColor(.accentColor)
                        .padding()
                        .font(.title)
                        .onTapGesture {
                            self.rating = number
                        }
                }
            }

            Text("Un petit commentaire ?")
                .padding()
            TextField("Laisse un commentaire ici...", text: $comment)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                showAlert = true
            }) {
                ProfilePersonalityView(info: "Envoyer")
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Confirmation"), message: Text("Es-tu sûr.e de vouloir envoyer ce commentaire ?"), primaryButton: .destructive(Text("Envoyer")) {
                    self.presentationMode.wrappedValue.dismiss()
                }, secondaryButton: .cancel(Text("Annuler"))

            )}

        }
        .padding()
        .navigationTitle(title)
    }
}


struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(title: "element")
    }
}
