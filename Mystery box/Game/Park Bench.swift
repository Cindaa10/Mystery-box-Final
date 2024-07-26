//
//  ContentView.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 22/04/24.
//

import SwiftUI
import SwiftData



struct Park_Bench: View {
    @EnvironmentObject var globalLogic: GlobalLogic
    @State var animationVisible = false
    @State var animation : String?
    @State var isGestureVisible = true
    @State var opacity: Double = 0.0
    let buttonAction: () -> Void
//    @State var runButtonAction = false
    
    var body: some View {
        ZStack {
            ZStack {
                Image("backgroundParkBench")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .ignoresSafeArea()
                

                HStack(spacing: 100) {
                    Image("bench")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .onLongPressGesture {
                            print("Succeed1")
                            let randomBool = Bool.random()
                            globalLogic.checkAnswer(randomBool)
                            
                            if globalLogic.lastAnswerCorrect{
                                animation = "ParkBenchLucky"
                                print("button1 is true")
                            } else{
                                animation = "ParkBenchUnlucky"
                                print("button1 is false")
                            }
                            
                            animationVisible = true

                        }
                    
                    Image("bench")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .onLongPressGesture {
                            print("Succeed2")
                            let randomBool = Bool.random()
                            globalLogic.checkAnswer(randomBool)
                            if globalLogic.lastAnswerCorrect{
                                animation = "ParkBenchLucky"
                                print("button2 is true")
                            } else{
                                animation = "ParkBenchUnlucky"
                                print("button2 is false")
                            }
                            animationVisible = true

                        }
                    
                    
                    
                }
                .padding(.top, 90)
                
                Image("man")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading, 100)
                
                
                
                if isGestureVisible {
                    HStack(spacing: 150) {
                        LottieView(animationName: "LongPressSlowed2")
                            .frame(width: 300)
                            .padding(.leading, -225)
                        
                        LottieView(animationName: "LongPressSlowed2")
                            .frame(width: 300)
                            .padding(.leading, -300)
                            .scaleEffect(x: -1, y: 1)
                    }
                    .padding(.top, 100)
                    .transition(.opacity)
                    .opacity(isGestureVisible ? 1 : 0)
                    .animation(.easeInOut(duration: 2))
                    .onAppear {
                        
                        if globalLogic.life != 0 /*&& animationVisible == false*/ {
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
//                            isGestureVisible = true
                            
                            
                            }
                    })
                
                
            }
        }
        .opacity(opacity)
        .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        opacity = 1
                    }
                }
//        .onAppear(perform: {
//            SoundManager.shared.playSound(named: "gameSound")
//           
//        })
        
//        .onChange(of: isGestureVisible) { newValue in
//            if newValue && globalLogic.life != 0  {
//                SoundManager.shared.playSound(named: "gameSound")
//            }
//        }
        
        
    }
    
}

#Preview {
    Park_Bench(buttonAction: {})
    
}
