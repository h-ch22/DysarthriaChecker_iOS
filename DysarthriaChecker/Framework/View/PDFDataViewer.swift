//
//  PDFDataViewer.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/19/23.
//

import PDFKit
import SwiftUI

struct PDFDataViewer: UIViewRepresentable {
    typealias UIViewType = PDFView

    let data: Data
    let singlePage: Bool

    init(_ data: Data, singlePage: Bool = false) {
        self.data = data
        self.singlePage = singlePage
    }

    func makeUIView(context _: UIViewRepresentableContext<PDFDataViewer>) -> UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        if singlePage {
            pdfView.displayMode = .singlePage
        }
        return pdfView
    }

    func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<PDFDataViewer>) {
        pdfView.document = PDFDocument(data: data)
    }
}
