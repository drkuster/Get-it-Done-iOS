//
//  DayViewController.swift
//  Get It Done
//
//  Created by Dylan Kuster on 9/7/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit

class DayViewController: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var thingsToDoLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addThingView: UIView!
    
    var daySelected = DaySelected(day: "", backgroundColor: .white)
    
    override func viewWillAppear(_ animated: Bool) {
        fixNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    func fixNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    func renderView() {
        view.backgroundColor = daySelected.backgroundColor
        addButton.tintColor = daySelected.backgroundColor
        addThingView.layer.cornerRadius = addThingView.frame.height / 2
        dayLabel.text = daySelected.day
    }

}
