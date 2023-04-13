//
//  RecommendListView.swift
//  TeamHer
//
//  Created by Fania Ibouroihim on 24/03/2023.
//

import SwiftUI

struct RecommendListView: View {
        let elements = ["Niveau", "Fair Play", "Acte de gentillesse", "Connaissances"]
        
        var body: some View {
            List(elements, id: \.self) { element in
                NavigationLink(
                    destination: RatingView(title: element),
                    label: {
                        Text(element)
                    })
            }
            .listStyle(.inset)
            .navigationTitle("Recommander")
        }
    }



struct RecommendListView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendListView()
    }
}
