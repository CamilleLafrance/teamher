//
//  CatalogFeaturedReview.swift
//  TeamHer
//
//  Created by apprenant45 on 27/03/2023.
//

import SwiftUI

struct CatalogFeaturedReview: View {
    
    @State var reviewTitle: String = ""
    @State var reviewDescription: String = ""
    var editorHeight: CGFloat = 350
    @State var showPopupTryAgain: Bool = false
    @State var showPopupPublished: Bool = false
    @State var messageRight: String = "Article publié !"
    @State var messageWrong: String = "Merci de remplir tous les champs !"
    @State var buttonTint: Color = .gray
    
    func checkFilled() -> Bool {
        if reviewTitle.isEmpty || reviewDescription.isEmpty {
            return false
        } else {
            return true
        }
    } // CHECKFILLED FUNCTION
    
    var body: some View {
        
        
        VStack {
            Spacer()
            
            List {
                
                VStack (alignment: .leading){
                    
                    HStack  {
                        if reviewTitle.isEmpty {
                            Image(systemName: "circle")
                                .foregroundColor(.accentColor)
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.accentColor)
                        }
                        Text("Titre")
                    } // fin HStack titre article
                    
                    Section {
                        TextField("Overwatch 2", text: $reviewTitle)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                    } footer: {
                        Text("50 caractères max.")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                            .frame(width: 350, height: 10, alignment: .trailing)
                            .padding(.top, 15)
                    } // end section titre article
                } // end VStack Titre
                .listRowSeparator(.hidden)

                
                Section {
                    VStack (alignment: .leading){
                        HStack  {
                            if reviewDescription.isEmpty {
                                Image(systemName: "circle")
                                    .foregroundColor(.accentColor)
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                            Text("Description")
                        } // fin HStack texte article
                        ZStack {
                            TextEditor(text: $reviewDescription)
                                .frame(height: editorHeight)
                                .disableAutocorrection(true)
                            
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(.gray), lineWidth: 0.1)
                                .frame(width: 350, height: editorHeight, alignment: .top)
                            
                            if reviewDescription.isEmpty {
                                Text("Ex.: Un jeu prometteur et accessible. ")
                                    .foregroundColor(Color.gray)
                                    .opacity(0.5)
                                    .padding([.top, .leading, .trailing], 8.0)
                                    .frame(width: 350, height: editorHeight, alignment: .topLeading)
                            } else {
                                Text("")
                                    .padding(.leading, 5)
                            } // IF ELSE
                        } // VSTACK
                    } // ZSTACK
                    .listRowSeparator(.hidden)
                    
                } footer: {
                    Text("750 caractères max.")
                        .foregroundColor(Color.gray)
                        .font(.caption)
                        .frame(width: 350, height: 5, alignment: .trailing)
                }

                VStack {
                    
                    Button { // POURQUOI PAS CENTRÉ ??
                        if checkFilled() == true { showPopupPublished = true } else { showPopupTryAgain = true }
                    } label: {
                        Text("Publier")
                            .frame(width: 200)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .listRowSeparator(.hidden)
                    .offset(x: 65)
                    
                    .alert("Merci de remplir tous les champs", isPresented: $showPopupTryAgain) {
                        Button(action: {}) {
                            Text("OK")
                        }
                    } // ALERTE FIELDS
                    
                    .alert("Ta partie a bien été publiée !", isPresented: $showPopupPublished) {
                        Button(action: {}) {
                            Text("OK")
                        }
                    } // ALERTE PUBLISHED
                }
        } // LIST
            .listStyle(.plain)
            .listRowSeparator(.hidden)

    } // VSTACK
    } // BODY VIEW
} // FULL VIEW

struct CatalogFeaturedReview_Previews: PreviewProvider {
    static var previews: some View {
        CatalogFeaturedReview()
    }
}
