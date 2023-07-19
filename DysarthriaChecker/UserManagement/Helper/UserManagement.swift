//
//  UserManagement.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/04/27.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class UserManagement : ObservableObject{
    @Published var userInfo : UserInfoModel? = nil
    @Published var latestInspectionResult : InspectionResultModel? = nil
    @Published var inspectionResults : [InspectionResultModel] = []
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    func signIn(email : String, password : String, completion : @escaping(_ result : Bool?) -> Void){
        auth.signIn(withEmail: email, password: password){_, error in
            if error != nil{
                print(error)
                completion(false)
                return
            }
            
            self.getUserInfo(){result in
                guard let result = result else{return}
                
                if result{
                    UserDefaults.standard.set(AES256Util.encrypt(string: email), forKey: "auth_email")
                    UserDefaults.standard.set(AES256Util.encrypt(string: password), forKey: "auth_password")
                    
                    completion(true)
                    return
                }

            }
            
        }
    }
    
    func signUp(email : String, password : String, name : String, phone : String, completion : @escaping(_ result : Bool?) -> Void){
        auth.createUser(withEmail: email, password: password){_, error in
            if error != nil{
                print(error)
                completion(false)
                
                return
            }
            
            self.db.collection("Users").document(self.auth.currentUser?.uid ?? "").setData([
                "name" : AES256Util.encrypt(string: name),
                "phone" : AES256Util.encrypt(string: phone),
                "email" : AES256Util.encrypt(string: email)
            ]){error in
                if error != nil{
                    print(error)
                    
                    self.auth.currentUser?.delete()
                    completion(false)
                    return
                }
            }
            
            UserDefaults.standard.set(AES256Util.encrypt(string: email), forKey: "auth_email")
            UserDefaults.standard.set(AES256Util.encrypt(string: password), forKey: "auth_password")
            
            self.getUserInfo(){result in
                completion(true)
                return
            }

        }
    }
    
    func updateDisabledData(
        strokeDisabledLevel : Int,
        degenerativeBrainDiseaseLevel : Int,
        peripheralNeuropathyLevel : Int,
        otherBrainDiseaseLevel : Int,
        funtionalLanguageLevel : Int,
        larynxLevel : Int,
        oralLevel : Int,
        otherLanguageDiseaseLevel : Int,
        completion : @escaping(_ result : Bool?) -> Void
    ){
        self.db.collection("Users").document(auth.currentUser?.uid ?? "").collection("DiseaseInfo").document("BasicDiseaseInfo").setData([
            "stroke" : strokeDisabledLevel,
            "degenerativeBrain" : degenerativeBrainDiseaseLevel,
            "peripheralNeuropathy" : peripheralNeuropathyLevel,
            "otherBrainDisease" : otherBrainDiseaseLevel,
            "functionalLanguage" : funtionalLanguageLevel,
            "larynx" : larynxLevel,
            "oral" : oralLevel,
            "otherLanguageDisease" : otherLanguageDiseaseLevel
        ]){error in
            if error != nil{
                print(error)
                completion(false)
                return
            } else{
                completion(true)
                return
            }
        }
    }
    
    func getDisabledData(completion : @escaping(_ result : DiseaseInfoModel?) -> Void){
        self.db.collection("Users").document(auth.currentUser?.uid ?? "").collection("DiseaseInfo").document("BasicDiseaseInfo").getDocument(){document, error in
            if error != nil{
                completion(nil)
                return
            } else{
                let stroke = document?.get("stroke") as? Int ?? nil
                let degenerativeBrain = document?.get("degenerativeBrain") as? Int ?? nil
                let peripheralNeuropathy = document?.get("peripheralNeuropathy") as? Int ?? nil
                let otherBrainDisease = document?.get("otherBrainDisease") as? Int ?? nil
                let functionalLanguage = document?.get("functionalLanguage") as? Int ?? nil
                let larynx = document?.get("larynx") as? Int ?? nil
                let oral = document?.get("oral") as? Int ?? nil
                let otherLanguageDisease = document?.get("otherLanguageDisease") as? Int ?? nil
                
                completion(DiseaseInfoModel(
                    strokeDisabledLevel: stroke,
                    degenerativeBrainDiseaseLevel: degenerativeBrain,
                    peripheralNeuropathyLevel: peripheralNeuropathy,
                    otherBrainDiseaseLevel: otherBrainDisease,
                    functionalLangauageLevel: functionalLanguage,
                    larynxLevel: larynx,
                    oralLevel: oral,
                    otherLanguageDiseaseLevel: otherLanguageDisease
                ))
            }
        }
    }
    
    func signOut(completion : @escaping(_ result : Bool?) -> Void){
        try? self.auth.signOut()
        completion(true)
    }
    
    func calculateAge(selection : Date) -> Bool{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: selection, to: Date())
        
        if components.year! < 19{
            return false
        } else{
            return true
        }
    }
    
    func getUserInfo(completion : @escaping(_ result : Bool?) -> Void){
        self.db.collection("Users").document(auth.currentUser?.uid ?? "").getDocument(){(document, error) in
            if error != nil{
                print(error)
                completion(false)
                
                return
            }
            
            self.userInfo = UserInfoModel(uid : self.auth.currentUser?.uid ?? "", name : AES256Util.decrypt(encoded: document?.get("name") as? String ?? ""), phone : AES256Util.decrypt(encoded: document?.get("phone") as? String ?? ""), email: AES256Util.decrypt(encoded: document?.get("email") as? String ?? ""))
            completion(true)
            return
        }
    }
    
    func uploadInspectionResult(T00: [PredictResult], T01: [PredictResult], T02: [PredictResult], T03: [PredictResult], spectrogram: UIImage, completion: @escaping(_ result: Bool?) -> Void){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd. kk:mm:ss"
        
        let docID = formatter.string(from: Date())
        
        self.db.collection("Users").document(auth.currentUser?.uid ?? "").collection("Inspection").document(docID).setData([
            "T00_\(T00[0].label)" : T00[0].score,
            "T00_\(T00[1].label)" : T00[1].score,
            "T00_\(T00[2].label)" : T00[2].score,
            "T01_\(T01[0].label)" : T01[0].score,
            "T01_\(T01[1].label)" : T01[1].score,
            "T02_\(T02[0].label)" : T02[0].score,
            "T02_\(T02[1].label)" : T02[1].score,
            "T02_\(T02[2].label)" : T02[2].score,
            "T02_\(T02[3].label)" : T02[3].score,
            "T03_\(T03[0].label)" : T03[0].score,
            "T03_\(T03[1].label)" : T03[1].score,
            "T03_\(T03[2].label)" : T03[2].score
        ]){ error in
            if error != nil{
                print(error?.localizedDescription)
                completion(false)
                return
            } else{
                let storageRef = self.storage.reference()
                let imgRef = storageRef.child("spectrograms/\(self.auth.currentUser?.uid ?? "")/\(docID)/spectrogram.png")
                guard let imgData = spectrogram.pngData() else {
                    completion(false)
                    return
                }
                
                imgRef.putData(imgData, metadata: nil){metaData, error in
                    if error != nil{
                        print(error?.localizedDescription)
                        completion(false)
                        return
                    } else{
                        completion(true)
                        return
                    }
                }

            }
        }
    }
    
    func getLatestInspectionResults(completion : @escaping(_ result: Bool?) -> Void){
        let collectionRef = self.db.collection("Users").document(auth.currentUser?.uid ?? "").collection("Inspection")
        collectionRef.getDocuments(){(querySnapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
                completion(false)
                return
            } else{
                if querySnapshot?.documents != nil{
                    let doc = querySnapshot?.documents[(querySnapshot?.documents.count ?? 0) - 1]
                    let data = doc?.data()
                    let T00_BRAIN = data?["T00_BRAIN"] as? Float ?? 0.0
                    let T00_LANGUAGE = data?["T00_LANGUAGE"] as? Float ?? 0.0
                    let T00_LARYNX = data?["T00_LARYNX"] as? Float ?? 0.0
                    
                    let T01_LANGUAGE = data?["T01_LANGUAGE"] as? Float ?? 0.0
                    let T01_EAR = data?["T01_EAR"] as? Float ?? 0.0
                    
                    let T02_ARTICULATION = data?["T02_ARTICULATION"] as? Float ?? 0.0
                    let T02_VOCALIZATION = data?["T02_VOCALIZATION"] as? Float ?? 0.0
                    let T02_CONDUCTION = data?["T02_CONDUCTION"] as? Float ?? 0.0
                    let T02_SENSORINEURAL = data?["T02_SENSORINEURAL"] as? Float ?? 0.0
                    
                    let T03_FUNCTIONAL = data?["T03_FUNCTIONAL"] as? Float ?? 0.0
                    let T03_LARYNX = data?["T03_LARYNX"] as? Float ?? 0.0
                    let T03_ORAL = data?["T03_ORAL"] as? Float ?? 0.0
                    
                    var T00 : [PredictResult] = [PredictResult(score: T00_BRAIN, label: "BRAIN"), PredictResult(score: T00_LANGUAGE, label: "LANGUAGE"), PredictResult(score: T00_LARYNX, label: "LARYNX")]
                    var T01 : [PredictResult] = [PredictResult(score: T01_EAR, label: "EAR"), PredictResult(score: T01_LANGUAGE, label: "LANGUAGE")]
                    var T02 : [PredictResult] = [PredictResult(score: T02_ARTICULATION, label : "ARTICULATION"), PredictResult(score: T02_VOCALIZATION, label: "VOCALIZATION"), PredictResult(score: T02_CONDUCTION, label: "CONDUCTION"), PredictResult(score: T02_SENSORINEURAL, label: "SENSORINEURAL")]
                    var T03 : [PredictResult] = [PredictResult(score: T03_ORAL, label: "ORAL"), PredictResult(score: T03_LARYNX, label: "LARYNX"), PredictResult(score: T03_FUNCTIONAL, label: "FUNCTIONAL")]
                    
                    T00.sort {$0.score > $1.score}
                    T01.sort {$0.score > $1.score}
                    T02.sort {$0.score > $1.score}
                    T03.sort {$0.score > $1.score}
                    
                    self.latestInspectionResult = InspectionResultModel(targetDate: doc?.documentID, T00: T00, T01: T01, T02: T02, T03: T03, spectrogram: nil)
                }
                
                completion(true)
                return
            }
        }
    }
    
    func getInspectionResults(completion: @escaping(_ result: Bool?) -> Void){
        self.inspectionResults.removeAll()
        let collectionRef = self.db.collection("Users").document(auth.currentUser?.uid ?? "").collection("Inspection")
        collectionRef.getDocuments(){(querySnapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
                completion(false)
                return
            } else{
                if querySnapshot?.documents != nil{
                    for document in querySnapshot!.documents{
                        let data = document.data()
                        let T00_BRAIN = data["T00_BRAIN"] as? Float ?? 0.0
                        let T00_LANGUAGE = data["T00_LANGUAGE"] as? Float ?? 0.0
                        let T00_LARYNX = data["T00_LARYNX"] as? Float ?? 0.0
                        
                        let T01_LANGUAGE = data["T01_LANGUAGE"] as? Float ?? 0.0
                        let T01_EAR = data["T01_EAR"] as? Float ?? 0.0
                        
                        let T02_ARTICULATION = data["T02_ARTICULATION"] as? Float ?? 0.0
                        let T02_VOCALIZATION = data["T02_VOCALIZATION"] as? Float ?? 0.0
                        let T02_CONDUCTION = data["T02_CONDUCTION"] as? Float ?? 0.0
                        let T02_SENSORINEURAL = data["T02_SENSORINEURAL"] as? Float ?? 0.0
                        
                        let T03_FUNCTIONAL = data["T03_FUNCTIONAL"] as? Float ?? 0.0
                        let T03_LARYNX = data["T03_LARYNX"] as? Float ?? 0.0
                        let T03_ORAL = data["T03_ORAL"] as? Float ?? 0.0
                        
                        var T00 : [PredictResult] = [PredictResult(score: T00_BRAIN, label: "BRAIN"), PredictResult(score: T00_LANGUAGE, label: "LANGUAGE"), PredictResult(score: T00_LARYNX, label: "LARYNX")]
                        var T01 : [PredictResult] = [PredictResult(score: T01_EAR, label: "EAR"), PredictResult(score: T01_LANGUAGE, label: "LANGUAGE")]
                        var T02 : [PredictResult] = [PredictResult(score: T02_ARTICULATION, label : "ARTICULATION"), PredictResult(score: T02_VOCALIZATION, label: "VOCALIZATION"), PredictResult(score: T02_CONDUCTION, label: "CONDUCTION"), PredictResult(score: T02_SENSORINEURAL, label: "SENSORINEURAL")]
                        var T03 : [PredictResult] = [PredictResult(score: T03_ORAL, label: "ORAL"), PredictResult(score: T03_LARYNX, label: "LARYNX"), PredictResult(score: T03_FUNCTIONAL, label: "FUNCTIONAL")]
                        
                        T00.sort {$0.score > $1.score}
                        T01.sort {$0.score > $1.score}
                        T02.sort {$0.score > $1.score}
                        T03.sort {$0.score > $1.score}
                        
                        self.inspectionResults.append(InspectionResultModel(targetDate: document.documentID, T00: T00, T01: T01, T02: T02, T03: T03, spectrogram: nil))
                    }
                }
                
                completion(true)
                return
            }
        }
    }
    
    func getSpectrograms(id: String, completion: @escaping(_ result: URL?) -> Void){
        let storageRef = self.storage.reference().child("spectrograms/\(self.auth.currentUser?.uid ?? "")/\(id)/spectrogram.png")
        storageRef.downloadURL(){downloadURL, error in
            if error != nil{
                print(error?.localizedDescription)
                completion(nil)
                return
            } else{
                completion(downloadURL)
                return
            }
        }
    }
}
