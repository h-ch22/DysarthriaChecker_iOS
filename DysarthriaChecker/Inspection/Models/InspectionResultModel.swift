//
//  InspectionResultModel.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/18/23.
//

import Foundation
import FirebaseStorage

struct InspectionResultModel : Identifiable{
    var id = UUID()
    let targetDate: String?
    let T00 : [PredictResult]?
    let T01 : [PredictResult]?
    let T02 : [PredictResult]?
    let T03 : [PredictResult]?
    var spectrogram : URL? = nil
    var scripts: String? = nil
}
