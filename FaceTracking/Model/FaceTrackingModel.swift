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
    
    // 各視線移動の閾値
    private let threshUp: Float = 0.3
    private let threshDown: Float = 0.4
    private let threshLeft: Float = 0.3
    private let threshRight: Float = 0.3
    
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
        
        if let value = faceAnchor.blendShapes[.eyeLookUpLeft] as? Float {
            if value > threshUp {
                debugLog("up:\(value)")
                delegate?.faceTrackingUp()
                return
            }
        }
        
        if let value = faceAnchor.blendShapes[.eyeLookDownLeft] as? Float {
            if value > threshDown {
                debugLog("down:\(value)")
                delegate?.faceTrackingDown()
                return
            }
        }
        if let value = faceAnchor.blendShapes[.eyeLookInLeft] as? Float {
            if value > threshLeft {
                debugLog("left:\(value)")
                delegate?.faceTrackingLeft()
                return
            }
        }
        
        if let value = faceAnchor.blendShapes[.eyeLookOutLeft] as? Float {
            if value > threshRight {
                debugLog("right:\(value)")
                delegate?.faceTrackingRight()
                return
            }
        }
        
        if let value = faceAnchor.blendShapes[.eyeLookUpRight] as? Float {
            if value > threshUp {
                debugLog("up:\(value)")
                delegate?.faceTrackingUp()
                return
            }
        }
        
        if let value = faceAnchor.blendShapes[.eyeLookDownRight] as? Float {
            if value > threshDown {
                debugLog("down:\(value)")
                delegate?.faceTrackingDown()
                return
            }
        }
        
        if let value = faceAnchor.blendShapes[.eyeLookInRight] as? Float {
            if value > threshLeft {
                debugLog("left:\(value)")
                delegate?.faceTrackingLeft()
                return
            }
        }
        
        if let value = faceAnchor.blendShapes[.eyeLookOutRight] as? Float {
            if value > threshRight {
                debugLog("right:\(value)")
                delegate?.faceTrackingRight()
                return
            }
        }

    }
}
