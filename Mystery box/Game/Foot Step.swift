//
//  Choose Direction.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 23/04/24.
//

import SwiftUI
import CoreMotion

struct Foot_Step: View {
    @State private var shapePosition = CGPoint(x: 370, y: 50)
    let motionManager = CMMotionManager()
    @State var selectedButton: String?
    let buttonAction: () -> Void
    @State private var offsetY: CGFloat = 0
    
    @State var animationVisible = false
    @State var animation : String?
    @State var isGestureVisible = true
    
//    @State var isMax = false
    
    @EnvironmentObject var globalLogic: GlobalLogic

    var body: some View {
        ZStack {
            ZStack{
                //            Text("Selected Button: \(selectedButton ?? "None")")
                //                .padding()
                
                Image("FootBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    //kemungkinan kaki mau dipecah
                    Image("Foot")
                        .resizable()
                        .frame(width: 375, height: 800)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                        .position(shapePosition)
                        .offset(y: offsetY)
                        .animation(.easeInOut, value: 0)
                        .padding(.top, -100)
                    
                    //                Rectangle()
                    //                    .frame(width: 100, height: 10)
                    //                    .foregroundColor(.black)
                    //                    .position(CGPoint(x: shapePosition.x, y: shapePosition.y + 200))
                    
                }
                
                if isGestureVisible == true{
                    LottieView(animationName: "tiltGesture")
                        .frame(width: 400)
                        .padding(.top, 70)
                        .transition(.opacity)
                        .opacity(isGestureVisible ? 1 : 0)
                        .animation(.easeInOut(duration: 2))
                        .onAppear {
                            if globalLogic.life != 0 {
                                SoundManager.shared.playSound(named: "gameSound")
                            }
                            startAccelerometerUpdates()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                withAnimation {
                                    
                                    isGestureVisible = false
                                }
                                
                            }
                            
                            
                        }
                    
                }
                    
                    
                
                
            }
//            .onAppear {
//                
//                startAccelerometerUpdates()
//                //            buttonAction()
//            }
            .onDisappear {
                stopAccelerometerUpdates()
            }
            
            
            if animationVisible == true {
                OverlayStage(animationVisible: $animationVisible, animation: $animation, globalLogic: globalLogic)
                    .transition(.opacity)
                    .onAppear(perform: {
                        SoundManager.shared.stopSound()
                        shapePosition = CGPoint(x: 370, y: 50)
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
//            if newValue {
//                SoundManager.shared.playSound(named: "gameSound")
//            }
//        }
    }

    func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
                   motionManager.accelerometerUpdateInterval = 0.1
                   motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
                       guard let acceleration = accelerometerData?.acceleration else { return }
                       
                       let direction: CGFloat = acceleration.y < 0 ? 1 : -1
                       
                       if acceleration.y > 0.2 || acceleration.y < -0.2 {
                           let newPositionX = shapePosition.x + (CGFloat(direction) * CGFloat(abs(acceleration.y) * 100))
                           print(newPositionX)
                           
                           
                        let screenWidth = UIScreen.main.bounds.width
                        let maxPositionX = screenWidth - 125
                        
                           //perlu atur ulang position max
                        shapePosition.x = max(150, min(newPositionX, maxPositionX))
                           
                        if acceleration.y < 0{
                               selectedButton = "Right"
                            
                        } else{
                               selectedButton = "Left"
                        }
                           
                           //cek udah bisa berenti di kiri belum
                        if shapePosition.x == 150 { //chosen left
                            stopAccelerometerUpdates()

                            let randomBool = Bool.random()
                            globalLogic.checkAnswer(randomBool)
                            
                            if globalLogic.lastAnswerCorrect && selectedButton == "Left" {
                                animation = "FootLucky"
                                print("Left is true")
                            } else{
                                animation = "FootUnlucky"
                                print("Left is false")
                            }
                            
                            animationVisible = true

                            
                        } else if shapePosition.x == maxPositionX{ //chosen right
                            stopAccelerometerUpdates()

                            let randomBool = Bool.random()
                            globalLogic.checkAnswer(randomBool)
                            
                            if globalLogic.lastAnswerCorrect && selectedButton == "Right" {
                                animation = "FootLucky"
                                print("Right is true")
                            } else{
                                animation = "FootUnlucky"
                                print("Right is false")
                            }
                            
                            animationVisible = true

                        }
                           
                       }
                   }
               }
        
        }

    func stopAccelerometerUpdates() {
            motionManager.stopAccelerometerUpdates()
        }

    

        
}

#Preview {
    Foot_Step(buttonAction: {})
}

