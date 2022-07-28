//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Sergey Pavlov on 28.07.2022.
//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.text = task?.title
    }
    

}
