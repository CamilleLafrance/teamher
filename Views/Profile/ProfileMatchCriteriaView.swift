//
//  ProfileMatchCriteriaView.swift
//  TeamHer
//
//  Created by Apprenant 69 on 27/03/2023.
//

import SwiftUI

struct ProfileMatchCriteriaView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "name == 'Magalie'"),
        animation: .default)
    
    private var users: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    
    private var matchCriteria : FetchedResults<MatchCriteria>
    
    enum age : String, CaseIterable, Hashable, Identifiable {
        var id: Self {
            return self
        }
        
        case rangeTeen = "13...18"
        case rangeYoung =  "18...25"
        case rangeAdult = "25...35"
        case rangeMidleAged  =  "35...50"
        case rangeSenior =  "50...65"
        case rangeOld =  "65...100"
    }
    
//    @Binding var selected = age.
    
    @State var criteriaAge = age.allCases
    
    @State var critetiaGender = Gender.allCases
    
    @State var criteriaPersonality = Personality.allCases
    
    enum recommandation : String, CaseIterable {
        case levelOne = "1"
        case levelTwo = "2"
        case levelThree = "3"
        case levelFour = "4"
        case levelFive = "5"
    }
    
    @State var criteriaRecommendation = recommandation.allCases
    
    var body: some View {
        
        List {
            
            Picker("Age", selection: $criteriaAge) {
                ForEach(criteriaAge, id: \.self) { ageRange in
                    Text("\(ageRange.rawValue)")
                }
            }
            .pickerStyle(.navigationLink)
            
            Picker("Gender", selection: $critetiaGender) {
                ForEach(critetiaGender, id: \.self) { gender in
                    Text("\(gender.label)")
                }
            }
            .pickerStyle(.navigationLink)
                
                Picker("Personalité", selection: $criteriaPersonality) {
                    ForEach(criteriaPersonality, id: \.self) { personality in
                        Text("\(personality.label)")
                    }
            }
            .pickerStyle(.navigationLink)
            
            Picker("Niveau de recommendation", selection: $criteriaRecommendation) {
                ForEach(criteriaRecommendation, id: \.self) { niveau in
                    Text(niveau.rawValue)
                }
        }
            .pickerStyle(.navigationLink)
            
//            MultiSelector(label: "Age", options: criteriaAge, optionToString: { $0.string }, selected: .rangeTeen)
    
        }
        .listStyle(.plain)
        
    }
}

struct ProfileMatchCriteriaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileMatchCriteriaView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
