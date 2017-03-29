//
//  ViewController.swift
//  PlayingWithVideo
//
//  Created by Hossam Ghareeb on 9/26/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var playerViewController: AVPlayerViewController?

    var playerLayer: AVPlayerLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addVideoLayer()
    }

    @IBAction func didClickPlay(_ sender: AnyObject) {
        if let layer = self.playerLayer{
            layer.player?.play()
        }
    }
    private func addVideoLayer() {
        
        let itemURL = Bundle.main.url(forResource: "SampleVideo", withExtension: "mp4")
        let player = AVPlayer(url: itemURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.position = CGPoint(x: 0, y: 300)
        playerLayer.frame = CGRect(x: 0, y: 300, width: self.view.bounds.width, height: 200)
        self.playerLayer = playerLayer
        self.view.layer.addSublayer(playerLayer)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayerController" {
            self.playerViewController = segue.destination as? AVPlayerViewController
            preparePlayerViewController()
        }
    }
    
    private func preparePlayerViewController() {
        if let playerVC = self.playerViewController{
            let itemURL = Bundle.main.url(forResource: "SampleVideo", withExtension: "mp4")
            playerVC.player = AVPlayer(url: itemURL!)
        }
    }

}

