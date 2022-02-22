//
//  DeedView.swift
//  FirestoreCRUD
//
//  Created by user211530 on 2/16/22.
//

import SwiftUI


struct DeedView: View {
    
    @Environment(\.presentationMode) private var presentationMode2
    var imgUrl: String
    
    var body: some View {
        
        Button("Dismiss Me")
                {
                    self.presentationMode2.wrappedValue.dismiss()
                }
        
        Image(systemName: "placeholder image")
            .data2(url: URL(string: self.imgUrl)!).aspectRatio(contentMode: .fit).frame(width: 250 )
        
        Text("Hello world")
        
        
    }
}

extension Image
{
    func data2(url:URL) -> Self
    {
        if let data = try? Data(contentsOf: url)
        {
            return Image(uiImage: UIImage(data: data)!).resizable()
            
        }
        return self.resizable()
    }
}

struct DeedView_Previews: PreviewProvider {
    static var previews: some View {
        DeedView(imgUrl: "")
    }
}
