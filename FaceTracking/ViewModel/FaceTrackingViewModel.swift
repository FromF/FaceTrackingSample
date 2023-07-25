//
//  FaceTrackingViewModel.swift
//  FaceTracking
//
//  Created by 藤治仁 on 2023/02/18.
//

import SwiftUI
import ARKit

class FaceTrackingViewModel: NSObject, ObservableObject {
    @Published var sceneView: ARSCNView?
    @Published var screenSize = CGSize.zero
    @Published var pointerLocation: CGPoint = CGPoint.zero
    var centerLocation: CGPoint = CGPoint.zero
    @Published var message: String?
    private let model = FaceTrackingModel()
    private let moveValue: CGFloat = 10.0
    
    func onAppear() {
        model.delegate = self
        sceneView = model.sceneView
        model.start()
    }
    
    func onDisappear() {
        model.stop()
        model.delegate = nil
    }
    
    func setMessage(_ text: String) {
        message = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.message = nil
        }
    }
}

extension FaceTrackingViewModel: FaceTrackingModelDelegate {
    func eyeTracingDebug(x: Int, y: Int, distance: Int) {
        debugLog("\(x),\(y) \(distance)")
    }
    
    func eyeTracingScreen(x: CGFloat, y: CGFloat) {
        debugLog("\(x),\(y)")
        DispatchQueue.main.async {
            self.pointerLocation.x = self.centerLocation.x + x
            self.pointerLocation.y = self.centerLocation.y + y
        }
    }
}
