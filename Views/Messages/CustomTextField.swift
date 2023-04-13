//
//  CustomTextField.swift
//  TeamHer
//
//  Created by Imen Ksouri on 25/03/2023.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = { _ in }
    var commit: () -> () = {}

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CustomTextField(placeholder: Text("Message"), text: .constant(""))
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("IndigoClair"))
        .cornerRadius(50)
        .padding()
    }
}
