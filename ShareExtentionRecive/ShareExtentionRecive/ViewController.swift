//
//  ViewController.swift
//  ShareExtentionRecive
//
//  Created by Hoang Le on 12/13/18.
//  Copyright © 2018 Hoang Le. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var contanerView: UIView!
    @IBOutlet weak var lblError: UILabel!
    var urlPlayer:URL?
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    var isPlayVideo = false {
        didSet{
            self.playOrPauseVideo()
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let urlPlayer = self.urlPlayer {
            initPlayer(videoUrl: urlPlayer)
            self.isPlayVideo = false
            self.lblError.isHidden = true
        }else {
            self.lblError.isHidden = false
        }
        
    }
    @IBAction func tapContannerView(_ sender: Any) {
        if self.urlPlayer != nil {
            self.isPlayVideo = !self.isPlayVideo
        }
    }
    

}

extension ViewController {
    func initPlayer(videoUrl: URL){
        playerItem = AVPlayerItem(url: videoUrl)
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.contanerView.bounds
        self.contanerView.layer.addSublayer(playerLayer!)
        // setup video loop
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) {[weak self] _  in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    }
    
    func playOrPauseVideo(){
        if self.isPlayVideo {
            self.player?.pause()
        }else {
            self.player?.play()
        }
    }
}
