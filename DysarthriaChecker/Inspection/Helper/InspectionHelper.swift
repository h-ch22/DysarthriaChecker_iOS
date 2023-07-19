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
import PDFKit


class InspectionHelper : NSObject, ObservableObject{
    @Published var scripts: [String] = []
    @Published var speech_examples: [String] = []
    @Published var progress: InspectionProgressModel? = nil
    @Published var elementWidth: CGFloat = 1.0
    @Published var spectrograms = [[Double]]()
    @Published var spectrogram: CGImage?
    
    private let word_path = Bundle.main.path(forResource: "list_word", ofType: "CSV", inDirectory: "include")!
    private let sentence_path = Bundle.main.path(forResource: "list_sentence", ofType: "CSV", inDirectory: "include")!
    private let paragraph_path = Bundle.main.path(forResource: "list_paragraph", ofType: "csv", inDirectory: "include")!
    private let semiFreeSpeech_path = Bundle.main.path(forResource: "list_semi_free_speech", ofType: "csv", inDirectory: "include")!
    
    private lazy var module_T00: TorchModule = {
        if let filePath = Bundle.main.path(forResource: "T00", ofType: "ptl", inDirectory: "include"),
           let module_T00 = TorchModule(fileAtPath: filePath){
            return module_T00
        } else{
            fatalError("Failed to load model : T00")
        }
    }()
    
    private lazy var module_T01: TorchModule = {
        if let filePath = Bundle.main.path(forResource: "T01", ofType: "ptl", inDirectory: "include"),
           let module_T01 = TorchModule(fileAtPath: filePath){
            return module_T01
        } else{
            fatalError("Failed to load model : T01")
        }
    }()
    
    private lazy var module_T02: TorchModule = {
        if let filePath = Bundle.main.path(forResource: "T02", ofType: "ptl", inDirectory: "include"),
           let module_T02 = TorchModule(fileAtPath: filePath){
            return module_T02
        } else{
            fatalError("Failed to load model : T02")
        }
    }()
    
