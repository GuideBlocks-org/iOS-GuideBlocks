//
//  QuizSheetView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/27.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct QuizSheetView: View {
    @ObservedObject var viewModel: QuizViewModel
    var closeButtonTapped: () -> ()
    
    var body: some View {
        if viewModel.quizIsVisible {
            Text("")
                .sheet(isPresented: $viewModel.isPopupVisible) {
                    if #available(iOS 16.0, *) {
                        QuizView(viewModel: viewModel)
                            .presentationDetents([.medium, .large])
                    } else {
                        QuizView(viewModel: viewModel)
                    }
                }
        }
    }
}

struct QuizSheetView_Previews: PreviewProvider {
    static var previews: some View {
        QuizSheetView(
            viewModel: quizViewModel,
            closeButtonTapped: {
            }
        )
    }
}