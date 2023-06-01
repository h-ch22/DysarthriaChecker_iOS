//
//  ARFaceTrackerView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import Foundation
import UIKit
import ARKit
import SwiftUI

class ARFaceTrackerView : UIViewController, ARSCNViewDelegate, ARSessionDelegate{
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var countDownTimer: UILabel!
    @IBOutlet weak var trainCount: UILabel!
    @IBOutlet weak var ic_faceDetected: UIImageView!
    
    var countDown = 3
    var index = 0
    var currentScript = 0
    var isFaceDetected = false
    
    let scripts = ["입을 최대한 크게 3초 이상 벌렸다 다물어보세요", "양쪽 입술을 같이 움직여서 아래턱 쪽으로 힘껏 3초 이상 당겨보세요", "입술을 다물고 힘껏 양쪽으로 3초 이상 당겨보세요", "입을 가볍게 미소 짓듯이, 이가 보이는 상태에서 힘껏 귀 쪽으로 당겨보세요",
    "윗입술과 아랫입술을 가볍게 붙이고 최대한 많이 앞으로 3초 이상 내밀어보세요", "입을 가볍게 벌린 상태에서 아랫입술을 아래턱 쪽으로 최대한 3초 이상 당겨보세요", "오-이-와 오-우-를 발음하듯 천천히 여러번 반복해보세요."]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let config = ARFaceTrackingConfiguration()
        sceneView.session.run(config)
    }
    
    @IBSegueAction func showSwiftUI(_ coder: NSCoder) -> UIViewController? {
        let controller = UIHostingController(coder : coder, rootView: TrainLabelView(script : scripts[currentScript]))
        controller!.view.backgroundColor = .clear
                
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.automaticallyUpdatesLighting = true
        
        ic_faceDetected.image = UIImage(systemName: isFaceDetected ? "face.smiling" : "face.dashed")
        trainCount.text = isFaceDetected ? "Face Detected" : "Face Not Detected"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = sceneView.device else{
            return nil
        }

        let faceGeometry = ARSCNFaceGeometry(device: device)
        let faceNode = SCNNode(geometry: faceGeometry)
        faceNode.geometry?.firstMaterial?.fillMode = .lines

        return faceNode
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry else{
            return
        }
        
        faceGeometry.update(from: faceAnchor.geometry)
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        if let faceAnchor = anchors.first as? ARFaceAnchor{
            isFaceDetected = faceAnchor.isTracked
            
            
            let blendShapes = faceAnchor.blendShapes
            guard let jawopen = blendShapes[.jawOpen] as? Float,
                  let mouthClose = blendShapes[.mouthClose] as? Float,
                  let tongueOut = blendShapes[.tongueOut] as? Float,
                  let mouthSmileLeft = blendShapes[.mouthSmileLeft] as? Float,
                  let mouthSmileRight = blendShapes[.mouthSmileRight] as? Float,
                  let mouthFunnel = blendShapes[.mouthFunnel] as? Float,
                  let mouthPucker = blendShapes[.mouthPucker] as? Float
                  
            else{return}
                    
            switch currentScript{
            case 0:
                if jawopen >= 0.7{
                    
                } else{
                    
                }
                
                break

            case 1:
                break

            case 2:
                break

            case 3:
                break

            case 4:
                break

            case 5:
                break

            case 6:
                break

            default:
                break
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceGeometry = node.geometry as? ARSCNFaceGeometry,
              let faceAnchor = anchor as? ARFaceAnchor
        else { return }
        

    }
}
