//
//  WorkoutViewController.swift
//  Health Tracker
//
//  Created by David Torres on 11/6/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var editNameTextField: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var exerciseLogTableView: UITableView!
    @IBOutlet weak var addExerciseTextField: UITextField!
    
    var workoutName = ""
    var titleArray: [String] = ["Bench Press", "Squat", "Deadlift"]
    var subtitleArray: [String] = ["3 sets", "4 sets", "2 sets"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        workoutNameLabel.text = workoutName
        editNameTextField.delegate = self
        editNameTextField.text = workoutName
        
        exerciseLogTableView.delegate = self
        exerciseLogTableView.dataSource = self
        exerciseLogTableView.register(UINib(nibName: "ExerciseLogTableViewCell", bundle: nil), forCellReuseIdentifier: "exerciseLogTableViewCell")
    }
    
    @IBAction func addExerciseButtonTapped(_ sender: UIButton) {
        insertNewExercise()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let nameText: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if nameText.isEmpty == true {
            finishButton.isUserInteractionEnabled = false
            finishButton.alpha = 0.5
        } else {
            finishButton.isUserInteractionEnabled = true
            finishButton.alpha = 1.0
        }
        
        workoutNameLabel.text = nameText
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func insertNewExercise() {
        titleArray.append(addExerciseTextField.text!)
        let indexPath = IndexPath(row: titleArray.count - 1, section: 0)
        
        exerciseLogTableView.beginUpdates()
        exerciseLogTableView.insertRows(at: [indexPath], with: .automatic)
        exerciseLogTableView.endUpdates()
        
        addExerciseTextField.text = ""
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseLogTableViewCell", for: indexPath) as! ExerciseLogTableViewCell
        
        cell.exerciseNameLabel.text = titleArray[indexPath.row]
        cell.exerciseSetsLabel.text = "2 sets"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            titleArray.remove(at: indexPath.row)
            
            exerciseLogTableView.beginUpdates()
            exerciseLogTableView.deleteRows(at: [indexPath], with: .automatic)
            exerciseLogTableView.endUpdates()
        }
    }
    
}
