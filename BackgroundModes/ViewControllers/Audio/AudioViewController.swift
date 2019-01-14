//
//  AudioViewController.swift
//  BackgroundModes
//
//  Created by Timur Shafigullin on 14/01/2019.
//  Copyright © 2019 Timur Shafigullin. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Type Properties
        
        static let playTitle = "PLAY"
        static let pauseTitle = "PAUSE"
    }

    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var trackNameLabel: UILabel!
    @IBOutlet fileprivate weak var timeLabel: UILabel!
    @IBOutlet fileprivate weak var soundControlButton: UIButton!
    
    // MARK: -
    
    fileprivate var player: AVAudioPlayer?
    fileprivate var timer = Timer()
    
    // MARK: - Instance Methods
    
    @IBAction func onSoundControlButtonTouchUpInside(_ sender: UIButton) {
        Log.i(sender.title(for: .normal) ?? "")
        
        if let player = self.player {
            if player.isPlaying {
                self.pauseSound()
            } else {
                self.playSound()
            }
        } else {
            self.playSound()
        }
        
        self.updateControlButtonTitle()
    }
    
    // MARK: -
    
    fileprivate func playSound() {
        if let player = self.player {
            player.play()
            
            self.runTimer()
        } else {
            guard let url = Bundle.main.url(forResource: "Kevin MacLeod - Feelin Good", withExtension: "mp3") else {
                Log.w("Audio file not found")
                return
            }
            
            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.play()
                
                self.runTimer()
                
                self.trackNameLabel.text = "Kevin MacLeod - Feelin Good"
            } catch {
                Log.e("Couldn't load file")
            }
        }
    }
    
    fileprivate func pauseSound() {
        guard let player = self.player else {
            return
        }
        
        self.timer.invalidate()
        
        player.pause()
    }
    
    // MARK: -
    
    fileprivate func updateControlButtonTitle() {
        if player?.isPlaying ?? false {
            self.soundControlButton.setTitle(Constants.pauseTitle, for: .normal)
        } else {
            self.soundControlButton.setTitle(Constants.playTitle, for: .normal)
        }
    }
    
    fileprivate func updateTimer() {
        guard let player = self.player else {
            return
        }
        
        self.timeLabel.text = DurationFormatter.shared.string(from: player.currentTime)
    }
    
    fileprivate func runTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [unowned self] (timer) in
            self.updateTimer()
        })
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
