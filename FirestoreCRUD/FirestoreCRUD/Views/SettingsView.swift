//
//  SettingsView.swift
//  FirestoreCRUD
//
//  Created by user211530 on 2/12/22.
//

import SwiftUI
import FirebaseFirestore

struct SettingsView: View
{
    @State var nic = "199824100843"
    @State var uname = "Thushan"
    @State var email = "aaa@aaa.com"
    @State var pass = "1234"
    @State var mobile = "0710689099"
    
    var body: some View
    {
        Text(nic).padding(.all)
        Text(uname).padding(.all)
        Text(email).padding(.all)
        TextField("Password", text: $pass).padding(.all).disableAutocorrection(true)
        
    Spacer()
    
        Button(action: {
            self.updateData()
        }){
            Text("Update")
        }
    }
    
    private func updateData()
    {
        let db = Firestore.firestore()

            let docRef = db.collection("User").document(nic)

        docRef.updateData(
            ["email": email, "password": pass]
            ) { error in
                if let error = error {
                    print("Error updating document: \(error.localizedDescription)")
                }
                else {
                    print("Document successfully updated!")
                }
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
