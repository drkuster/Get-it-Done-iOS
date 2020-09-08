//
//  ViewController.swift
//  Get It Done
//
//  Created by Dylan Kuster on 9/7/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit

class WeekViewController: UIViewController {
    
    @IBOutlet var notifBubbles: Array<UIView>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundBubbles()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func roundBubbles() {
        for notifBubble in notifBubbles! {
            notifBubble.layer.cornerRadius = notifBubble.frame.height / 2
        }
    }
    
    @IBAction func dayClicked(_ sender : UIButton) {
        performSegue(withIdentifier: K.detailSegue, sender: self)
    }
    
}

