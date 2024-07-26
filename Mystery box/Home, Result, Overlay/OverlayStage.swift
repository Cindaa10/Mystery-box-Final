//
//  OverlayStage.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 28/04/24.
//

import SwiftUI

struct OverlayStage: View {
    
    @Binding var animationVisible: Bool
    @Binding var animation : String?
    @State var image = "CloverLeaf"
    @ObservedObject var globalLogic: GlobalLogic
    @State var musicName: String?
    //pengganti globalLogic sementara

    
    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .transition(.opacity)
                .opacity(0.8)
            
            
            VStack {
                Image(animation!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 450)
                    //ini mau dipindahin ke zstack
                    .onAppear {
                        print("animation \(animation!) is appear")
                        
                        if globalLogic.lastAnswerCorrect == true{
                            musicName = "lucky" //ganti sama sound lucky
                        } else{
                            musicName = "unlucky"
                        }
                        
                        SoundManager.shared.playSound(named: musicName!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                animationVisible = false
//                                SoundManager.shared.stopSound()
                            }
                        }
                }
                    .padding(20)
                
                //pikirin logic buat kurang atau tambahin with animationnya
                HStack (spacing: 14) {
                    ForEach(0..<globalLogic.life, id: \.self){ index in
                        Image(image)
                            .resizable()
                            .frame(width: 46, height: 45)
                    }
                    let dead = 3 - globalLogic.life
                    ForEach(0..<dead, id: \.self){_ in
                        Image("deadLife")
                            .resizable()
                            .frame(width: 46, height: 45)
                    }
                    
                }
            }
        }
        .onChange(of: globalLogic.life) { _ in
                    // This closure will be called whenever globalLogic.life changes
                    // We don't need to do anything here, just ensure that the view is updated
                }
//        .onAppear(perform: {
//            if globalLogic.lastAnswerCorrect == true{
//                musicName = "unlucky" //ganti sama sound lucky
//            } else{
//                musicName = "unlucky"
//            }
//            
//            SoundManager.shared.playSound(named: musicName!)
//           
//        })
        
    }
}

struct OverlayStage_Previews: PreviewProvider {
    static var previews: some View {
        let globalLogic = GlobalLogic() // Create an instance of GlobalLogic
        return OverlayStage(animationVisible: .constant(true), animation: .constant("ParkBenchLucky"), globalLogic: globalLogic)
    }
}

//#Preview {
//    OverlayStage(animationVisible: .constant(true), animation: .constant("orangeBackground"))
//}
