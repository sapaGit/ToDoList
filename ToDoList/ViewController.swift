//
//  ViewController.swift
//  ToDoList
//
//  Created by Sergey Pavlov on 26.07.2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var tasksArray = [
        Task(title: "Clean my room"),
        Task(title: "Make a coffee"),
        Task(title: "Learn how to play chess")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func startEditingTapped(_ sender: UIButton) {
        tableView.isEditing = !tableView.isEditing
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
    }
    @IBSegueAction func toDoViewController(_ coder: NSCoder) -> ToDoViewController? {
        let vc =  ToDoViewController(coder: coder)
        guard let indexPath = tableView.indexPathForSelectedRow else {return ToDoViewController()}
        
        let task = tasksArray[indexPath.row]
        vc?.task = task
        
        
        vc?.delegate = self
        vc?.presentationController?.delegate = self
        
        return vc
    }
    @IBSegueAction func toDoViewControllerAdd(_ coder: NSCoder) -> ToDoViewController? {
        let vc =  ToDoViewController(coder: coder)
        
        vc?.delegate = self
        return vc
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
           
            let task = self.tasksArray[indexPath.row].completeTask()
            self.tasksArray[indexPath.row] = task
            
            guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else { return }
            cell.taskSwitch.isOn = !cell.taskSwitch.isOn
            
            let arrayOfTasks = self.tasksArray
            UserDefaults.standard.set(arrayOfTasks, forKey: "arrayOfTasks")
            //adding animation for swipe
            complete(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.label.text = tasksArray[indexPath.row].title
        cell.delegate = self
        return cell
    }
}
extension ViewController: CheckTableViewCellDelegate {
    func checkTableViewCell(cell: CustomTableViewCell, didSwitchCell switched: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let task = tasksArray[indexPath.row]
        let newTask = Task(title: task.title, isComplete: switched)
        tasksArray[indexPath.row] = newTask
        print(switched)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasksArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let task = tasksArray.remove(at: sourceIndexPath.row)
        tasksArray.insert(task, at: destinationIndexPath.row)
    }
}
 
extension ViewController: ToDoViewControllerDelegate {
    func todoViewController(_ vc: ToDoViewController, didSaveTask task: Task) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            // update
            tasksArray[indexPath.row] = task
            tableView.reloadRows(at: [indexPath], with: .none)
        } else {
            // create
            tasksArray.append(task)
            tableView.insertRows(at: [IndexPath(row: tasksArray.count-1, section: 0)], with: .automatic)
        }
        dismiss(animated: true, completion: nil)
    }

}

extension ViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
