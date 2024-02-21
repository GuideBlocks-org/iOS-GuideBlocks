//
//  OpenCarouselGuidView.swift
//
//
//  Created by Aamir on 10/02/24.
//

import SwiftUI
import ContextualSDK

struct OpenCarouselGuidView: View {
    
    let screenSize = UIScreen.main.bounds
    let openCarouselDataManager: OpenCarouselDataManager
    
    var dismissController: () -> ()
    
    init(guide: SHTipElement,onDismiss dismissController: @escaping () -> Void) {
        self.openCarouselDataManager = OpenCarouselDataManager(guide: guide)
        self.dismissController = dismissController
    }

    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
            ForEach(openCarouselDataManager.carouselItems) { viewData in
                OpenCarouselView(data: viewData,
                                 currentTab: $currentTab,
                                 dismissController: dismissController)
                .tag(viewData.id)
            }
        })
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(width: screenSize.width, height: screenSize.height * 0.95)
    }
}

struct OpenCarouselView: View {
    var data: OpenCarouselData
    
    @Binding var currentTab: Int
    @State private var backgroundImage: Image?
    @State private var primaryImage: Image?
    @State private var isAnimating: Bool = false
    
    let screenSize = UIScreen.main.bounds
    var dismissController: () -> ()
    
    var body: some View {
        
        VStack(spacing: 20) {
            ZStack {
                Image("")
                .resizable()

                primaryImage?
                    .resizable()
                    .scaledToFit()
                    .offset(x: 0, y: 150)
                    .frame(width: screenSize.width * 0.8, height: screenSize.width * 0.8)
                    .scaleEffect(isAnimating ? 1 : 0.9)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Spacer()
            if let title = data.carouselDataItem?.titleText {
                Text(title)
                    .contextualCarouselFormat(data.carouselDataItem)
            } else {
                Text("Title \(data.id)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
                        
            if let subtitle = data.carouselDataItem?.contentText {
                Text(subtitle)
                    .contextualCarouselContentElement(data.carouselDataItem)
                
            } else {
                Text("Subtitle \(data.id)")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 250)
                    .foregroundColor(.red)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 2, y: 2)
            }
            if let button = data.button {
                ContexualButton(button: button) {
                    if !data.isLastScreen {
                        withAnimation {
                            currentTab += 1
                        }
                    } else {
                        print("Reached last screen")
                        dismissController()
                    }
                }
            } else {
                Text("Next")
            }
            Spacer()
        }
        .onAppear(perform: {
            isAnimating = false
            withAnimation(.easeOut(duration: 0.5)) {
                self.isAnimating = true
            }
        })
        .task {
            data.loadBackgroundImage { image in
                backgroundImage = image
            }
            
            data.loadPrimaryImage { image in
                primaryImage = image
            }
            
        }
        .background {
            ZStack(alignment: data.backgroundImage?.imageAligment ?? .center, content: {
                Rectangle()
                    .frame(width: screenSize.width, height: screenSize.height)
//                    .background(Color(uiColor: data.backgroundImage?.backgroundColor ?? .clear))

                backgroundImage?
                .resizable()
                .frame(width: data.backgroundImage?.imageSize.width, height: data.backgroundImage?.imageSize.height)
                .margin(data.backgroundImage?.margin ?? FourSide(top: 0, bottom: 0, left: 0, right: 0))
                .border(Color(uiColor: data.backgroundImage?.borderColor ?? .clear), width: data.backgroundImage?.borderWidth ?? 0)
                .clipShape(RoundedRectangle(cornerRadius: data.backgroundImage?.cornerRadius ?? 0, style: .circular))
                
                Rectangle()
                    .frame(width: screenSize.width, height: screenSize.height)
                    .foregroundStyle(Color(uiColor: data.carouselDataItem?.backgroundColor ?? .clear))


            })
            
            .frame(width: screenSize.width, height: screenSize.height)
            .background(Color(uiColor: data.backgroundImage?.backgroundColor ?? .clear))

        }
    }
        
}
