//
//  VersionManagement.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import Foundation
import Firebase

class VersionManagement{
    private let db = Firestore.firestore()
    
    func getLatest(completion : @escaping(_ result : String?) -> Void){
        self.db.collection("Version").document("iOS").getDocument(){(document, error) in
            if error != nil{
                print(error)
                completion(nil)
                return
            } else{
                completion(document?.get("Version") as? String ?? "")
            }
        }
    }
    
    func getVersion() -> String{
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    func getBuild() -> String{
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
}
