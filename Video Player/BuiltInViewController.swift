//
//  BuiltInViewController.swift
//  Video Player
//
//  Created by Przemek on 3/9/19.
//  Copyright © 2019 Przemek Broda. All rights reserved.
//

import UIKit
import AVFoundation

class BuiltInViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    var movie: Movie?
    var player: AVPlayer?
    var isPlaying = false
    var isEnd = false
    @IBOutlet weak var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = AVPlayer(url: movie!.url)
        playerView.player = player
        var totalDuration = Int(player!.currentItem!.asset.duration.seconds)
        
        let queue = DispatchQueue.main
        let interval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player?.addPeriodicTimeObserver(forInterval: interval, queue: queue, using: { (time) in
            let second = Int(time.seconds)
            
            let minutes = Int(second / 60)
            
            let seconds = second - minutes * 60
            var secondsString = String(seconds)
            
            if seconds < 10 {
                secondsString = "0\(seconds)"
            }
            
            if totalDuration == second {
                self.isEnd = true
                self.player?.seek(to: CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
                self.player?.pause()
            }
            
            self.timeLabel.text = "\(minutes):\(secondsString)"
            
        })
    }
    
    @IBAction func goBackButton(_ sender: UIButton) {
        player?.pause()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        if let pl = player {
            if !pl.isPlaying() {
                pl.play()
                sender.setTitle("Pause", for: .normal)
            } else {
                pl.pause()
                sender.setTitle("Play", for: .normal)
            }
        }
    }
    
}

