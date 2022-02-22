//
//  LoginView.swift
//  FirestoreCRUD
//
//  Created by user211530 on 2/12/22.
//

import SwiftUI
import FirebaseFirestore

struct LoginView: View {
    
    @StateObject var viewModel = MoviesViewModel()
    @State var presentAddMovieSheet = false
    
    /*@State var nic = ""
    @State var un = ""
    @State var pw = ""
    @State var em = ""*/
    
    //@Binding var show : Bool
    
    @State var goToSecondView = false
    @StateObject var loginViewModel = LoginViewModel()
    //var contentView = ContentView()
    
    
    
    var body: some View
    {
        NavigationView{
            
            VStack{
                TextField("Nic No", text: $loginViewModel.nic).padding(.all).disableAutocorrection(true)
                TextField("Username", text: $loginViewModel.un).padding(.all).disableAutocorrection(true)
                TextField("Email", text:  $loginViewModel.em).padding(.all).disableAutocorrection(true).keyboardType(.emailAddress)
                TextField("Password", text: $loginViewModel.pw).padding(.all).disableAutocorrection(true)
                
            Spacer()
            
                /*Button(action: {
                    self.saveData()
                }){
                    Text("Save")
                }
                
               Spacer()*/
            
                Button(action: {
                    loginViewModel.readData()
                }){
                    Text("Get Data")
                }
            
            //Spacer()
            
           /* Button(action: {
                self.updateData()
            }){
                Text("Update Data")
            }*/
                
                NavigationLink(destination: HomeView(), isActive : $loginViewModel.goToSecondView)
                {
                    EmptyView()
                }
            }
        } // End of navigation
    
       
    }
    
/*private func saveData()
{
    if (nic.isEmpty ||  nic.count > 12 || nic.count < 10 || nic.count == 11)
    {
        print("Incorrent Nic number")
    }
    else if(un.isEmpty || un.count <= 5)
    {
        print("Username should be 5 characters")
    }
    else if(!isValidEmail(email: em) || em.isEmpty)
    {
        print("Incorrect email address")
    }
    else if (pw.isEmpty || !isValidPassword(testStr: pw))
    {
        print("Password strength is low")
    }
    else
    {
        let db = Firestore.firestore()
        
        db
            .collection("User")
            .document(nic)
            .setData([
                "nicNo": nic,
                "email": em,
                "password": pw,
                "uname": un
            ])
        {
            error in
               if let error = error {
                   print("Error writing document: \(error)")
               } else {
                   print("Document successfully written!")
               }
        }
    }
}*/
    
    /*private func updateData()
    {
        let db = Firestore.firestore()

            let docRef = db.collection("User").document(nic)

        docRef.updateData(
            ["email": em, "password": pw]
            ) { error in
                if let error = error {
                    print("Error updating document: \(error.localizedDescription)")
                }
                else {
                    print("Document successfully updated!")
                }
            }
        
    }*/

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
