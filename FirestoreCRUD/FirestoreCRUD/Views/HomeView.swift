//
//  HomeView.swift
//  FirestoreCRUD
//
//  Created by user211530 on 2/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @StateObject var viewModel = MoviesViewModel()
    @State var presentAddMovieSheet = false
    
    @State private var searchQuery: String = "" //New code
    @State var isSearching:Bool = false
    
    let province = ["Colombo", "Kandy", "Matara", "Galle"]
    @State private var selectedProvince = "Colombo"
    
    @State var navigationButtonID = UUID()
    
    private var addButton: some View
        {
            Button(action: {
                self.presentAddMovieSheet.toggle()
            }) {
                Image(systemName: "plus")
            }
        }
    
    private func movieRowView(movie: Movie) -> some View
        {
                NavigationLink(destination: MovieDetailsView(movie: movie))
                {
                        VStack(alignment: .leading)
                        {
                            Text(movie.title).font(.headline)
                            Text(movie.year).font(.subheadline)
                        }
                }
        }
    
    init()
    {
        self.navigationButtonID = UUID()
    }
    
    var body: some View
    {
        NavigationView
                {
                    VStack
                    {
                        HStack
                        {
                            TextField("Price", text: $searchQuery).padding(.leading, 24)
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(6)
                        .padding(.horizontal)
                        .onTapGesture {
                            isSearching = true
                        }
                        .overlay{
                            HStack
                            {
                                Image(systemName: "magnifyingglass")
                                Spacer()
                                
                                if isSearching
                                {
                                    Button(action:
                                            { searchQuery=""
                                            })
                                    {
                                        Image(systemName: "xmark.circle.fill").padding(.vertical)
                                        
                                    }
                                }
                                
                            }
                            .padding(.horizontal, 32)
                            .foregroundColor(.gray)
                        }
                        
                        HStack
                        {
                            Picker(selection: $selectedProvince,
                                           label:
                                        HStack {
                                            TextField("Province", text: $selectedProvince)
                                        }
                                    
                                    )
                            {
                                        ForEach(province, id: \.self) { province in
                                            Text(province).tag(province)
                                        }
                                    }
                                .id(self.navigationButtonID)
                                .pickerStyle(MenuPickerStyle())
                        }
                        
                            List
                            {
                                //TextField("Search", text: $searchQuery)
                                
                                //ForEach(viewModel.movies.filter { $0.description.contains(searchQuery) || searchQuery.isEmpty } )
                                ForEach(viewModel.movies.filter { ($0.description.contains(selectedProvince)) && ($0.year.contains(searchQuery) || searchQuery.isEmpty) }  )
                                { movie in
                                    movieRowView(movie: movie)
                                    /*if movie.description == "Kandy"
                                    {
                                        movieRowView(movie: movie)
                                        
                                    }*/
                                }
                            }
                            //.searchable(text: $searchQuery, placement: .toolbar)
                            .navigationBarTitle("Property")
                            //.navigationBarItems(trailing: addButton)
                            .onAppear()
                            {
                                //print("MovieListView appears. Subscribing to data updates")
                                self.viewModel.subscribe()
                            }
                            .sheet(isPresented: self.$presentAddMovieSheet)
                            {
                                MovieEditView()
                            }
                    }
                }
               
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
