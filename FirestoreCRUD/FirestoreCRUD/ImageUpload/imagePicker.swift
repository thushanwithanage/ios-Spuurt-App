//
//  imagePicker.swift
//  FirestoreCRUD
//
//  Created by user211530 on 2/12/22.
//

import SwiftUI
import FirebaseStorage
import Combine

struct imagePicker: UIViewControllerRepresentable {
    
    @Binding var shown: Bool
    @Binding var imageURL:String
    @Binding var imgLink2: String
   
    func makeCoordinator() -> imagePicker.Coordinator {
        return imagePicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var parent: imagePicker
        let storage = Storage.storage().reference()
        init(parent: imagePicker) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.shown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            uploadImageToFireBase(image: image)
        }
        
        func uploadImageToFireBase(image: UIImage) {
            // Create the file metadata
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let ref = storage.child(FILE_NAME)
            // Upload the file to the path FILE_NAME
            storage.child(FILE_NAME).putData(image.jpegData(compressionQuality: 0.42)!, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                  // Uh-oh, an error occurred!
                  print((error?.localizedDescription)!)
                  return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                
                print("Upload size is \(size)")
                print("Upload success")
                self.parent.shown.toggle()
                // self.downloadImageFromFirebase()
                
                
                ref.downloadURL
                { (url, error) in
                    guard let downloadURL = url else {
                      // Uh-oh, an error occurred!
                      return
                    }
                    self.parent.imgLink2 = downloadURL.absoluteString
                    
                    print(downloadURL.absoluteString)
                  }
                
            }
            }
        

    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> UIImagePickerController {
        let imagepic = UIImagePickerController()
        imagepic.sourceType = .photoLibrary
        imagepic.delegate = context.coordinator
        return imagepic
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
    }
}

