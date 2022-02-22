//
//  FirestoreCRUDApp.swift
//  FirestoreCRUD
//
//  Created by user211530 on 1/15/22.
//

import SwiftUI
import Firebase

@main
struct FirestoreCRUDApp: App {
    
    init()
        {
            FirebaseApp.configure()
        }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
