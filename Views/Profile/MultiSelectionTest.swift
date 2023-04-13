//
//  MultiSelectionTest.swift
//  TeamHer
//
//  Created by Apprenant 69 on 29/03/2023.
//

import SwiftUI

struct MultiSelectionTest: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "name == 'Magalie'"),
        animation: .default)
    
    private var users: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    
    private var matchCriteria : FetchedResults<MatchCriteria>
    
//_____________________________________________________________//
    
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
    
    struct Age {
        var name : String
        var servingAge : Set<age>
    }
    
    @State var ageSelected = Age(name: "", servingAge: [])
    
    @State var criteriaAge = age.allCases
    
    //_____________________________________________________________//
    
    @State var critetiaGender = Gender.allCases
    
    struct GenderLocalStruct {
        var name : String
        var servingGender : Set<Gender>
    }
    
    @State var genderSelected = GenderLocalStruct(name: "", servingGender: [])
    
    //_____________________________________________________________//
    
    @State var criteriaPersonality = Personality.allCases
    
    struct PersonalityLocalStruct {
        var name : String
        var servingPer : Set<Personality>
    }
    
    @State var perSelected = PersonalityLocalStruct(name: "", servingPer: [])
    
    //_____________________________________________________________//
    
    
    enum recommandation : String, CaseIterable, Identifiable {
        
        var id: Self {
            return self
        }
        case levelOne = "1"
        case levelTwo = "2"
        case levelThree = "3"
        case levelFour = "4"
        case levelFive = "5"
    }
    
    struct Recommendation {
        var name : String
        var servingRec : Set<recommandation>
    }
    
    @State var RecSelected = Recommendation(name: "", servingRec: [])
    
    @State var criteriaRecommendation = recommandation.allCases
    
    //_____________________________________________________________//
    
    var body: some View {
        NavigationStack {
            
            List {
                
                MultiSelector(
                    label: Text("Age"),
                    options: criteriaAge,
                    optionToString: {$0.rawValue},
                    selected: $ageSelected.servingAge
                )
                
                MultiSelector(
                    label: Text("Gender"),
                    options: critetiaGender,
                    optionToString: {$0.label},
                    selected: $genderSelected.servingGender
                )
                
                MultiSelector(
                    label: Text("Personnalité"),
                    options: criteriaPersonality,
                    optionToString: {$0.label},
                    selected: $perSelected.servingPer
                )
                
                MultiSelector(
                    label: Text("Niveau de recommandation"),
                    options: criteriaRecommendation,
                    optionToString: {$0.rawValue},
                    selected: $RecSelected.servingRec
                )
                
            }
            .listStyle(.inset)
        
    }
    }
}

struct MultiSelectionTest_Previews: PreviewProvider {
    static var previews: some View {
        MultiSelectionTest()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
