//
//  FaceTrackingModel.swift
//  FaceTracking
//
//  Created by 藤治仁 on 2023/02/18.
//

import Foundation
import ARKit

protocol FaceTrackingModelDelegate: AnyObject {
    func faceTrackingUp()
    func faceTrackingDown()
    func faceTrackingLeft()
    func faceTrackingRight()
}

class FaceTrackingModel: NSObject {
    weak var delegate: FaceTrackingModelDelegate?
    let sceneView = ARSCNView()
    private let defaultConfiguration: ARFaceTrackingConfiguration = {
        let configuration = ARFaceTrackingConfiguration()
        return configuration
    }()

    override init() {
        super.init()
        sceneView.delegate = self
    }
    
    func start() {
        sceneView.session.run(defaultConfiguration)
    }
    
    func stop() {
        sceneView.session.pause()
    }
}

extension FaceTrackingModel: ARSCNViewDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        errorLog(error)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        debugLog("")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        debugLog("")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return
        }
        
        if let lookUpLeft = faceAnchor.blendShapes[.eyeLookUpLeft] as? Float {
            if lookUpLeft > 0.3 {
                delegate?.faceTrackingUp()
            }
        }
        if let lookUpRight = faceAnchor.blendShapes[.eyeLookUpRight] as? Float {
            if lookUpRight > 0.3 {
                delegate?.faceTrackingDown()
            }
        }
        if let lookDownLeft = faceAnchor.blendShapes[.eyeLookDownLeft] as? Float {
            if lookDownLeft > 0.3 {
                delegate?.faceTrackingUp()
            }
        }
        if let lookDownRight = faceAnchor.blendShapes[.eyeLookDownRight] as? Float {
            if lookDownRight > 0.3 {
                delegate?.faceTrackingDown()
            }
        }
        
        if let lookUpLeft = faceAnchor.blendShapes[.eyeLookInLeft] as? Float {
            if lookUpLeft > 0.3 {
                delegate?.faceTrackingLeft()
            }
        }
        if let lookUpRight = faceAnchor.blendShapes[.eyeLookInRight] as? Float {
            if lookUpRight > 0.3 {
                delegate?.faceTrackingLeft()
            }
        }
        if let lookDownLeft = faceAnchor.blendShapes[.eyeLookOutLeft] as? Float {
            if lookDownLeft > 0.3 {
                delegate?.faceTrackingRight()
            }
        }
        if let lookDownRight = faceAnchor.blendShapes[.eyeLookOutRight] as? Float {
            if lookDownRight > 0.3 {
                delegate?.faceTrackingRight()
            }
        }

    }
}
