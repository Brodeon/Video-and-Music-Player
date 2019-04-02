//
//  ReadyViewController.swift
//  Video Player
//
//  Created by Przemek on 3/17/19.
//  Copyright © 2019 Przemek Broda. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ReadyViewController: UIViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playFalls(_ sender: UIButton) {
        let player = AVPlayer(url: Bundle.main.url(forResource: "fall", withExtension: "mov")!)
        let avc = AVPlayerViewController()
        avc.player = player
        self.present(avc, animated: true, completion: nil)
    }
    
    
    
    
    
    
    

}
