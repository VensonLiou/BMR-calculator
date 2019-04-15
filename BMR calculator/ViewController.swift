//
//  ViewController.swift
//  BMR calculator
//
//  Created by 劉玟慶 on 2019/4/13.
//  Copyright © 2019 劉玟慶. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer();
    var currentMusicIndex = Int.random(in: 1...10)
    var audioPath = Bundle.main.path(forResource: "0", ofType: "mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // random background music
        do
        {
            audioPath = Bundle.main.path(forResource: String(currentMusicIndex), ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            // ERROR
        }
        player.play()
        
        // transparent navigation bar
        let image = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationController?.navigationBar.shadowImage = image
    }
    
    
    
}

