//
//  MovieViewModel.swift
//  FirestoreCRUD
//
//  Created by user211530 on 1/17/22.
//

import Foundation
import Combine
import FirebaseFirestore

class MovieViewModel: ObservableObject
{
    @Published var movie: Movie
    @Published var modified = false
    
    
    private var cancellable = Set<AnyCancellable>()

    init(movie: Movie = Movie(title: "", description: "", year: "", image:""))
    {
        self.movie = movie

        self.$movie.dropFirst().sink
        {
            [weak self] movie in self?.modified = true
        }
        .store(in: &self.cancellable)
    }

    // Firestore

    private var db = Firestore.firestore()

    private func addMovie(_ movie: Movie)
    {
        do
        {
            let _ = try db.collection("movieList").addDocument(from: movie)
        }
        catch
        {
            print(error)
        }
    }

    private func updateMovie(_ movie: Movie)
    {
        if let documentId = movie.id
        {
            do{
                try db.collection("movieList").document(documentId).setData(from: movie)
            }
            catch
            {
                print(error)
            }
        }
    }

    private func updateOrAddMovie()
    {
        if let _ = movie.id
        {
            self.updateMovie(self.movie)
        }
        else
        {
            addMovie(movie)
        }
    }

    private func removeMovie()
    {
        if let documentId = movie.id
        {
            db.collection("movieList").document(documentId).delete
            {
                error in

                if let error = error
                {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Save button click
    func handleDoneTrapped()
    {
        self.updateOrAddMovie()
    }

    func handleDeleteTrapped()
    {
        self.removeMovie()
    }
}
