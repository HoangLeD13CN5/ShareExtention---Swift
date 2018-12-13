//
//  ShareViewController.swift
//  ShareVideo
//
//  Created by Hoang Le on 12/13/18.
//  Copyright © 2018 Hoang Le. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices
import AVFoundation

class ShareViewController: UIViewController {

    @IBOutlet weak var contannerView: UIView!
    let sharedKey = "VideoSharePhotoKey"
    
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageVideos()
    }

    @IBAction func didTapNext(_ sender: Any) {
        
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        
    }
    
    func manageVideos() {
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        let contentType = kUTTypeImage as String
        let conentVideo = kUTTypeMovie as String
        let conentCSVFile = kUTTypeCommaSeparatedText as String
        if let attachments = content.attachments {
            for (index, attachment) in attachments.enumerated() {
                if attachment.hasItemConformingToTypeIdentifier(contentType) || attachment.hasItemConformingToTypeIdentifier(conentVideo) || attachment.hasItemConformingToTypeIdentifier(conentCSVFile) {
                    
                    attachment.loadItem(forTypeIdentifier: conentVideo, options: nil) { [weak self] data, error in
                        
                        if error == nil, let url = data as? URL, let this = self {
                            DispatchQueue.main.async {
                                // show video
                                self?.initPlayer(videoUrl: url)
                                // send app
                                let userDefaults = UserDefaults(suiteName: "group.demo.ShareExtentionRecive")
                                userDefaults?.set(url, forKey: this.sharedKey)
                                userDefaults?.synchronize()
                            }
                            
                        } else {
                            print("GETTING ERROR")
                            let alert = UIAlertController(title: "Error", message: "Error loading video", preferredStyle: .alert)
                            
                            let action = UIAlertAction(title: "Error", style: .cancel) { _ in
                                self?.dismiss(animated: true, completion: nil)
                            }
                            
                            alert.addAction(action)
                            self?.present(alert, animated: true, completion: nil)
                        }
                    }
                    if index == 0 {
                        break
                    }
                }
            }
        }
    }

}

extension ShareViewController {
    func initPlayer(videoUrl: URL){
        playerItem = AVPlayerItem(url: videoUrl)
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.contannerView.bounds
        self.contannerView.layer.addSublayer(playerLayer!)
        // setup video loop
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) {[weak self] _  in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    }
}
