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
    @IBOutlet var setRepsTableView: UITableView!
    @IBOutlet var repsField: UITextField!
    @IBOutlet var weightField: UITextField!
    @IBOutlet var addSetButton: UIButton!
    
    var setsArray = [Set]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedExercise : Exercise? {
        didSet{
            loadSets()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRepsTableView.delegate = self
        setRepsTableView.dataSource = self
        
        exerciseName.text = selectedExercise?.exerciseName
        setRepsTableView.tableFooterView = UIView(frame: CGRect.zero)
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
            setsArray = try context.fetch(request)
        } catch {
            print("Error loading exercises \(error)")
        }
        
    }
    
    @IBAction func BackButtonPressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addSetPressed(_ sender: Any) {
        insertNewCell()
    }
    
    func insertNewCell() {
        let newSet = Set(context: context)
        newSet.reps = repsField.text!
        newSet.weight = weightField.text!
        newSet.parentExercise = selectedExercise
        setsArray.append(newSet)
        let indexPath = IndexPath(row: setsArray.count - 1, section: 0)
        
        saveSets()
        
        setRepsTableView.beginUpdates()
        setRepsTableView.insertRows(at: [indexPath], with: .automatic)
        setRepsTableView.endUpdates()
        
        repsField.text = ""
        weightField.text = ""
        view.endEditing(true)
    }
    
}

extension SetRepsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setsTableViewCell")! as UITableViewCell

        cell.textLabel?.text = "REPS: " + setsArray[indexPath.row].reps! + "     WEIGHT: " + setsArray[indexPath.row].weight! + " lbs"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context.delete(setsArray[indexPath.row])
            setsArray.remove(at: indexPath.row)
            
            saveSets()
            
            setRepsTableView.beginUpdates()
            setRepsTableView.deleteRows(at: [indexPath], with: .automatic)
            setRepsTableView.endUpdates()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
