//
//  UploadImageView.swift
//  FirestoreCRUD
//
//  Created by user211530 on 2/12/22.
//

import SwiftUI
import FirebaseStorage
import Combine

let FILE_NAME = "images/imageFileTest2.jpg"


struct UploadImageView: View {
        @State var shown = false
        @State var imageURL = ""
    
    @State var imgLink2 = ""
    
        var body: some View {
            VStack {
                //if imageURL != "" {
                    //FirebaseImageView(imageURL: imageURL)
               // }
                
                
                if !imgLink2.isEmpty
                {
                    Text("Download url\(imgLink2)")
                }
                /*else
                {
                    Text("No data")
                }*/
                
                Button(action:
                        { self.shown.toggle()
                     //print(imgLink2)
                })
                {
                    Text("Upload Image").font(.title).bold()
                    
                    
                }.sheet(isPresented: $shown) {
                    imagePicker(shown: self.$shown,imageURL: self.$imageURL, imgLink2: self.$imgLink2)
                    }.padding(10).background(Color.purple).foregroundColor(Color.white).cornerRadius(20)
            }.onAppear(perform: showDownloadUrl)
        }
    
    
        func showDownloadUrl()
        {
            if(!imgLink2.isEmpty)
            {
                print("Download url : \(imgLink2)")
            }
        }

    }

struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadImageView()
    }
}