    private lazy var module_T03: TorchModule = {
        if let filePath = Bundle.main.path(forResource: "T03", ofType: "ptl", inDirectory: "include"),
           let module_T03 = TorchModule(fileAtPath: filePath){
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
    
    static func convertDiseaseCodeToKorean(diseaseCode: String, code: String) -> String{
        switch diseaseCode{
        case "T00":
            switch code{
            case "BRAIN":
                return "뇌신경장애"
                
            case "LANGUAGE":
                return "언어청각장애"
                
            case "LARYNX":
                return "후두장애"
                
            default:
                return ""
            }
            
        case "T01":
            switch code{
            case "LANGUAGE":
                return "언어+뇌신경장애"
                
            case "EAR":
                return "청각+뇌신경장애"
                
            default:
                return ""
            }
            
        case "T02":
            switch code{
            case "ARTICULATION":
                return "조음장애"
                
            case "VOCALIZATION":
                return "발성장애"
                
            case "CONDUCTION":
                return "전음성장애"
                
            case "SENSORINEURAL":
                return "감음신경성장애"
                
            default:
                return ""
            }
            
        case "T03":
            switch code{
            case "FUNCTIONAL":
                return "기능성 후두장애"
                
            case "LARYNX":
                return "후두장애"
                
            case "ORAL":
                return "구강장애"
                
            default:
                return ""
            }
            
        default:
            return ""
        }
    }
    
    static func createPDF(patientName: String, id: String, T00 : [PredictResult], T01 : [PredictResult], T02 : [PredictResult], T03 : [PredictResult], spectrogram: UIImage?) -> Data{
        let pdfMetaData = [
            kCGPDFContextCreator : "Dysarthria Checker",
            kCGPDFContextAuthor : "Dysarthria Checker",
            kCGPDFContextTitle : "DysarthriaChecker_\(patientName)_\(id)"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageRect = CGRect(x:10, y:10, width: 595.2, height: 841.8)
        let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = graphicsRenderer.pdfData{(context) in
            context.beginPage()
            let initialCursor: CGFloat = 32
            
            var cursor = context.addCenteredText(fontSize: 24, weight: .bold, text: "구음장애 진단 결과 (\(patientName))", cursor: initialCursor, pdfSize: pageRect.size)
            
            cursor += 24
            
            let leftMargin: CGFloat = 74
            
            cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "검사일 : \(id)", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: nil, annotationColor: .gray)
            cursor += 24
            
            cursor = context.addSingleLineText(fontSize: 16, weight: .bold, text: "통합 검사 결과 (T00)", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: .underline, annotationColor: .black)
            
            for i in 0...2{
                cursor += 6

                cursor = context.addSingleLineText(fontSize: 14, weight: i == 0 ? .bold : .regular, text: "\(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: T00[i].label )) : \(T00[i].score )%", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: nil, annotationColor: i == 0 ? UIColor(.accentColor) : .black)
            }
            
            cursor += 12
            
            cursor = context.addSingleLineText(fontSize: 16, weight: .bold, text: "뇌신경장애 검사 결과 (T01)", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: .underline, annotationColor: .black)
            
            for i in 0...1{
                cursor += 6

                cursor = context.addSingleLineText(fontSize: 14, weight: i == 0 ? .bold : .regular, text: "\(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: T01[i].label )) : \(T01[i].score )%", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: nil, annotationColor: i == 0 ? UIColor(.accentColor) : .black)
            }
            
            cursor += 12
            
            cursor = context.addSingleLineText(fontSize: 16, weight: .bold, text: "언어청각장애 검사 결과 (T02)", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: .underline, annotationColor: .black)
            
            for i in 0...3{
                cursor += 6

                cursor = context.addSingleLineText(fontSize: 14, weight: i == 0 ? .bold : .regular, text: "\(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: T02[i].label )) : \(T02[i].score )%", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: nil, annotationColor: i == 0 ? UIColor(.accentColor) : .black)
            }

            cursor += 12
            
            cursor = context.addSingleLineText(fontSize: 16, weight: .bold, text: "후두장애 검사 결과 (T03)", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: .underline, annotationColor: .black)
            
            for i in 0...2{
                cursor += 6

                cursor = context.addSingleLineText(fontSize: 14, weight: i == 0 ? .bold : .regular, text: "\(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: T03[i].label )) : \(T03[i].score )%", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: nil, annotationColor: i == 0 ? UIColor(.accentColor) : .black)
            }
            
            if spectrogram != nil{
                cursor += 12
                
                cursor = context.addSingleLineText(fontSize: 16, weight: .bold, text: "음성 데이터 렌더링 결과 (Audio Spectrogram)", indent: leftMargin, cursor: cursor, pdfSize: pageRect.size, annotation: .underline, annotationColor: .black)

                cursor += 6
                
                let maxHeight = pageRect.height * 0.2
                let maxWidth = pageRect.width * 0.4

                let aspectWidth = maxWidth / spectrogram!.size.width
                let aspectHeight = maxHeight / spectrogram!.size.height
                let aspectRatio = min(aspectWidth, aspectHeight)

                let scaledWidth = spectrogram!.size.width * aspectRatio
                let scaledHeight = spectrogram!.size.height * aspectRatio

                let imageRect = CGRect(x: 84, y: cursor, width: scaledWidth, height: scaledHeight)
                spectrogram?.draw(in: imageRect)
            }
        }
        
        return data
    }
    
    static func convertDataToPDF(data : Data) -> PDFDocument?{
        let pdf = PDFDocument(data: data)
        
        return pdf
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
    
    private func topK(scores: [NSNumber], labels: [String], count: Int) -> [PredictResult]?{
        let zippedResults = zip(labels.indices, scores)
        let sortedResults = zippedResults.sorted { $0.1.floatValue > $1.1.floatValue }.prefix(count)
        
        let result = sortedResults.map { PredictResult(score: $0.1.floatValue, label: labels[$0.0]) }
        return result
    }

    func predict(completion: @escaping(_ result: [PredictResult]?) -> Void){
        if self.spectrogram == nil{
            completion(nil)
            return
        }
        
        let resizedImage = UIImage(cgImage: self.spectrogram!).resized(to: CGSize(width: 28, height: 28))
        
        guard var tensorBuffer = resizedImage.normalized() else{
            completion(nil)
            return
        }
        
        switch progress {
        case .LOAD_FILE, .EXTRACT_FILE, .T03:
            completion(nil)
            return
            
        case .RENDER_SPECTROGRAM:
            guard let outputs = module_T00.predict(audio: UnsafeMutableRawPointer(&tensorBuffer), outputSize: 3) else{
                completion(nil)
                return
            }
            
            let labels = ["BRAIN", "LANGUAGE", "LARYNX"]
            
            progress = .T00
            
            completion(topK(scores: outputs, labels: labels, count: 3))
            return
            
        case .T00:
            guard let outputs = module_T01.predict(audio: UnsafeMutableRawPointer(&tensorBuffer), outputSize: 2) else{
                completion(nil)
                return
            }
            
            let labels = ["LANGUAGE", "EAR"]
            
            progress = .T01
            
            completion(topK(scores: outputs, labels: labels, count: 2))
            return
            
        case .T01:
            guard let outputs = module_T02.predict(audio: UnsafeMutableRawPointer(&tensorBuffer), outputSize: 4) else{
                completion(nil)
                return
            }
            
            let labels = ["ARTICULATION", "VOCALIZATION", "CONDUCTION", "SENSORINEURAL"]
            
            progress = .T02

            completion(topK(scores: outputs, labels: labels, count: 4))
            return
            
        case .T02:
            guard let outputs = module_T03.predict(audio: UnsafeMutableRawPointer(&tensorBuffer), outputSize: 3) else{
                completion(nil)
                return
            }
            
            let labels = ["FUNCTIONAL", "LARYNX", "ORAL"]
            
            progress = .T03

            completion(topK(scores: outputs, labels: labels, count: 3))
            return
            
        case nil:
            completion(nil)
            return
        }
    }
}
