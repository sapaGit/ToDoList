//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Sergey Pavlov on 28.07.2022.
//

import UIKit

protocol ToDoViewControllerDelegate: AnyObject {
    func todoViewController(_ vc: ToDoViewController, didSaveTask task: Task)
}

class ToDoViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    //Tasks
    var task: Task?
    
    weak var delegate: ToDoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.text = task?.title
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        let task = Task(title: textField.text ?? "")
        delegate?.todoViewController(self, didSaveTask: task)
    }
    
}
