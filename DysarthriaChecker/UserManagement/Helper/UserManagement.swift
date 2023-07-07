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
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func signIn(email : String, password : String, completion : @escaping(_ result : Bool?) -> Void){
        auth.signIn(withEmail: email, password: password){_, error in
            if error != nil{
                print(error)
                completion(false)
                return
            }
            
            self.getUserInfo(){result in
                guard let result = result else{return}
                UserDefaults.standard.set(AES256Util.encrypt(string: email), forKey: "auth_email")
                UserDefaults.standard.set(AES256Util.encrypt(string: password), forKey: "auth_password")
                
                completion(true)
                return
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
}
