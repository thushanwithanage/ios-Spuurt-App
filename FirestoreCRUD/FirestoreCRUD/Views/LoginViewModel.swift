//
//  LoginViewModel.swift
//  FirestoreCRUD
//
//  Created by user211530 on 2/14/22.
//

import Foundation
import FirebaseFirestore

class LoginViewModel: ObservableObject
{
    @Published var nic:String = ""
    @Published var un:String = ""
    @Published var pw:String = ""
    @Published var em:String = ""
    
    @Published var goToSecondView: Bool = false
    
    func isValidEmail(email:String?) -> Bool
    {
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }

        // At least one uppercase, one digit, one lowercase and 4 characters total
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{4,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    func readData()
    {
        let db = Firestore.firestore()

        let docRef = db.collection("User").document(nic)

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists
            {
                let data = document.data()
                if let data = data
                {
                    //let pass = data["password"] as? String ?? ""
                    let pass = data["password"] as? String
                    
                    if (pass == self.pw)
                    {
                        let un = data["uname"]
                        print("Welcome \(un!)")
                        self.goToSecondView.toggle()
                    }
                    else
                    {
                        print("Incorrect password")
                    }
                }
            }
            else
            {
                print("Incorrect username")
            }
        }
    }
}
