//
//  SetRepsViewController.swift
//  Health Tracker
//
//  Created by Naveen Varadharaj on 11/28/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit
import CoreData

class SetRepsViewController: UIViewController {

    @IBOutlet var exerciseName: UILabel!
    @IBOutlet weak var setsTableView: UITableView!
    @IBOutlet weak var repsInputTextField: UITextField!
    @IBOutlet weak var weightInputTextField: UITextField!
    @IBOutlet weak var addSetButton: UIButton!
    
    var setsArray = [Set]()
    var exerciseDelegate: resetTableData?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedExercise : Exercise? {
        didSet{
            loadSets()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseName.text = selectedExercise?.exerciseName
        
        setsTableView.delegate = self
        setsTableView.dataSource = self
        setsTableView.register(UINib(nibName: "SetsLogTableViewCell", bundle: nil), forCellReuseIdentifier: "setsLogTableViewCell")
    }
    
    func saveSets() {
        
        do {
            try context.save()
        } catch {
            print("Error saving exercise \(error)")
        }
        
    }
    
    func loadSets() {
        let request : NSFetchRequest<Set> = Set.fetchRequest()
        
        let predicate = NSPredicate(format: "parentExercise.exerciseName MATCHES %@", selectedExercise!.exerciseName!)

        request.predicate = predicate
        do {
            let everySetArray = try context.fetch(request)
            for item in everySetArray {
                if item.exerciseDate == selectedExercise?.exerciseDate {
                    setsArray.append(item)
                }
            }
        } catch {
            print("Error loading exercises \(error)")
        }
        
    }
    
    @IBAction func BackButtonPressed(_ sender: Any) {
        self.exerciseDelegate?.reloadTableData()
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addSetButtonPressed(_ sender: Any) {
        insertNewCell()
    }
    
    func insertNewCell() {
        let newSet = Set(context: context)
        newSet.reps = repsInputTextField.text!
        newSet.weight = weightInputTextField.text!
        newSet.parentExercise = selectedExercise
        newSet.exerciseDate = selectedExercise?.exerciseDate
        selectedExercise?.exerciseSets += 1
        setsArray.append(newSet)
        let indexPath = IndexPath(row: setsArray.count - 1, section: 0)
        
        saveSets()
        
        setsTableView.beginUpdates()
        setsTableView.insertRows(at: [indexPath], with: .automatic)
        setsTableView.endUpdates()
        
        repsInputTextField.text = ""
        weightInputTextField.text = ""
        view.endEditing(true)
    }
    
}

extension SetRepsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setsLogTableViewCell", for: indexPath) as! SetsLogTableViewCell
        
        cell.setsNumberLabel.text = "Set " + String(indexPath.row + 1) + ":"
        cell.repsTextField.text = setsArray[indexPath.row].reps!
        cell.weightTextField.text = setsArray[indexPath.row].weight!
        cell.lastTimeLabel.text = "Last time: 8 reps of 20"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context.delete(setsArray[indexPath.row])
            setsArray.remove(at: indexPath.row)
            selectedExercise?.exerciseSets -= 1
            
            saveSets()
            
            setsTableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
