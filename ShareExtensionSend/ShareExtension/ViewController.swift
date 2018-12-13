//
//  ViewController.swift
//  ShareExtension
//
//  Created by Hoang Le on 12/12/18.
//  Copyright © 2018 Hoang Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let videoUrl: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "VfE_html5", ofType: "mp4")!)
    
    @IBAction func shareImage(_ sender: Any) {
//        let firstActivityItem = "Text you want"
//        let secondActivityItem : NSURL = NSURL(string: "http//:urlyouwant")!
        // If you want to put an image
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [videoUrl], applicationActivities: nil)

        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)

        // This line remove the arrow of the popover to show in iPad
    activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var Share: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

