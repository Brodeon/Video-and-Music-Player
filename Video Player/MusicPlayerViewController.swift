//
//  MusicPlayerViewController.swift
//  Video Player
//
//  Created by Przemek on 3/17/19.
//  Copyright © 2019 Przemek Broda. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MusicPlayerViewController: UIViewController {

    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    var shouldUpdateSlider = true
    var musicPlayer: AVPlayer?
    var observer: NSKeyValueObservation?
    var commandCenter: MPRemoteCommandCenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMusicPlayer()

    }
    
    func configureMusicPlayer() {
        musicPlayer = AVPlayer(url: Bundle.main.url(forResource: "music", withExtension: "mp3")!)
        addTimeObserverToPlayer(player: musicPlayer)
        NotificationCenter.default.addObserver(self, selector: #selector(endOfTrack), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: musicPlayer?.currentItem)
        UIApplication.shared.beginReceivingRemoteControlEvents()
        observeIsReadyToPlay()
        configureCommandCenter()
    }
    
    func configureCommandCenter() {
        commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter?.playCommand.isEnabled = true
        commandCenter?.playCommand.addTarget(handler: { (event) -> MPRemoteCommandHandlerStatus in
            self.musicPlayer?.play()
            return MPRemoteCommandHandlerStatus.success
        })
        
        commandCenter?.pauseCommand.isEnabled = true
        commandCenter?.playCommand.addTarget(handler: { (event) -> MPRemoteCommandHandlerStatus in
            self.musicPlayer?.pause()
            return MPRemoteCommandHandlerStatus.success
        })
    }

    
    func secondsToMinutesSecondsString(seconds: Double?) -> String? {
        guard let time = seconds else {
            return nil
        }
        
        let timeInt = Int(time)
        let minutes = Int(timeInt / 60)
        let seconds = timeInt - minutes * 60
        var secondsString = "\(seconds)"
        
        if seconds < 10 {
            secondsString = "0\(seconds)"
        }
        
        return "\(minutes):\(secondsString)"
    }
    
    func addTimeObserverToPlayer(player: AVPlayer?) {
        let interval = CMTime(seconds: 0.05, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { time in
            if self.shouldUpdateSlider {
                let seconds = time.seconds
                self.startLabel.text = self.secondsToMinutesSecondsString(seconds: seconds)
                self.musicSlider.value = Float(time.seconds)
            }
        })
    }
    
    @objc func endOfTrack() {
        musicPlayer?.pause()
        musicPlayer?.seek(to: CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
        startLabel.text = secondsToMinutesSecondsString(seconds: musicPlayer?.currentTime().seconds)
    }
    
    func observeIsReadyToPlay() {
        if let item = musicPlayer?.currentItem {
            observer = item.observe(\.status, options: [.new, .old], changeHandler: { (playerItem, valueChanged) in
                if playerItem.status == .readyToPlay {
                    print("Ready to play")
                    self.musicSlider.maximumValue = Float(playerItem.duration.seconds)
                    self.musicSlider.value = Float(0.0)
                    self.endLabel.text = self.secondsToMinutesSecondsString(seconds: playerItem.duration.seconds)
                }
            })
        }
    }

    @IBAction func play(_ sender: Any) {
        if let player = musicPlayer {
            if player.status == .readyToPlay {
                if !player.isPlaying() {
                    player.play()
                } else {
                    player.pause()
                }
            }
        }
    }
    @IBAction func sliderTouched(_ sender: UISlider) {
        print("slider dragged")
        shouldUpdateSlider = false
        musicPlayer?.pause()
    }
    
    @IBAction func sliderTouchUp(_ sender: UISlider) {
        print("slider not dragged")
        musicPlayer?.play()
        shouldUpdateSlider = true
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if !shouldUpdateSlider {
            startLabel.text = secondsToMinutesSecondsString(seconds: Double(sender.value))
            musicPlayer?.seek(to: CMTime(seconds: Double(sender.value), preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
        }
    }
    
    @IBAction func sliderTouchUpOutside(_ sender: UISlider) {
        sliderTouchUp(sender)
    }
    
}
