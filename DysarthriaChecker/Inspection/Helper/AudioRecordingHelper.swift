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
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsBigEndianKey: false,
            AVLinearPCMIsNonInterleaved: true,
            AVLinearPCMIsFloatKey: false
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
        
        do{
            let data = try Data(contentsOf: url)
            let headerData = createFileHeader(data: data)
            let wavFileData = headerData + data
            
            try wavFileData.write(to: url)
            
            completion(true)
            return
        } catch{
            print(error.localizedDescription)
            completion(false)
            return
        }
    }
    
    private func createFileHeader(data: Data) -> NSData{
        let sampleRate: Int32 = 44100
        let chunkSize: Int32 = 36 + Int32(data.count)
        let subChunkSize:Int32 = 16
        let format:Int16 = 1
        let channels:Int16 = 1
        let bitsPerSample:Int16 = 16
        let byteRate:Int32 = sampleRate * Int32(channels * bitsPerSample / 8)
        let blockAlign: Int16 = channels * bitsPerSample / 8
        let dataSize:Int32 = Int32(data.count)
        
        let header = NSMutableData()
        
        header.append([UInt8]("RIFF".utf8), length: 4)
        header.append(intToByteArray(chunkSize), length: 4)
        
        header.append([UInt8]("WAVE".utf8), length: 4)
        
        header.append([UInt8]("fmt ".utf8), length: 4)
        
        header.append(intToByteArray(subChunkSize), length: 4)
        header.append(shortToByteArray(format), length: 2)
        header.append(shortToByteArray(channels), length: 2)
        header.append(intToByteArray(sampleRate), length: 4)
        header.append(intToByteArray(byteRate), length: 4)
        header.append(shortToByteArray(blockAlign), length: 2)
        header.append(shortToByteArray(bitsPerSample), length: 2)
        
        header.append([UInt8]("data".utf8), length: 4)
        header.append(intToByteArray(dataSize), length: 4)
        
        return header
    }
    
    private func intToByteArray(_ i: Int32) -> [UInt8] {
        return [
            UInt8(truncatingIfNeeded: (i      ) & 0xff),
            UInt8(truncatingIfNeeded: (i >>  8) & 0xff),
            UInt8(truncatingIfNeeded: (i >> 16) & 0xff),
            UInt8(truncatingIfNeeded: (i >> 24) & 0xff)
        ]
    }
    
    private func shortToByteArray(_ i: Int16) -> [UInt8] {
        return [
            UInt8(truncatingIfNeeded: (i      ) & 0xff),
            UInt8(truncatingIfNeeded: (i >>  8) & 0xff)
        ]
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
