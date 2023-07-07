//
//  AudioRecordingHelper.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 2023/07/06.
//

import Foundation
import AVFoundation

class AudioRecordingHelper : NSObject, ObservableObject, AVAudioRecorderDelegate{
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?
    
    private var currentSample: Int
    private let numberOfSamples: Int
        
    @Published var soundSamples: [Float]
    
    init(numberOfSamples: Int){
        self.numberOfSamples = numberOfSamples
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0
        super.init()

        startMonitoring()
    }
    
    func startMonitoring() {
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("You must allow audio recording for predict to work")
                }
            }
        }
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent("recording.wav")
        
        let recorderSettings : [String : Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
            audioRecorder?.delegate = self
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            try audioSession.setActive(true)
            
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
                self.audioRecorder?.updateMeters()
                self.soundSamples[self.currentSample] = self.audioRecorder?.averagePower(forChannel: 0) ?? 0.0
                self.currentSample = (self.currentSample + 1) % self.numberOfSamples
            })
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func finishRecording(completion: @escaping(_ result: Bool?) -> Void) {
        audioRecorder?.stop()
        timer = nil
        audioRecorder = nil
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent("recording.wav")
        let playSession = AVAudioSession.sharedInstance()

        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
            completion(true)
            return
        } catch{
            print("Failed to play file")
            completion(false)
            return
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        finishRecording(){ _ in
        }
    }
    
    deinit {
        timer?.invalidate()
        audioRecorder?.stop()
    }
}
