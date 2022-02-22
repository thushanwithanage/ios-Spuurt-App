//
//  MovieEditView.swift
//  FirestoreCRUD
//
//  Created by user211530 on 1/17/22.
//

import SwiftUI

enum Mode
{
    case new
    case edit
}

enum Action
{
    case delete
    case done
    case cancel
}

struct MovieEditView: View
{
    @Environment(\.presentationMode) private var presentationMode
        @State var presentAtionSheet = false

        @ObservedObject var viewModel = MovieViewModel()
        var mode : Mode = .new
        var completionHandler: ((Result<Action, Error>) -> Void)?
    
        var saveButton : some View
        {
            Button(action: {
                self.handleDoneTrapped()
            }){
                Text("Save")
            }
        }
    
        var cancelButton : some View
        {
            Button(action: {
                self.handleCancelTrapped()
            }){
                Text("Cancel")
            }
        }

        var body: some View
        {
            NavigationView
            {
                Form
                {
                    Section(header: Text("Property"))
                    {
                        TextField("Title", text: $viewModel.movie.title)
                        TextField("Year", text: $viewModel.movie.year)
                    }
                    Section(header: Text("Description"))
                    {
                        TextField("Description", text: $viewModel.movie.description)
                    }

                    if mode == .edit
                    {
                        Section
                        {
                            Button("Delete movie")
                            {
                                self.presentAtionSheet.toggle()
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                .navigationTitle(mode == .new ? "New Movie" : viewModel.movie.title)
                .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
                .navigationBarItems(
                    leading: cancelButton, trailing: saveButton
                )
                .actionSheet(isPresented: $presentAtionSheet)
                {
                    ActionSheet(title: Text("Are you sure to delele the movie?"), buttons: [.destructive(Text("Delete movie"), action: {
                        self.handleDeleteTrapped()
                    }), .cancel()])
                }
            }
        }

        func handleDoneTrapped()
        {
            self.viewModel.handleDoneTrapped()
            self.dismiss()
        }

        func handleDeleteTrapped()
        {
            self.viewModel.handleDeleteTrapped()
            self.dismiss()
            self.completionHandler?(.success(.delete))
        }

        func handleCancelTrapped()
        {
            self.dismiss()
        }

        func dismiss()
        {
            self.presentationMode.wrappedValue.dismiss()
        }
}

struct MovieEditView_Previews: PreviewProvider {
    static var previews: some View
    {
        let movie = Movie(title: "title", description:"description", year: "year", image:"image")
        let MovieViewModel = MovieViewModel(movie: movie)
        return MovieEditView(viewModel: MovieViewModel, mode: .edit)
    }
}
