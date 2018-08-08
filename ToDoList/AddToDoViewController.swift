//
//  AddToDoViewController.swift
//  ToDoList
//
//  Created by Christie Lynam on 8/7/18.
//  Copyright © 2018 Christie Lynam. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    var previousVC = ToDoTableViewController()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addTapped(_ sender: Any) {
/*
        // create a new todo
        let toDo = ToDo()

        if let titleText = titleTextField.text {
            toDo.name = titleText
            toDo.important = importantSwitch.isOn

            // add it to the todo array
            previousVC.toDos.append(toDo)
            previousVC.tableView.reloadData()

            // now take me back to the previous view
            navigationController?.popViewController(animated: true)
        }
 */
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let toDo = ToDoCD(entity: ToDoCD.entity(), insertInto: context)
            
            if let titleText = titleTextField.text {
                toDo.name = titleText
                toDo.important = importantSwitch.isOn
            }
            
            try? context.save()
            
            navigationController?.popViewController(animated: true)
        }
        
    }
    
}
