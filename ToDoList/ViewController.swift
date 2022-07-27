//
//  ViewController.swift
//  ToDoList
//
//  Created by Sergey Pavlov on 26.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var tasksArray = [
        Task(title: "Clean my room"),
        Task(title: "Make a coffe"),
        Task(title: "Learn how to play chess")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
