//
//  MovieDetailsView.swift
//  FirestoreCRUD
//
//  Created by user211530 on 1/17/22.
//

import SwiftUI

struct MovieDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
        @State var presentEditMovieSheet = false
        
        @State var sheetPresented = false
    
        var movie: Movie

        private func editButton(action: @escaping () -> Void) -> some View
        {
            Button(action: { action(

            ) })
            {
                Text("Edit")
            }
        }

        var body: some View
        {
            Form
            {
                Section(header: Text("Property"))
                {
                    Text(movie.title)
                    Text(movie.description)
                }

                Section(header: Text("Price"))
                {
                    Text(movie.year)
                }
                
                Section(header: Text("Image"))
                {
                    Button(action: { sheetPresented = true })
                    {
                    Image(systemName: "placeholder image")
                        .data(url: URL(string: movie.image)!).aspectRatio(contentMode: .fit).frame(width: 250 )
                    }
                    .sheet(isPresented: $sheetPresented)
                    {
                        //DetailView()
                        DeedView(imgUrl: movie.image)
                        
                    }
                }
            }
            .navigationBarTitle(movie.title)
            /*.navigationBarItems(trailing: editButton {
                self.presentEditMovieSheet.toggle()
            })*/
            .onAppear()
            {
                //print("MovieDetailsView.onAppear() for \(self.movie.title)")
            }
            .onDisappear()
            {
                //print("MovieDetailsView.onAppear()")
            }
            .sheet(isPresented: self.$presentEditMovieSheet)
            {
                MovieEditView(viewModel: MovieViewModel(movie: movie), mode: .edit)
            }
        }
}

extension Image
{
    func data(url:URL) -> Self
    {
        if let data = try? Data(contentsOf: url)
        {
            return Image(uiImage: UIImage(data: data)!).resizable()
            
        }
        return self.resizable()
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View
    {
        let movie = Movie(title: "title", description: "description", year: "year", image: "image")
                return NavigationView {
                    MovieDetailsView(movie: movie)
                }
    }
}
