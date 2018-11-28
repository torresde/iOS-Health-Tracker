//
//  WorkoutViewController.swift
//  Health Tracker
//
//  Created by David Torres on 11/6/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var exercises = [String]()
    
    var exerciseLabel = String()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addNewExercise", sender: self)
        insertNewRow()
    }
    
    func insertNewRow() {
        exercises.append(exerciseLabel)
        
        let indexPath = IndexPath(row: exerciseLabel.count - 1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        exerciseLabel = ""
        
        
    }
    
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    var workoutName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutNameLabel.text = workoutName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    
    
}
