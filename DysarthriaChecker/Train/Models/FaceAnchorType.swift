//
//  FaceAnchorType.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/14.
//

import Foundation

class FaceAnchorType : ObservableObject{
    @Published var jawOpen = Float()
    @Published var mouthClose = Float()
    @Published var mouthDimpleLeft = Float()
    @Published var mouthDimpleRight = Float()
    @Published var mouthFrownLeft = Float()
    @Published var mouthFrownRight = Float()
    @Published var mouthLowerDownLeft = Float()
    @Published var mouthLowerDownRight = Float()
    @Published var mouthPressLeft = Float()
    @Published var mouthPressRight = Float()
    @Published var mouthUpperUpLeft = Float()
    @Published var mouthUpperUpRight = Float()
    @Published var tongueOut = Float()
}
