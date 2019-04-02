//
//  PlayerLayer.swift
//  Video Player
//
//  Created by Przemek on 3/9/19.
//  Copyright © 2019 Przemek Broda. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer{
        return layer as! AVPlayerLayer
    }
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

}
