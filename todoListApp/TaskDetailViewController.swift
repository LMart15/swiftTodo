//
//  TaskDetailViewController.swift
//  todoListApp
//
//  Created by Lawrence Martin on 2017-02-20.
//  Copyright © 2017 mapd.centennial. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TaskDetailViewController: UIViewController {
    
    var currentTask:Task!
    var currentIndex: Int!
    var dbRef:FIRDatabaseReference!
    
    @IBOutlet weak var name_tv: UITextView!
    @IBOutlet weak var notes_tv: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference().child("tasks-data")
        
        name_tv.text = currentTask.name
        notes_tv.text = currentTask.note
        
    }
    @IBAction func updateTask(_ sender: UIBarButtonItem) {
        
        if name_tv.text!.isEmpty || notes_tv.text!.isEmpty {
            showAlert()
        }
        else{
    
        dbRef.child(currentTask.key).updateChildValues(["name" : name_tv.text, "note": notes_tv.text])
        
        //navigate back to task list
        navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func deleteTask(_ sender: UIBarButtonItem) {
        
        dbRef.child(currentTask.key).removeValue()
        
        //navigate back to task list
        navigationController?.popViewController(animated: true)
        
    }
    
    func showAlert(){
        
        let alert = UIAlertController(title: "Task", message: "Task must have Name and Note", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
