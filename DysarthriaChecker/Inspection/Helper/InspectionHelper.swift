//
//  InspectionHelper.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 2023/07/06.
//

import Metal
import MetalKit
import RosaKit
import Accelerate
import UIKit


class InspectionHelper : NSObject, ObservableObject{
    @Published var scripts: [String] = []
    @Published var speech_examples: [String] = []
    @Published var progress: InspectionProgressModel? = nil
    @Published var elementWidth: CGFloat = 20.0
    @Published var spectrograms = [[Double]]()
    
    private let word_path = Bundle.main.path(forResource: "list_word", ofType: "CSV", inDirectory: "include")!
    private let sentence_path = Bundle.main.path(forResource: "list_sentence", ofType: "CSV", inDirectory: "include")!
    private let paragraph_path = Bundle.main.path(forResource: "list_paragraph", ofType: "csv", inDirectory: "include")!
    private let semiFreeSpeech_path = Bundle.main.path(forResource: "list_semi_free_speech", ofType: "csv", inDirectory: "include")!
    
    private lazy var module_T00: AudioTorchModule = {
        if let filePath = Bundle.main.path(forResource: "T00_mobile", ofType: "pt", inDirectory: "include"),
           let module = AudioTorchModule(fileAtPath: filePath){
            return module_T00
        } else{
            fatalError("Failed to load model : T00")
        }
    }()
    
    private lazy var module_T01: AudioTorchModule = {
        if let filePath = Bundle.main.path(forResource: "T01_mobile", ofType: "pt", inDirectory: "include"),
           let module = AudioTorchModule(fileAtPath: filePath){
            return module_T01
        } else{
            fatalError("Failed to load model : T01")
        }
    }()
    
    private lazy var module_T02: AudioTorchModule = {
        if let filePath = Bundle.main.path(forResource: "T02_mobile", ofType: "pt", inDirectory: "include"),
           let module = AudioTorchModule(fileAtPath: filePath){
            return module_T02
        } else{
            fatalError("Failed to load model : T02")
        }
    }()
    
    private lazy var module_T03: AudioTorchModule = {
        if let filePath = Bundle.main.path(forResource: "T03_mobile", ofType: "pt", inDirectory: "include"),
           let module = AudioTorchModule(fileAtPath: filePath){
            return module_T03
        } else{
            fatalError("Failed to load model : T03")
        }
    }()
    
    private var usedIndexes : [Int] = []
    
    private func getRandomIndex(max: Int) -> Int{
        let num = Int.random(in: 0...max-1)
        
        if !usedIndexes.contains(num){
            usedIndexes.append(num)
        } else{
            _ = getRandomIndex(max: max)
        }
        
        return num
    }
    
    @MainActor func getScripts(inspectionType : InspectionTypeModel, count: Int, completion: @escaping(_ result : Bool?) -> Void){
        scripts.removeAll()
        
        do{
            switch inspectionType{
            case .WORD:
                let data = try Data(contentsOf: URL(fileURLWithPath: word_path))
                var dataEncoded = String(data: data, encoding: .utf8)
                dataEncoded = dataEncoded?.replacingOccurrences(of: "\r", with: "")
                
                if let dataArr = dataEncoded?.components(separatedBy: "\n"){
                    for _ in 0 ..< count{
                        let index = getRandomIndex(max: dataArr.count)
                        
                        scripts.append(dataArr[index])
                    }
                    
                } else{
                    completion(false)
                    return
                }
                
            case .SENTENCE:
                let data = try Data(contentsOf: URL(fileURLWithPath: sentence_path))
                var dataEncoded = String(data: data, encoding: .utf8)
                dataEncoded = dataEncoded?.replacingOccurrences(of: "\r", with: "")
                
                if let dataArr = dataEncoded?.components(separatedBy: "\n"){
                    for _ in 0 ..< count{
                        let index = getRandomIndex(max: dataArr.count)
                        
                        scripts.append(dataArr[index])
                    }
                    
                } else{
                    completion(false)
                    return
                }
                
            case .PARAGRAPH:
                let data = try Data(contentsOf: URL(fileURLWithPath: paragraph_path))
                var dataEncoded = String(data: data, encoding: .utf8)
                dataEncoded = dataEncoded?.replacingOccurrences(of: "\r", with: "")
                
                if let dataArr = dataEncoded?.components(separatedBy: "\n"){
                    for var i in 0 ..< count{
                        let index = getRandomIndex(max: dataArr.count)
                        
                        if dataArr[index].trimmingCharacters(in: .whitespaces).count < 10{
                            i-=1
                        } else{
                            scripts.append(dataArr[index])
                        }
                    }
                    
                } else{
                    completion(false)
                    return
                }
                
            case .SEMI_FREE_SPEECH:
                let data = try Data(contentsOf: URL(fileURLWithPath: semiFreeSpeech_path))
                var dataEncoded = String(data: data, encoding: .utf8)
                dataEncoded = dataEncoded?.replacingOccurrences(of: "\r", with: "")
                
                if let dataArr = dataEncoded?.components(separatedBy: "\n"){
                    for index in 0 ..< dataArr.count{
                        if dataArr[index] != ""{
                            let script = dataArr[index].split(separator: ",")
                            
                            scripts.append(String(script[0]))
                            speech_examples.append(String(script[1]))
                        }
                    }
                    
                } else{
                    completion(false)
                    return
                }
                
            case .FREE_SPEECH:
                completion(false)
                return
            }
            
        } catch{
            print("Error reading CSV file")
            completion(false)
            return
        }
        
        completion(true)
    }
    
