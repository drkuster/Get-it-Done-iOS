//
//  Task Cell.swift
//  Get It Done
//
//  Created by Dylan Kuster on 9/10/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

protocol TaskCellDelegate {
    func selectCell(at index: Int)
}

import UIKit

class Task_Cell: UITableViewCell {

    @IBOutlet weak var taskBackground: UIView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var categoryText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var completeBackground: UIView!
    @IBOutlet weak var completeButton: UIButton!
    
    var delegate: TaskCellDelegate?
    
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
    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.sync {
                self.completeButton.backgroundColor = UIColor(named: K.brandWhite)
            }
            usleep(useconds_t(75000))
            DispatchQueue.main.sync {
                if let del = self.delegate {
                    var num = self.number.text!
                    num.remove(at: num.startIndex)
                    del.selectCell(at: Int(num)! - 1)
                }
            }
        }
    }
    
    func renderView() {
        taskBackground.layer.cornerRadius = taskBackground.frame.height / 6
        completeBackground.layer.cornerRadius = completeBackground.layer.frame.height / 2
        completeButton.layer.cornerRadius = completeButton.layer.frame.height / 2
    }
    
}
