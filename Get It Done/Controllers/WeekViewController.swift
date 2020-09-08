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
    
    var daySelected : DaySelected?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func renderView() {
        for notifBubble in notifBubbles! {
            notifBubble.layer.cornerRadius = notifBubble.frame.height / 2
        }
    }
    
    @IBAction func dayClicked(_ sender : UIButton) {
        daySelected = DaySelected(day: sender.currentTitle, backgroundColor: sender.backgroundColor)
        performSegue(withIdentifier: K.detailSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DayViewController
        destinationVC.daySelected.backgroundColor = self.daySelected?.backgroundColor
        destinationVC.daySelected.day = self.daySelected?.day?.trimmingCharacters(in: .whitespaces)
    }
    
}

