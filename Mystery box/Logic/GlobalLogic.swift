//
//  GlobalLogic.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 25/04/24.
//

import Foundation
import SwiftUI

class GlobalLogic: ObservableObject {
    @Published var totalRight = 0
    @Published var totalPlay = 0
    @Published var life = 3
    @Published var lastAnswerCorrect = false
    @Published var isRevived = false
    

    func checkAnswer(_ option: Bool) {
        let rdmBool = Bool.random()
        if option == true && rdmBool == true {
                    print("Correct Answer!")
                    totalRight += 1
                    print(totalRight)
                    lastAnswerCorrect = true
                    
                    
                } else {
                    print("Wrong Answer!")
                    life -= 1
                    print(totalRight)
                    print(life)
                    lastAnswerCorrect = false
            }
        totalPlay += 1
        
        
//        if totalRight % 3 == 0 && life < 3 && isRevived == false && totalRight != 0 {
//            life += 1
////            image = "heart"
//            isRevived = true
//        } else if totalRight % 3 != 0  {
//            isRevived = false
//        }
        
        
    }
    


    func result() -> String{
        var imageResult = "none"

        if totalRight == 0 {
            imageResult = "Crocodile"
        } else if totalRight == 1 {
            imageResult = "Cat"
        } else if totalRight == 2{
            imageResult = "Bunny"
        } else if totalRight == 3{
            imageResult = "Pidgeon"
        } else if totalRight >= 4{
            imageResult = "Elephant"
        }
        print(imageResult)
        return imageResult
        
        
    }
    
    func reset() {
        totalRight = 0
        totalPlay = 0
        life = 3
        lastAnswerCorrect = false
        isRevived = false
    }

    
}

