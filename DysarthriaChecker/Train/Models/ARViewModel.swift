//
//  ARViewModel.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/14.
//

import Foundation
import RealityKit
import ARKit

class ARViewModel : UIViewController, ObservableObject, ARSessionDelegate{
    @Published private var model : ARModel = ARModel()
    private var type: TrainTypeModel = .LIP
    
    var arView : ARView{
        model.arView
    }
    
    var isFaceDetected : Bool{
        return model.isFaceDetected
    }
    
    var currentScript : String{
        return model.scripts[model.currentScript]
    }
    
    var index : Int{
        return model.index
    }
    
    var scriptCount : Int{
        return model.scripts.count
    }
    
    var sessionClear : Bool{
        return model.sessionSuccess
    }
    
    
    var timer : Timer?
    var count = 3
    
    var sessionSuccess = false
    
    var remainingTime : String{
        return String(count)
    }
    
    func changeType(type: TrainTypeModel){
        self.type = type
    }
    
    func startTimer(){
        if timer != nil && timer!.isValid{
            timer!.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        count = 3
        timer?.invalidate()
    }
    
    @objc func timerCallback(){
        if model.isCurrentMotionSuccessed{
            count -= 1
            
            if count < 0{
                stopTimer()
                model.currentScript += 1
            }
            
            if model.currentScript > 6{
                stopTimer()
                model.sessionSuccess = true
            }
        }
    }
    
    func startSessionDelegate(){
        model.arView.session.delegate = self
    }
    
    func stopSessionDelegate(){
        model.currentScript = 0
        model.index = 0
        model.sessionSuccess = false
        model.isCurrentMotionSuccessed = false
        count = 3
        model.arView.session.delegate = nil
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        if let faceAnchor = anchors.first as? ARFaceAnchor{
            model.updateState(faceAnchor : faceAnchor)
        }
        
        if model.isCurrentMotionSuccessed && (timer == nil || !timer!.isValid) {
            startTimer()
        } else if !model.isCurrentMotionSuccessed{
            stopTimer()
        }
    }
}
