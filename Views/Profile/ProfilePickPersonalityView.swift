//
//  ProfilePickElementView.swift
//  TeamHer
//
//  Created by Apprenant 69 on 25/03/2023.
//

import SwiftUI

struct ProfilePickPersonalityView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "name == 'Magalie'"),
        animation: .default)
    
    var users: FetchedResults<User>
    
    var user : User {
        users[0]
    }
    
    @Binding var validate : Bool
    
    var body: some View {
     
        NavigationStack {
            
            List {
                
                RowView(labelRow: "Sélection 1", personality: user.userPersonality1, numberTrait: 1, validate: $validate, user: user)
                
                RowView(labelRow: "Sélection 2", personality: user.userPersonality2, numberTrait: 2, validate: $validate, user: user)
                
                RowView(labelRow: "Sélection 3", personality: user.userPersonality3, numberTrait: 3, validate: $validate, user: user)
                
                
            }
            .listStyle(.plain)
            .navigationTitle("Personnalité")
        }
    }
}

struct ProfilePickPersonalityView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePickPersonalityView(validate: .constant(false) ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct RowView: View {
    
    var labelRow : String = "Default"
    
    @State var arr : [Personality] = Personality.allCases
    
    @State var personality : Personality
    
    @State var numberTrait : Int
    
    @Binding var validate : Bool
    
    var user : User
    
    var body: some View {

        Picker(labelRow, selection: $personality) {
            ForEach(arr, id: \.self) { element in
                Text(element.label)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                updatePersonality(user: user, per: personality, numberTrait, validate: validate)
            }
            
        }
        .pickerStyle(.navigationLink)
        

    }
    
    func updatePersonality(user: User, per: Personality, _ number: Int, validate : Bool){
        
        if number == 1 || validate == true {
            user.userPersonality1 = per
        }
        else if number == 2 || validate == true {
            user.userPersonality2 = per
        }
        else if number == 3 || validate == true {
            user.userPersonality3 = per
        }
        else {
            return
        }
        
        
    }
}



