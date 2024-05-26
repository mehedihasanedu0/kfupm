//
//  PDFViewWrapper.swift
//  kfump
//
//  Created by Mehedi Hasan on 25/5/24.
//

import SwiftUI
import PDFKit

struct PDFViewWrapper: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.backgroundColor = .white // Set the background color to white
        pdfView.displayBox = .cropBox
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        if let document = PDFDocument(url: url) {
            uiView.document = document
            //            uiView.goToFirstPage() // Ensure the PDF starts at the top
            DispatchQueue.main.async {
                // Setting the scale after a delay to ensure it takes effect
                uiView.scaleFactor = uiView.scaleFactorForSizeToFit
            }
        }
    }
}
