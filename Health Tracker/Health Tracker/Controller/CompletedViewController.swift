//
//  CompletedViewController.swift
//  Health Tracker
//
//  Created by David Torres on 11/29/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit
import CoreData

class CompletedViewController: UIViewController {

    @IBOutlet weak var workoutLogTableView: UITableView!
    
    var workoutArray = [Workout]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        workoutLogTableView.delegate = self
        workoutLogTableView.dataSource = self
        workoutLogTableView.register(UINib(nibName: "CompletedTableViewCell", bundle: nil), forCellReuseIdentifier: "completedTableViewCell")
        loadExercises()
    }

    func loadExercises() {
        let request : NSFetchRequest<Workout> = Workout.fetchRequest()

        do {
            workoutArray = try context.fetch(request)
        } catch {
            print("Error loading workouts \(error)")
        }
    }
    
    func saveWorkouts() {
        do {
            try context.save()
        } catch {
            print("Error saving exercise \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "completedToWorkout" {
            let destinationVC = segue.destination as! WorkoutViewController
            if let indexPath = workoutLogTableView.indexPathForSelectedRow {
                destinationVC.selectedWorkout = workoutArray[indexPath.row]
            }
        }
    }

}

extension CompletedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "completedTableViewCell", for: indexPath) as! CompletedTableViewCell
        
        cell.workoutNameLabel.text = workoutArray[indexPath.row].workoutName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        if let date = workoutArray[indexPath.row].workoutDate {
            cell.workoutDateLabel.text = formatter.string(from: date)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "completedToWorkout", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context.delete(workoutArray[indexPath.row])
            workoutArray.remove(at: indexPath.row)
            
            saveWorkouts()
            
            workoutLogTableView.beginUpdates()
            workoutLogTableView.deleteRows(at: [indexPath], with: .automatic)
            workoutLogTableView.endUpdates()
        }
    }
    
}
