//
//  SoundManager.swift
//  Mystery box
//
//  Created by Lucinda Artahni on 29/04/24.
//

import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()

    private var audioPlayer: AVAudioPlayer?

    func playSound(named name: String) {
        guard let soundURL = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
        
        print("the song is \(name)")
    }

    func stopSound() {
        audioPlayer?.stop()
    }
}
