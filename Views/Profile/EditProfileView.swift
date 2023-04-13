//
//  EditProfileView.swift
//  TeamHer
//
//  Created by Apprenant 69 on 24/03/2023.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var user: User
    @Binding var dismissModal : Bool
    @State private var originalName = ""
    @State private var originalAlias = ""
    @State private var originalAge = ""
    @State private var originalPronoun = ""
    @State private var originalLocation = ""
    @State private var originalDescription = ""
    @State private var gender: Gender = Gender(rawValue: 0) ?? .female
    @State var infos: [String: String] = ["Nom": "", "Alias": "", "Age": "", "Pronom": "", "Ville": ""]
    @State var validate : Bool = false
    @State var description : String = ""
    
    var favoriteGames: [FavoriteGame] {
        if let favGames = user.favoriteGames as? Set<FavoriteGame> {
            return Array(favGames)
        }
        return [FavoriteGame]()
    }
     
    var body: some View {
        NavigationStack {
            List {
                VStack { // HAUT DE PAGE
                    ZStack { //BANNIERE
                        Image(user.userBanner)
                            .resizable()
                            .opacity(0.3)
                            .clipShape(Rectangle())
                            .background(Rectangle().foregroundColor(.gray))
                            .frame(width: 390, height: 150)
                            .padding(.bottom, 150)
                        HStack (alignment: .bottom){ //IMAGE PROFIL
                            VStack { //PHOTO DE PROFIL
                                Image(user.userImage)
                                    .resizable()
                                    .opacity(0.3)
                                    .frame(maxWidth: 150, maxHeight: 150)
                                    .clipShape(Circle())
                                    .background(Circle().foregroundColor(.gray))
                                Button { //CHANGER PDP
                                    //
                                }label: {
                                    Text("Modifier photo de profil")
                                        .foregroundColor(.blue)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.center)
                                }
                            }//END ZSTACK PHOTO DE PROFIL
                            Button { //CHANGER BANNIERE
                                //
                            }label: {
                                Text("Changer bannière")
                                    .foregroundColor(.blue)
                                    .fontWeight(.semibold)
                            }
                            .padding(.leading, 10)
                            .padding(.bottom, 75)
                        }//HSTACK IMAGE PROFIL
                        .padding([.top, .leading, .trailing], 30.0)
                    }// END ZSTACK
                } //END VSTACK HAUT DE PAGE
                ForEach(infos.sorted(by: <), id: \.key) { label, value in
                    HStack { //ROWVIEW
                        Text(label)
                        TextField("", text: Binding(
                            get: { infos[label]! },
                            set: { infos[label] = $0
                                if label == "Age" {
                                    user.age = Int16($0) ?? Int16(originalAge)!
                                    infos[label] = $0
                                } else if label == "Alias" {
                                    user.alias = $0
                                    infos[label] = $0
                                } else if label == "Nom" {
//                                    user.name = $0
//                                    infos[label] = $0
                                } else if label == "Pronom" {
                                    user.pronoun = $0
                                    infos[label] = $0
                                } else if label == "Ville" {
                                    user.location = $0
                                    infos[label] = $0
                                }
                            }
                         ))
                            .foregroundColor(.secondary)
                            .padding(.leading)
                            .frame(maxHeight: 200)
                            .lineLimit(15, reservesSpace: true)
                        Spacer()
                        if !value.isEmpty {
                            Button {
                                infos[label] = ""
                            }label: {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }//END ROWVIEW
                }
                Picker("Gender", selection: $gender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text(gender.label)
                    } //END FOR EACH GENDER
                } //PICKER GENDER
                .pickerStyle(.navigationLink)
                Section { //DESCRIPTION
                    VStack (alignment: .leading) {
                        Text("Description")
                        HStack {
                            TextEditor(text: $description)
                                .foregroundColor(.secondary)
                                .padding(.leading)
                                .frame(width: 280, height: 100)
                                .lineLimit(15, reservesSpace: true)
                            Spacer()
                            if !description.isEmpty {
                                Button {
                                    description = ""
                                }label: {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundColor(.secondary)
                                } //BOUTON EFFACER
                            }// IF POUR AFFICHER BOUTON
                        }//STACK
                    } //VSTACK
                }// END SECTION DESCRIPTION
                .listRowSeparator(.hidden)
                
                Section {
                    NavigationLink {
                        ProfilePickPersonalityView(validate: $validate)
                    } label: {
                        Text("Personnalité")
                    } //PERSONNALITE PICKER NAVLINK
                    NavigationLink {
                        EditFavGamesList(user: user)
                    } label: {
                        Text("Jeux favoris")
                    }
                    NavigationLink {
                        MultiSelectionTest()
                    } label: {
                        Text("Critères de match")
                    }
                } // END SECTION PERSONNALITE ET CRITERE MATCH
            } //END List
            .listStyle(.plain)
            .navigationTitle("Modifier mon Profil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Valider") {
                        dismissModal = false
                        user.userDescription = description
                        user.gender = Int16(gender.rawValue)
                        do {
                            try viewContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        dismissModal = false
                        discardChanges()
                    }//BOUTON ANNULER
                }//TOOLBAR ITEM 2
            }// TOOLBAR
        }//END NAVIGATIONSTACK
        .onAppear {
            infos["Nom"] = user.userName
            infos["Alias"] = user.userAlias
            infos["Age"] = "\(user.age)"
            infos["Pronom"] = user.userPronoun
            infos["Ville"] = user.userLocation
            gender = Gender(rawValue: Int(user.gender)) ?? .female
            description = user.descriptionUser
            originalName = user.userName
            originalAlias = user.userAlias
            originalAge = "\(user.age)"
            originalPronoun = user.userPronoun
            originalLocation = user.userLocation
            originalDescription = user.descriptionUser
        }
    }
    
    func discardChanges() {
        infos["Nom"] = originalName
        infos["Alias"] = originalAlias
        infos["Age"] = "\(originalAge)"
        infos["Pronom"] = originalPronoun
        infos["Ville"] = originalLocation
        user.name = originalName
        user.alias = originalAlias
        user.age = Int16(originalAge) ?? user.age
        user.pronoun = originalPronoun
        user.location = originalLocation
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let user = PersistenceController.profileForPreview()
        return EditProfileView(user: user, dismissModal: .constant(true) ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
