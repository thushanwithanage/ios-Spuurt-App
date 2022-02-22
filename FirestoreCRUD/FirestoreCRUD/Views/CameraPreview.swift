//
//  CameraPreview.swift
//  FirestoreCRUD
//
//  Created by user211530 on 2/16/22.
//

import Foundation
import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable
{
        
    @ObservedObject var cameraModel: CameraModel
    
    
    func makeUIView(context: Context) -> UIView
    {
        let view = UIView(frame: UIScreen.main.bounds)
        cameraModel.preview = AVCaptureVideoPreviewLayer(session: cameraModel.session)
        cameraModel.preview.frame = view.frame
        
        cameraModel.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(cameraModel.preview)
        
        //view.perform {        cameraModel.session.startRunning() }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context)
    {
        
    }


}
