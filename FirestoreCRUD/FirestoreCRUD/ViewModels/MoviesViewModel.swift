//
//  MoviesViewModel.swift
//  FirestoreCRUD
//
//  Created by user211530 on 1/17/22.
//

import Foundation
import Combine
import FirebaseFirestore

class MoviesViewModel: ObservableObject
{
    @Published var movies = [Movie]()

    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    
    deinit{
        unsubscribe()
    }

    func unsubscribe()
    {
        if listenerRegistration != nil
        {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }

    func subscribe()
    {
        if listenerRegistration == nil
        {
            listenerRegistration = db.collection("movieList").addSnapshotListener{ (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else
                {
                    print("No documents")
                    return
                }

                self.movies = documents.compactMap { querySnapshot in
                    try? querySnapshot.data(as: Movie.self)
                }
            }
        }
    }
}
