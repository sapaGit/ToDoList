//
//  CustomTableViewCell.swift
//  ToDoList
//
//  Created by Sergey Pavlov on 26.07.2022.
//

import UIKit

protocol CheckTableViewCellDelegate: AnyObject {
    func checkTableViewCell(cell: CustomTableViewCell, didSwitchCell switched: Bool)
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    @IBOutlet var taskSwitch: UISwitch!
    
    weak var delegate: CheckTableViewCellDelegate?
    @IBAction func switchTapped(_ sender: UISwitch) {
        delegate?.checkTableViewCell(cell: self, didSwitchCell: sender.isOn)
    }
    
}
