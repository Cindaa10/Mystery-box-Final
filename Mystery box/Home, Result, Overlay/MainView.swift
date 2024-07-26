//
//  MainView.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 28/04/24.
//

import SwiftUI

struct MainView: View {
    @State private var xOffset: CGFloat = 0
    @State private var langitOffset: CGFloat = 0
    @Binding var mainViewDisplay : Bool
    
    @State var cloverAngle = 0.0
    @State var isButtonAnimated = false
    
    var body: some View {
        GeometryReader{ geometry in
            
            HStack(spacing:0){
                ZStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 0){
                            ForEach(0..<3){ _ in
                                Image("Background Langit")
                                    .offset(x: self.langitOffset)
                            }
                        }
                    }
                    .onAppear{
                        withAnimation(Animation.linear(duration: 16).repeatForever(autoreverses: false)){
                            self.langitOffset -= UIScreen.main.bounds.width
                            SoundManager.shared.playSound(named: "slowMusic")
                        }
                    }
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(0..<3) { _ in // Repeat the image to create a continuous effect
                                Image("Background Kebon")
                                    .offset(x: self.xOffset)
                            }
                        }
                    }
                    .onAppear {
                        withAnimation(Animation.linear(duration: 8).repeatForever(autoreverses: false)) {
                            self.xOffset -= UIScreen.main.bounds.width
                        }
                    }
                    
                    Image("Logo")
                    
                    Button(action: {
                        mainViewDisplay = false
                        SoundManager.shared.stopSound()
                        print("Button tapped!")
                    }) {
                        Image("Play Button")
                            .padding(.top,240)
                            .scaleEffect(isButtonAnimated ? 1.07 : 1)
                            .animation(.spring(duration: 2).repeatForever())
                    }
                    Image("Settings Button")
                        .padding(.bottom,280)
                        .padding(.leading,700)
                    
                    Image("Clover Small")
//                        .padding(.bottom,200)
//                        .padding(.leading,280)
                        .rotationEffect(.degrees(cloverAngle))
                        .onAppear {
                            let animate = Animation.linear(duration: 0.8)
                            let rep = animate.repeatForever(autoreverses: true)
                            withAnimation(rep) {
                                cloverAngle = 30
                            }
                        }
                        .offset(x:130,y:-100)
                    
                    Image("Clover Small")
//                        .padding(.bottom,250)
//                        .padding(.leading,-180)
                        .resizable().frame(width:50, height:50 )
                        .rotationEffect(.degrees(cloverAngle))
                        .onAppear {
                            let animate = Animation.linear(duration: 0.8)
                            let rep = animate.repeatForever(autoreverses: true)
                            withAnimation(rep) {
                                cloverAngle = 30
                            }
                        }
                        .offset(x:-110,y:-130)
                    
                    Image("Clover Small")
//                        .padding(.bottom,0)
//                        .padding(.leading,-160)
                        .resizable().frame(width:75, height:75 )
                        .rotationEffect(.degrees(cloverAngle))
                        .onAppear {
                            let animate = Animation.linear(duration: 0.8)
                            let rep = animate.repeatForever(autoreverses: true)
                            withAnimation(rep) {
                                cloverAngle = 30
                            }
                        }
                        .offset(x:-100,y:0)

                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MainView(mainViewDisplay: .constant(true))
}
