//
//  DayViewController.swift
//  Get It Done
//
//  Created by Dylan Kuster on 9/7/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit

// MARK: - Render View

class DayViewController: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var thingsToDoLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var tasks: [Task] = []
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
        dayLabel.text = daySelected.day
        taskTableView.delegate = self
        taskTableView.register(UINib(nibName: "Task Cell", bundle: .none), forCellReuseIdentifier: "taskCell")
        taskTableView.separatorStyle = .none
        taskTableView.rowHeight = 120
        addButton.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .highlighted)
    }
    
}

// MARK: - Button Handling

extension DayViewController {
    
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
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if (editButton.tag == 0) {
            editButton.setBackgroundImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
            editButton.tag += 1
        }
        else {
            editButton.setBackgroundImage(UIImage(systemName: "pencil.circle"), for: .normal)
            editButton.tag -= 1
        }
        taskTableView.isEditing = !taskTableView.isEditing
    }
    
}

extension DayViewController: TaskCellDelegate {
    func selectCell(at index: Int) {
        DispatchQueue.main.async {
            self.tasks.remove(at: index)
            self.taskTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            self.taskTableView.reloadData()
        }
    }
}

// MARK: - Table View

extension DayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = tasks[destinationIndexPath.row]
        tasks[destinationIndexPath.row] = tasks[sourceIndexPath.row]
        tasks[sourceIndexPath.row] = temp
        taskTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.taskCell) as! Task_Cell
        cell.delegate = self
        cell.categoryText.text = tasks[indexPath.row].category
        cell.descriptionText.text = tasks[indexPath.row].description
        cell.categoryText.textColor = daySelected.backgroundColor
        cell.descriptionText.textColor = daySelected.backgroundColor
        cell.completeBackground.backgroundColor = daySelected.backgroundColor
        cell.completeButton.backgroundColor = daySelected.backgroundColor
        cell.number.textColor = daySelected.backgroundColor
        cell.number.text = "#\(indexPath.row + 1)"
        cell.backgroundColor = .clear
        return cell
    }
    
}
