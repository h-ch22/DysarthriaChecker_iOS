//
//  AudioSpectrumView.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 2023/07/06.
//

import SwiftUI

let numberOfSamples: Int = 10

struct AudioSpectrumView: View {
    var value: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.pink.gradient)
                .frame(height: value)
        }
    }
}
