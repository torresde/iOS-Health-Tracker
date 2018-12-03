//
//  WorkoutViewController.swift
//  Health Tracker
//
//  Created by David Torres on 11/6/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit
import CoreData

protocol resetTableData {
    func reloadTableData()
}

class WorkoutViewController: UIViewController, UITextFieldDelegate, resetTableData {

    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var editNameTextField: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var exerciseLogTableView: UITableView!
    @IBOutlet weak var addExerciseTextField: UITextField!
    
    
    var workoutName = ""
    var selectedWorkout : Workout? {
        didSet{
            workoutName = selectedWorkout!.workoutName!
            loadExercises()
        }
    }
    
    var myIndex = 0
    
    var exerciseArray = [Exercise]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setRepsSegue" {
            let destinationVC = segue.destination as! SetRepsViewController
            destinationVC.exerciseDelegate = self
            if let indexPath = exerciseLogTableView.indexPathForSelectedRow {
                destinationVC.selectedExercise = exerciseArray[indexPath.row]
            }
        }
    }
    
    func createNewExercise() {
        let newExercise = Exercise(context: context)
        newExercise.exerciseName = addExerciseTextField.text!
        newExercise.parentWorkout = selectedWorkout
        newExercise.workoutDate = selectedWorkout?.workoutDate
        newExercise.exerciseSets = 0
        exerciseArray.append(newExercise)
    }
    
    func reloadTableData() {
        exerciseLogTableView.reloadData()
    }
    
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func saveExercises() {
        
        do {
           try context.save()
        } catch {
            print("Error saving exercise \(error)")
        }
        
    }
    
    func loadExercises() {
        let request : NSFetchRequest<Exercise> = Exercise.fetchRequest()
        
        let namePredicate = NSPredicate(format: "parentWorkout.workoutName MATCHES %@", selectedWorkout!.workoutName!)
        
        request.predicate = namePredicate
        do {
            let everyExerciseArray = try context.fetch(request)
            for item in everyExerciseArray {
                if item.workoutDate == selectedWorkout?.workoutDate {
                    exerciseArray.append(item)
                }
            }
        } catch {
            print("Error loading exercises \(error)")
        }
        
    }
    
    func insertNewExercise() {
        createNewExercise()
        
        let indexPath = IndexPath(row: exerciseArray.count - 1, section: 0)
        
        saveExercises()
        
        exerciseLogTableView.beginUpdates()
        exerciseLogTableView.insertRows(at: [indexPath], with: .automatic)
        exerciseLogTableView.endUpdates()
        
        addExerciseTextField.text = ""
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseLogTableViewCell", for: indexPath) as! ExerciseLogTableViewCell
        
        cell.exerciseNameLabel.text = exerciseArray[indexPath.row].exerciseName
        
        if exerciseArray[indexPath.row].exerciseSets == 0 {
            cell.exerciseSetsLabel.text = "No sets"
        } else if exerciseArray[indexPath.row].exerciseSets == 1 {
            cell.exerciseSetsLabel.text = "1 set"
        } else {
            cell.exerciseSetsLabel.text = String(exerciseArray[indexPath.row].exerciseSets) + " sets"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context.delete(exerciseArray[indexPath.row])
            exerciseArray.remove(at: indexPath.row)
            
            saveExercises()
            
            exerciseLogTableView.beginUpdates()
            exerciseLogTableView.deleteRows(at: [indexPath], with: .automatic)
            exerciseLogTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "setRepsSegue", sender: self)
    }
    
}
