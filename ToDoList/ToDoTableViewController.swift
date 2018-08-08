//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Christie Lynam on 8/7/18.
//  Copyright © 2018 Christie Lynam. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var toDos : [ToDoCD] = []

    override func viewDidLoad() {
        super.viewDidLoad()

//        toDos = createToDos()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTodos()
    }
    
    func getTodos() {
        // we need to access CoreData
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            // go get all the toDo objects out of CoreData and bring them back as an array of CoreData objects
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                if let theToDos = coreDataToDos {
                    toDos = theToDos
                    tableView.reloadData()
                }
            }
        }
    }
    
//    func createToDos() -> [ToDo] {
//        
//        let swift = ToDo()
//        swift.name = "Learn Swift"
//        swift.important = true
//        
//        let dog = ToDo()
//        dog.name = "Walk the Dog"
//        // important default set to false
//        
//        return [swift, dog]
//    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let toDo = toDos[indexPath.row]
        // this gives us a single todo
        
        if let name = toDo.name {
            if toDo.important {
                cell.textLabel?.text = "❗️" + name
            } else {
                cell.textLabel?.text = toDo.name
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // this is how we select and individual todo
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.previousVC = self
        }
        
        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
        
    }

}
