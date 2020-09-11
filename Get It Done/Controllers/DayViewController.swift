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
    @IBOutlet weak var taskTableView: UITableView!
    
    var tasks: [Task] = []
    
    var daySelected = DaySelected(day: "", backgroundColor: .white)
    
    override func viewWillAppear(_ animated: Bool) {
        fixNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    @IBAction func addTask(_ sender: UIButton) {
        var descriptionInput: UITextField = UITextField()
        var categoryInput: UITextField = UITextField()
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (alertAction) in
            let task = Task( descriptionInput.text!, categoryInput.text!)
            self.tasks.append(task)
            self.taskTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
            print("Canceling")
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addTextField { (textField) in
            categoryInput = textField
            textField.placeholder = "Category"
        }
        alert.addTextField { (textField) in
            descriptionInput = textField
            textField.placeholder = "Description"
        }
        self.present(alert, animated: true, completion: nil)
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
        taskTableView.delegate = self
        taskTableView.register(UINib(nibName: "Task Cell", bundle: .none), forCellReuseIdentifier: "taskCell")
        taskTableView.separatorStyle = .none
        taskTableView.rowHeight = 120
    }
}

extension DayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.taskCell) as! Task_Cell
        cell.categoryText.text = tasks[indexPath.row].category
        cell.descriptionText.text = tasks[indexPath.row].description
        cell.categoryText.textColor = daySelected.backgroundColor
        cell.descriptionText.textColor = daySelected.backgroundColor
        cell.numberBubble.backgroundColor = daySelected.backgroundColor
        cell.number.text = "#\(indexPath.row + 1)"
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
