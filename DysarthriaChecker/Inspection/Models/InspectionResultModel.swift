//
//  InspectionResultModel.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/18/23.
//

import Foundation

struct InspectionResultModel{
    let targetDate: String?
    let T00 : [PredictResult]?
    let T01 : [PredictResult]?
    let T02 : [PredictResult]?
    let T03 : [PredictResult]?
}
