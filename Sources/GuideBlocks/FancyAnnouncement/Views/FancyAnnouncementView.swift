//
//  FancyAnnouncementView.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2023/11/7.
//  Copyright © 2023 Contextual.
//

import ContextualSDK
import SwiftUI

struct FancyAnnouncementView: View {
    @ObservedObject var viewModel: FancyAnnouncementViewModel
    
    var image: Image?
    var imageUrl: String?
    var accentColor: Color?
    var closeButtonColor: Color?
    var closeButtonTapped: () -> ()
    var leftButtonTapped: (() -> ())?
    var rightButtonTapped: (() -> ())?
    
    @State private var fontSize: CGFloat = 20
    @State private var buttonWidth: CGFloat = 0
    @State private var mainImage: Image?
    
    let circleBorderWidth = CGFloat(6)
    let screenWidth = UIScreen.main.bounds.width
    
    var accentColorFinal: Color {
        accentColor ?? Color(red: 76/255, green: 159/255, blue: 136/255)
    }
    
    var imageBackgroundColor: Color {
        Color(red: 245/255, green: 245/255, blue: 245/255)
    }
    
    var square: CGFloat {
        screenWidth - 50
    }
    
    var circle: CGFloat {
        square / 2
    }
    
    var container: SHTipElement? {
        viewModel.contextualContainer?.guidePayload.guide
    }
    
    var title: String {
        container?.title.text ??
        "Create Account"
    }
    
    var message: String {
        container?.content.text ??
        "By creating an account, you will benefit from Contextual extensibility as well as the conventional guides."
    }
    
    var leftButtonTitle: String {
        container?.prev.buttonText ??
        "Cancel"
    }
    
    var rightButtonTitle: String {
        container?.next.buttonText ??
        "Submit"
    }
    
    func updateData() {
        if mainImage == nil {
            if let imageUrl = imageUrl,
               let url = URL(string: imageUrl) {
                UIImage.loadFromUrl(url, completion: { image in
                    if let image = image {
                        mainImage = Image(uiImage: image)
                    }
                })
            } else {
                mainImage = Image(systemName: "person.circle.fill")
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .background(Color.clear)
                .shadow(color: Color.gray, radius: 4, x: 0, y: 0)
                .overlay(
                    VStack {
                        Spacer()
                        Text(title)
                            .contextualContainerFormat(container)
                            .contextualTextFormat(container?.title)
                            .contextualTextFormat(container?.content)
                        Text(message)
                            .contextualBoxFormat(container?.content)
                            .contextualTextFormat(container?.content)
                        HStack {
                            Button(
                                action: {
                                    leftButtonTapped?()
                                },
                                label: {
                                    Text(leftButtonTitle)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(accentColorFinal, lineWidth: 1)
                                        )
                                        .contextualButtonFormat(container?.prev)
                                        .offset(x: 20, y: 0)
                                }
                            )
                            Spacer()
                            Button(
                                action: {
                                    rightButtonTapped?()
                                },
                                label: {
                                    Text(rightButtonTitle)
                                        .padding()
                                        .background(accentColorFinal)
                                        .cornerRadius(8)
                                        .contextualButtonFormat(container?.next)
                                        .offset(x: -20, y: 0)
                                }
                            )
                        }
                    }
                        .offset(x: 0, y: -20)
                )
                .frame(width: square, height: square)
                .zIndex(0)
            
            // Top Border Line
            Rectangle()
                .foregroundColor(accentColorFinal)
                .frame(width: square-6, height: 2)
                .offset(x: 1, y: -square/2+1)
                .zIndex(2)
            
            // Circular Header Image
            mainImage?
                .resizable()
                .frame(width: circle, height: circle)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: circleBorderWidth))
                .background(
                    Circle()
                        .fill(imageBackgroundColor)
                        .frame(width: circle, height: circle)
                        .shadow(color: Color.gray, radius: 4, x: 0, y: 0)
                )
                .offset(x: 0, y: -circle)
                .zIndex(5)
        }
        .padding(25)
        .overlay(
            CloseButton(
                padding: 5,
                foregroundColor: accentColorFinal,
                backgroundColor: .white,
                imageElement: container?.arrayImages.first,
                closeButtonTapped: {
                    closeButtonTapped()
                }
            ),
            alignment: .topTrailing
        )
        .onAppear {
            updateData()
        }
    }
}

struct FancyAnnouncementView_Previews: PreviewProvider {
    static var previews: some View {
        
        return FancyAnnouncementView(
            viewModel: fancyAnnouncementViewModel,
            imageUrl: "https://virl.bc.ca/wp-content/uploads/2019/01/AccountIcon2.png",
            accentColor: nil,
            closeButtonColor: nil,
            closeButtonTapped: {

            },
            leftButtonTapped:  {
                // Do nothing
            },
            rightButtonTapped: {
                // Do nothing
            }
        )
    }
}
