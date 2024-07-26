//
//  gameOver.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 26/04/24.
//

import SwiftUI

struct gameOver: View {
    @EnvironmentObject var globalLogic: GlobalLogic
//    @State var image: String?
    @State var yOffset: CGFloat = -390
    @State private var scale: CGFloat = 5
    @State var masking = false
    @State var displayButton = false
    var resetAction: () -> Void

    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                var image: String = globalLogic.result()
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: .infinity)
                    .offset(y: yOffset)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 3)
                        .delay(0.5))
            }
            .onAppear {
                SoundManager.shared.playSound(named: "slowMusic")
                withAnimation {
                    yOffset = -100
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        masking = true
                        
                    }
                }
            }
            
            if masking == true{
                Image("Subtract") // Replace this with your image
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(scale)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: .infinity, height: .infinity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3)) {
                            scale = 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                displayButton = true
                                
                            }
                            
                        }
                    }
            }
            if displayButton{
                HStack{
                    VStack {
                        Button(action: {
                            // Action to perform when the button is tapped
                            print("Button tapped!")
                        }) {
                            // Image to use as the button's label
                            Image("LogoWhite")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100) // Adjust size as needed
                        }
                        .padding(16)
                        
                        Rectangle()
                            .frame(width: 50, height: 100)
                            .foregroundStyle(.clear)
                        
                        
                    }
                    Spacer()
                    VStack{
                        Button(action: {
                            // Action to perform when the button is tapped
                            print("Button tapped!")
                        }) {
                            // Image to use as the button's label
                            Image("LeaderBoardButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70) // Adjust size as needed
                        }
                        Button(action: {
                            // Action to perform when the button is tapped
                            SoundManager.shared.stopSound()
                            print("Button tapped!")
                            resetAction()
                        }) {
                            // Image to use as the button's label
                            Image("NextButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70) // Adjust size as needed
                        }
                    }
                    .padding(16)
                    .padding(.top, -40)
                    
                    
                }
//                .opacity(isVisible ? 1 : 0)
                .animation(.easeInOut(duration: 3))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    gameOver(resetAction: {})
}
