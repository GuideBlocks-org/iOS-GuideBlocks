//
//  QRButtonView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct QRButtonView: View {
    @ObservedObject var viewModel: QRViewModel
    var closeButtonTapped: () -> ()
    
    var container: SHTipElement? {
        viewModel.contextualContainer?.guidePayload.guide
    }
    
    var title: String {
        container?.title.text ?? "QR Code Scanner"
    }
    
    var body: some View {
        ZStack {
            if viewModel.qrCodeVisible {
                // background view to detect taps outside the button
                Color.white
                    .onTapGesture {
                        viewModel.qrCodeVisible = false
                    }
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.1)
                Button(
                    action: {
                        viewModel.isPopupVisible.toggle()
                        print("QR Code button tapped")
                    },
                    label: {
                        Text(title)
                            .contextualContainerFormat(container)
                            .contextualTextFormat(container?.title)
                            .contextualTextFormat(container?.content)
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                )
                .padding(40)
                //.background(Color.yellow)
                .overlay(
                    CloseButton(
                        imageElement: container?.arrayImages.first,
                        closeButtonTapped: {
                            closeButtonTapped()
                            viewModel.qrCodeVisible = false
                        }
                    ),
                    alignment: .topTrailing
                )
                .sheet(isPresented: $viewModel.isPopupVisible) {
                    if #available(iOS 16.0, *) {
                        QRCodeScannerView(viewModel: viewModel)
                            .presentationDetents([.medium, .large])
                    } else {
                        QRCodeScannerView(viewModel: viewModel)
                    }
                }
            }
        }
    }
}

struct QRButtonView_Previews: PreviewProvider {
    static var previews: some View {
        QRButtonView(
            viewModel: qrViewModel,
            closeButtonTapped: {
            }
        )
    }
}
