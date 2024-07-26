//
//  ContentView.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    let globalLogic = GlobalLogic()
    @State private var randomIndex = 0//Int.random(in: 0...1)
    @State var mainViewDisplay = true
        
    var body: some View {
        NavigationView{
            ZStack{
                
                if mainViewDisplay {
                    MainView(mainViewDisplay: $mainViewDisplay)
                } else{
                    
                    if randomIndex == 0 {
                        Park_Bench(buttonAction: changeView)
                            .environmentObject(globalLogic)
                            
                        
                    } else if randomIndex == 1 {
                        Foot_Step(buttonAction: changeView)
                            .environmentObject(globalLogic)
                        
                    } else if randomIndex == 2 {
                        Money_Pocket(buttonAction: changeView)
                            .environmentObject(globalLogic)
                    } else{
                        gameOver(resetAction: resetApp)
                                                .environmentObject(globalLogic)
                    }
                }
                    
            }.navigationBarHidden(true)
            
        }
    }
    func changeView() {
        if globalLogic.life == 0 {
            SoundManager.shared.stopSound()
            randomIndex = -1
            print(randomIndex)
        } else{
            randomIndex = Int.random(in: 0...2) // gnti jadi 2
            print("\(randomIndex) else")
        }
    }
    
    func resetApp() {
            randomIndex = 0
            mainViewDisplay = true
            globalLogic.reset()
        }
    

    
    
    
}

#Preview {
    ContentView()
}
