//
//  LottieView.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 27/04/24.
//

import SwiftUI
import Lottie

// Create a SwiftUI wrapper for the LottieAnimationView
struct LottieView: UIViewRepresentable {
    let animationView = AnimationView()

    var animationName: String

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        animationView.animation = Animation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the animation if needed
        animationView.animation = Animation.named(animationName)
        animationView.play()
    }
}
