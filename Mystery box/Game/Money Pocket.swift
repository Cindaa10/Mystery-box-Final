//
//  Magnifying.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 26/04/24.
//

import SwiftUI

struct Money_Pocket: View {
    @State private var dragLocation = ""
    @State var animationVisible = false 
    @State var animation : String?
    @State var isGestureVisible = true
    
    @EnvironmentObject var globalLogic: GlobalLogic
    let buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            ZStack {
                    Image("MoneyBackground")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .ignoresSafeArea()
                
                
                    Image("Body")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: .infinity, height: .infinity)
                    .ignoresSafeArea()
                    .padding(.top, -30)
                    
                    
                    HStack(spacing: 250) {
                        Rectangle()
                            .frame(width: 90, height: 200)
                            .foregroundColor(.clear)
                            .contentShape(Rectangle())
                            .rotationEffect(.degrees(135))
                            .gesture(
                                DragGesture()
                                    .onEnded({value in
                                    print("Left dragged")
                                    let randomBool = Bool.random()
                                    globalLogic.checkAnswer(randomBool)
                                        
                                        if globalLogic.lastAnswerCorrect{
                                            animation = "MoneyLucky"
                                            print("Left is true")
                                        } else{
                                            animation = "MoneyUnlucky"
                                            print("Left is false")
                                        }
                                        
                                    animationVisible = true

                                    })
                                    
                        )
                        
                        Rectangle()
                            .frame(width: 90, height: 200)
                            .foregroundColor(.clear)
                            .contentShape(Rectangle())
                            .rotationEffect(.degrees(45))
                            .gesture(
                                DragGesture()
                                    .onEnded({value in
                                    print("Right Dragged")
                                        let randomBool = Bool.random()
                                        globalLogic.checkAnswer(randomBool)
                                        
                                        if globalLogic.lastAnswerCorrect{
                                            animation = "MoneyLucky"
                                            print("Right is true")
                                        } else{
                                            animation = "MoneyUnlucky"
                                            print("Right is false")
                                        }
                                        
                                        animationVisible = true
                                        
                        
                                    })
                                    
                        )

                    }
                    .padding(.leading, 50)
                
                if isGestureVisible{
                    HStack{
                        LottieView(animationName: "dragGesture")
                            .frame(width: 300)
                            .padding(.leading, -225)
                        
                        LottieView(animationName: "dragGesture")
                            .frame(width: 300)
                            .padding(.leading, -300)
                            .scaleEffect(x: -1, y: 1)
                        
                    }
                    .padding(.top,10)
                    .transition(.opacity)
                    .opacity(isGestureVisible ? 1 : 0)
                    .animation(.easeInOut(duration: 2))
                    .onAppear {
                        if globalLogic.life != 0 {
                            SoundManager.shared.playSound(named: "gameSound")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation {
                                
                                isGestureVisible = false
                            }
                            
                        }
                        
                        
                    }
                }
                    
            }
            
            
            if animationVisible == true {
                OverlayStage(animationVisible: $animationVisible, animation: $animation, globalLogic: globalLogic)
                    .transition(.opacity)
                    .onAppear(perform: {
                        SoundManager.shared.stopSound()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isGestureVisible = true
                                buttonAction()
                            }
                    })
                
               
            }
        }
//        .onAppear(perform: {
//            SoundManager.shared.playSound(named: "gameSound")
//           
//        })
//        .onChange(of: isGestureVisible) { newValue in
//            if newValue && globalLogic.life != 0{
//                SoundManager.shared.playSound(named: "gameSound")
//            }
//        }
            
      
    }
    
}

#Preview {
    Money_Pocket(buttonAction: {})
}
