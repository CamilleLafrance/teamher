//
//  ReportView.swift
//  TeamHer
//
//  Created by Fania Ibouroihim on 24/03/2023.
//

import SwiftUI
import UIKit

struct ReportView: View {
        
        @State private var showReportSheet = false
        @State private var showBlockSheet = false
        @State private var showReportConfirmation = false
        @State private var showBlockConfirmation = false
        @State private var reportReason = ""
        
        var body: some View {
            VStack {
                Button(action: {
                    self.showReportSheet.toggle()
                }) {
                    Image(systemName: "flag")
        
                }
            }
            .actionSheet(isPresented: $showReportSheet) {
                ActionSheet(title: Text("Cette personne ne pourra pas t’envoyer de message ou trouver ton profil."), message: nil, buttons: [
                    .default(Text("Signaler")) {
                        self.showReportReasonModal()
                    },
                    .default(Text("Bloquer")) {
                        self.showBlockConfirmationModal()
                    },
                    .cancel(Text("Annuler"))
                ])
            }
            .alert(isPresented: $showReportConfirmation) {
            Alert(title: Text("Signaler"), message: Text("Merci d'avoir signalé cette personne."), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showBlockConfirmation) {
                Alert(title: Text("Bloquer"), message: Text("Tu as bloqué cet utilisateur."), dismissButton: .default(Text("OK")))
            }
        }

    func showReportReasonModal() {
        let reportReasonModal = UIAlertController(title: "Signaler", message: "S'il-te-plaît explique-nous ton problème avec ce profil.", preferredStyle: .alert)
        
        reportReasonModal.addTextField { textField in
            textField.placeholder = "Ce profil a..."
        }
        
        reportReasonModal.addAction(UIAlertAction(title: "Annuler", style: .cancel))
        
        reportReasonModal.addAction(UIAlertAction(title: "Signaler", style: .default) { _ in
            if let reason = reportReasonModal.textFields?.first?.text {
                self.reportReason = reason
                self.showReportConfirmation.toggle()
                print("Show report confirmation: \(self.showReportConfirmation)")
            }
        })
        
        UIApplication.shared.windows.first?.rootViewController?.present(reportReasonModal, animated: true, completion: nil)
    }

        func showBlockConfirmationModal() {
            let blockConfirmationModal = UIAlertController(title: "Bloquer", message: "Es-tu sûr.e de vouloir bloquer cette personne ?", preferredStyle: .alert)
            
            blockConfirmationModal.addAction(UIAlertAction(title: "Annuler", style: .cancel))
            
            blockConfirmationModal.addAction(UIAlertAction(title: "Bloquer", style: .default) { _ in
                self.showBlockConfirmation.toggle()
            })
            
            UIApplication.shared.windows.first?.rootViewController?.present(blockConfirmationModal, animated: true, completion: nil)
        }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}

