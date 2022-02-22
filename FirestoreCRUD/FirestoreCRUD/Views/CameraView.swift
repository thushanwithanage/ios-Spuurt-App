//
//  CameraView.swift
//  FirestoreCRUD
//
//  Created by user211530 on 2/16/22.
//

import SwiftUI
import Foundation
import AVFoundation

struct CameraView: View
{
    @StateObject var camera = CameraModel()
    var body: some View
    {
        ZStack
        {
            CameraPreview(cameraModel: camera).ignoresSafeArea(.all, edges: .all)
            
            VStack
            {
            
                if camera.isTaken
                {
                    HStack
                    {
                        Spacer()
                        Button(action: camera.reTake, label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                        })
                        .padding(.trailing, 10)
                    }
                    
                }
                
                Spacer()
                
                HStack
                {
                    if camera.isTaken
                    {
                        Button(action: { if !camera.isSaved{/*camera.savePic*/} }, label: {
                            Text("Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        
                        Spacer()
                    }
                    else
                    {
                        Button(action: camera.takePic, label: {
                        
                            ZStack{
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                }.frame(height: 75)
            }
        }
        .onAppear(perform: {
            camera.Check()
        })
    }
}
                                
                                class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate
                                {
                                    @Published var isTaken = false
                                    @Published var session = AVCaptureSession()
                                    @Published var alert = false
                                    @Published var output = AVCapturePhotoOutput()
                                    @Published var isSaved = false
                                    @Published var picData = Data(count: 0)
                                    
                                    @Published var preview: AVCaptureVideoPreviewLayer!
                                    func Check()
                                    {
                                        switch AVCaptureDevice.authorizationStatus(for: .video)
                                        {
                                            case .notDetermined:
                                                AVCaptureDevice.requestAccess(for: .video)
                                                { (status) in
                                                    if status
                                                    {
                                                        self.setUp()
                                                    }
                                                }
                                            case .restricted:
                                                return
                                            case .denied:
                                                self.alert.toggle()
                                            case .authorized:
                                                self.setUp()
                                                return
                                            @unknown default:
                                                return
                                        }
                                    }
                                    
                                    func setUp()
                                    {
                                        do
                                        {
                                            self.session.beginConfiguration()
                                            
                                            let device = AVCaptureDevice.default(.builtInDualCamera,
                                                for: .video, position: .back)
                                            
                                            let input = try AVCaptureDeviceInput(device: device!)
                                            
                                            if self.session.canAddInput(input){
                                                self.session.addInput(input)
                                            }
                                            
                                            if self.session.canAddOutput(self.output){
                                                self.session.addOutput(self.output)
                                            }
                                            
                                            self.session.commitConfiguration()
                                            
                                        }
                                        catch
                                        {
                                            print(error.localizedDescription)
                                        }
                                    }
                                    
                                    func takePic()
                                    {
                                        DispatchQueue.global(qos: .background).async
                                        {
                                            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
                                            self.session.stopRunning()
                                            
                                            DispatchQueue.main.async
                                            {
                                                withAnimation{self.isTaken.toggle()}
                                            }
                                        }
                                    }
                                    
                                    func reTake()
                                    {
                                        DispatchQueue.global(qos: .background).async
                                        {
                                            self.session.startRunning()
                                            
                                            DispatchQueue.main.async
                                            {
                                                withAnimation{self.isTaken.toggle()}
                                                self.isSaved = false
                                            }
                                        }
                                    }
                                    
                                    func savePic()
                                    {
                                        let image = UIImage(data: self.picData)!
                                        
                                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                                        
                                        self.isSaved = true
                                    }
                                    
                                    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?)
                                    {
                                        if error != nil
                                        {
                                            return
                                        }
                                        
                                        guard let imageData = photo.fileDataRepresentation() else {return}
                                        
                                        self.picData = imageData
                                    }
                                }

                                // Image Preview

                                /*import Foundation
                                import SwiftUI
                                import AVFoundation*/

                                /*struct CameraPreview: UIViewRepresentable
                                {
                                    @ObservableObject var cameraModel: CameraModel
                                    
                                    
                                    func makeUIView(context: Context) -> UIView
                                    {
                                        let view = UIView(frame: UIScreen.main.bounds)
                                        cameraModel.preview = AVCaptureVideoPreviewLayer(session: cameraModel.session)
                                        cameraModel.preview.frame = view.frame
                                        
                                        cameraModel.videoGravity = .resizeAspectFill
                                        view.layer.addSubLayer(cameraModel.preview)
                                        
                                        cameraModel.session.startRunning()
                                        
                                        return view
                                    }
                                    
                                    func updateUIView(_ uiView: UIView, context: Context) -> UIView
                                    {
                                        
                                    }
                                }*/
                                

                                
struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
