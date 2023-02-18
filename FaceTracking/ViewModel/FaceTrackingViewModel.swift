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
    @Published var message: String?
    private let model = FaceTrackingModel()
    private let moveValue: CGFloat = 100.0
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.message = nil
        }
    }
}

extension FaceTrackingViewModel: FaceTrackingModelDelegate {
    func faceTrackingUp() {
        debugLog("")
        DispatchQueue.main.async {
            self.setMessage("Up")
            if self.pointerLocation.y > self.moveValue {
                self.pointerLocation.y -= self.moveValue
            }
        }
    }
    func faceTrackingDown() {
        debugLog("")
        DispatchQueue.main.async {
            self.setMessage("Down")
            if self.pointerLocation.y + self.moveValue < self.screenSize.height {
                self.pointerLocation.y += self.moveValue
            }
        }
    }
    func faceTrackingLeft() {
        debugLog("")
        DispatchQueue.main.async {
            self.setMessage("Left")
            if self.pointerLocation.x > self.moveValue {
                self.pointerLocation.x -= self.moveValue
            }
        }
    }
    func faceTrackingRight() {
        debugLog("")
        DispatchQueue.main.async {
            self.setMessage("Right")
            if self.pointerLocation.x + self.moveValue < self.screenSize.width {
                self.pointerLocation.x += self.moveValue
            }
        }
    }
}
