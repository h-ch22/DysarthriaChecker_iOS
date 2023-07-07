//
//  InspectionHelper.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 2023/07/06.
//

import Foundation
import RosaKit

class InspectionHelper : ObservableObject{
    @Published var scripts: [String] = []
    
    private let word_path = Bundle.main.path(forResource: "list_word", ofType: "csv", inDirectory: "include")!
    private let sentence_path = Bundle.main.path(forResource: "list_sentence", ofType: "csv", inDirectory: "include")!
    
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
    
    func getScripts(inspectionType : InspectionTypeModel, count: Int, completion: @escaping(_ result : Bool?) -> Void){
        scripts.removeAll()
        
        do{
            switch inspectionType{
            case .WORD:
                let data = try Data(contentsOf: URL(fileURLWithPath: word_path))
                let dataEncoded = String(data: data, encoding: .utf8)
                                    
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
                let dataEncoded = String(data: data, encoding: .utf8)
                
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
                break
                
            case .SEMI_FREE_SPEECH:
                break
                
            case .FREE_SPEECH:
                break
            }

        } catch{
            print("Error reading CSV file")
            completion(false)
            return
        }
        
        completion(true)
    }
    
    func refreshScript(type: InspectionTypeModel, index: Int, completion: @escaping(_ result : Bool?) -> Void){
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
                break
                
            case .SEMI_FREE_SPEECH:
                break
                
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
    
    func extractMFCC(completion: @escaping(_ result : Bool?) -> Void){
        var spectrograms = [[Double]]()

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url : URL? = paths[0].appendingPathComponent("recording.wav")
        
        do{
            let audio = url.flatMap{ try? WavFileManager().readWavFile(at: $0)}
            let dataCount = audio?.data.count ?? 0
            let sampleRate = 44100
            let bytesPerSample = audio?.bytesPerSample ?? 0
            
            if bytesPerSample == 0{
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
                
                print(spectrograms)
            }

        } catch{
            print("Error loading Audio File")
            completion(false)
            return
        }
    }
    
    func predict(){
        
    }
}
