//
//  FaceStateModel.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/14.
//

import Foundation
import RealityKit
import ARKit

struct ARModel{
    private(set) var arView : ARView
    
    var isFaceDetected = false
    var index = 0
    var currentScript = 0
    var isCurrentMotionSuccessed = false
    var sessionSuccess = false
    
    let scripts = ["입을 최대한 크게 3초 이상 벌렸다 다물어보세요", "양쪽 입술을 같이 움직여서 아래턱 쪽으로 힘껏 3초 이상 당겨보세요", "입술을 다물고 힘껏 양쪽으로 3초 이상 당겨보세요", "입을 가볍게 미소 짓듯이, 이가 보이는 상태에서 힘껏 귀 쪽으로 당겨보세요",
    "윗입술과 아랫입술을 가볍게 붙이고 최대한 많이 앞으로 3초 이상 내밀어보세요", "입을 가볍게 벌린 상태에서 아랫입술을 아래턱 쪽으로 최대한 3초 이상 당겨보세요", "오-이-와 오-우-를 발음하듯 천천히 여러번 반복해보세요."]
    
    init(){
        arView = ARView(frame: .zero)
        arView.session.run(ARFaceTrackingConfiguration())
    }
    
    
    mutating func updateState(faceAnchor : ARFaceAnchor){
        isFaceDetected = faceAnchor.isTracked

        let blendShapes = faceAnchor.blendShapes
        guard let jawopen = blendShapes[.jawOpen] as? Float,
              let mouthClose = blendShapes[.mouthClose] as? Float,
              let tongueOut = blendShapes[.tongueOut] as? Float,
              let mouthSmileLeft = blendShapes[.mouthSmileLeft] as? Float,
              let mouthSmileRight = blendShapes[.mouthSmileRight] as? Float,
              let mouthFunnel = blendShapes[.mouthFunnel] as? Float,
              let mouthPucker = blendShapes[.mouthPucker] as? Float,
              let mouthFrownLeft = blendShapes[.mouthFrownLeft] as? Float,
              let mouthFrownRight = blendShapes[.mouthFrownRight] as? Float
              
        else{return}
                
        switch currentScript{
        case 0,5 :
            if jawopen >= 0.7{
                isCurrentMotionSuccessed = true
            } else{
                isCurrentMotionSuccessed = false
            }
            
            break

        case 1:
            if mouthFrownLeft >= 0.15 && mouthFrownRight >= 0.15{
                isCurrentMotionSuccessed = true
            } else{
                isCurrentMotionSuccessed = false
            }
            break

        case 2...3:
            if mouthSmileLeft >= 0.5 && mouthSmileRight >= 0.5{
                isCurrentMotionSuccessed = true
            } else{
                isCurrentMotionSuccessed = false
            }
            break

        case 4:
            if mouthFunnel >= 0.5{
                isCurrentMotionSuccessed = true
            } else{
                isCurrentMotionSuccessed = false
            }
            break

        case 6:
            if mouthFunnel >= 0.5 || (mouthSmileLeft >= 0.2 && mouthSmileRight >= 0.2){
                isCurrentMotionSuccessed = true
            } else{
                isCurrentMotionSuccessed = false
            }
            
            break

        default:
            break
        }
    }
}