    @MainActor func refreshScript(type: InspectionTypeModel, index: Int, completion: @escaping(_ result : Bool?) -> Void){
        do{
            switch type{
            case .WORD:
                let data = try Data(contentsOf: URL(fileURLWithPath: word_path))
                let dataEncoded = String(data: data, encoding: .utf8)
                
                if let dataArr = dataEncoded?.components(separatedBy: "\n"){
                    let i = getRandomIndex(max: dataArr.count)
                    
                    scripts[index] = dataArr[i]
                }
                
            case .SENTENCE:
                let data = try Data(contentsOf: URL(fileURLWithPath: sentence_path))
                let dataEncoded = String(data: data, encoding: .utf8)
                
                if let dataArr = dataEncoded?.components(separatedBy: "\n"){
                    let i = getRandomIndex(max: dataArr.count)
                    
                    scripts[index] = dataArr[i]
                }
                
            case .PARAGRAPH:
                let data = try Data(contentsOf: URL(fileURLWithPath: paragraph_path))
                let dataEncoded = String(data: data, encoding: .utf8)
                
                if let dataArr = dataEncoded?.components(separatedBy: "\n"){
                    let i = getRandomIndex(max: dataArr.count)
                    
                    if dataArr[index].trimmingCharacters(in: .whitespaces).count > 10{
                        scripts[index] = dataArr[i]
                    } else{
                        refreshScript(type: type, index: index){ _ in
                        }
                    }
                }
                
            case .SEMI_FREE_SPEECH:
                let data = try Data(contentsOf: URL(fileURLWithPath: semiFreeSpeech_path))
                let dataEncoded = String(data: data, encoding: .utf8)
                
                if let dataArr = dataEncoded?.components(separatedBy: "\n"){
                    let index = getRandomIndex(max: dataArr.count)
                    let script = dataArr[index].split(separator: ",")
                    
                    scripts[index] = String(script[0])
                    speech_examples[index] = String(script[1])
                    
                } else{
                    completion(false)
                    return
                }
                
            case .FREE_SPEECH:
                break
            }
            
            completion(true)
            
        } catch{
            print("Error reading CSV file")
            completion(false)
            return
        }
    }
    
    func extractMelSpectrogram(filePath: URL? = nil, completion: @escaping(_ result : Bool?) -> Void){
        do{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            if filePath != nil{
                filePath!.startAccessingSecurityScopedResource()
            }

            let url : URL? = filePath == nil ? paths[0].appendingPathComponent("recording.wav") : filePath
            
            let audio = try url.flatMap{ try WavFileManager().readWavFile(at: $0) }
            progress = .LOAD_FILE
            
            let dataCount = audio?.data.count ?? 0
            let sampleRate = 44100
            let bytesPerSample = audio?.bytesPerSample ?? 0
            
            if bytesPerSample == 0{
                print("Inspection terminated because bytes per sample is 0 (DivideByZeroException)")
                completion(false)
                return
            } else{
                let chunkSize = 66000
                let chunksCount = dataCount / (chunkSize * bytesPerSample) - 1
                let rawData = audio?.data.int16Array
                
                for index in 0..<chunksCount - 1{
                    let samples = Array(rawData?[chunkSize * index ..< chunkSize * (index+1)] ?? []).map{Double($0)/32768.0}
                    let powerSpectrogram = samples.melspectrogram(nFFT: 320, hopLength: 160, sampleRate: sampleRate, melsCount: 64).map { $0.normalizeAudioPower() }
                    spectrograms.append(contentsOf: powerSpectrogram.transposed)
                }
                
                progress = .EXTRACT_FILE
                completion(true)
                return
            }
        } catch{
            print(error.localizedDescription)
            completion(false)
            return
        }
        
    }
    
    func changeProgress(progress: InspectionProgressModel){
        self.progress = progress
    }

    
    func predict(){
        progress = .RENDER_SPECTROGRAM
    }
}
