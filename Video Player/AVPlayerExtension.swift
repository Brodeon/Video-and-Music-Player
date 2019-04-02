//
//  AVPlayerExtension.swift
//  Video Player
//
//  Created by Przemek on 3/9/19.
//  Copyright © 2019 Przemek Broda. All rights reserved.
//

import Foundation
import AVFoundation

extension AVPlayer {
    func isPlaying() -> Bool {
        return rate != 0 && error == nil
    }
}
