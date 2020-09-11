//
//  Task Cell.swift
//  Get It Done
//
//  Created by Dylan Kuster on 9/10/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit

class Task_Cell: UITableViewCell {

    @IBOutlet weak var numberBubble: UIView!
    @IBOutlet weak var taskBackground: UIView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var categoryText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7.5, left: 0, bottom: 7.5, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        renderView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func renderView() {
        taskBackground.layer.cornerRadius = taskBackground.frame.height / 6
        numberBubble.layer.cornerRadius = numberBubble.layer.frame.height / 2
    }
    
}
