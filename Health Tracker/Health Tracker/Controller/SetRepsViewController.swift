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
    var prevSetsArray = [Set]()
    var exerciseDelegate: resetTableData?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedExercise : Exercise? {
        didSet{
            loadSets()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repsInputTextField.keyboardType = UIKeyboardType.numberPad
        weightInputTextField.keyboardType = UIKeyboardType.numberPad
        
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
    
    func filterSets(everySetArray: [Set]) {
        var tmpPrevSets = [Set]()
        
        for item in everySetArray {
            if let exerciseDate = item.exerciseDate {
                if exerciseDate == selectedExercise?.exerciseDate {
                    setsArray.append(item)
                } else if exerciseDate < (selectedExercise?.exerciseDate)! && tmpPrevSets.isEmpty {
                    tmpPrevSets.append(item)
                } else if exerciseDate < (selectedExercise?.exerciseDate)! && !tmpPrevSets.isEmpty {
                    if exerciseDate > tmpPrevSets[0].exerciseDate! {
                        tmpPrevSets.removeAll()
                        tmpPrevSets.append(item)
                    } else if exerciseDate == tmpPrevSets[0].exerciseDate! {
                        tmpPrevSets.append(item)
                    }
                }
            }
        }
        
        if !tmpPrevSets.isEmpty {
            for prevSet in tmpPrevSets.sorted(by: {($0.setDate!).compare($1.setDate!) == .orderedAscending}) {
                let newPrevSet = createNewSet(repsInput: prevSet.reps!, weightInput: prevSet.weight!)
                prevSetsArray.append(newPrevSet)
            }
        }
    }
    
    func loadSets() {
        let request : NSFetchRequest<Set> = Set.fetchRequest()
        
        let predicate = NSPredicate(format: "parentExercise.exerciseName MATCHES %@", selectedExercise!.exerciseName!)

        request.predicate = predicate
        do {
            let everySetArray = try context.fetch(request)
            filterSets(everySetArray: everySetArray)
        } catch {
            print("Error loading exercises \(error)")
        }
        
    }
    
    @IBAction func BackButtonPressed(_ sender: Any) {
        self.exerciseDelegate?.reloadTableData()
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addSetButtonPressed(_ sender: Any) {
        repsInputTextField.text = String(repsInputTextField.text!)
        weightInputTextField.text = String(weightInputTextField.text!)
        
        
        insertNewCell()
    }
    
    func createNewSet(repsInput: String, weightInput: String) -> Set {
        let newSet = Set(context: context)
        newSet.reps = repsInput
        newSet.weight = weightInput
        return newSet
    }
    
    func insertNewCell() {
        let newSet = createNewSet(repsInput: repsInputTextField.text!, weightInput: weightInputTextField.text!)
        newSet.parentExercise = selectedExercise
        newSet.exerciseDate = selectedExercise?.exerciseDate
        newSet.setDate = Date()
        
        selectedExercise?.exerciseSets += 1
        setsArray.append(newSet)
        
        saveSets()
        
        setsTableView.reloadData()
        repsInputTextField.text = ""
        weightInputTextField.text = ""
        view.endEditing(true)
    }
    
}

extension SetRepsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setsArray.count < prevSetsArray.count ? prevSetsArray.count : setsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setsLogTableViewCell", for: indexPath) as! SetsLogTableViewCell
        cell.setsNumberLabel.text = "Set " + String(indexPath.row + 1) + ":"
        
        if indexPath.row < setsArray.count {
            cell.repsTextField.text = setsArray[indexPath.row].reps!
            cell.weightTextField.text = setsArray[indexPath.row].weight!
        } else {
            cell.repsTextField.text = ""
            cell.weightTextField.text = ""
        }
        
        if indexPath.row < prevSetsArray.count {
            cell.lastTimeLabel.text = "Last time: "
                + prevSetsArray[indexPath.row].reps! + " reps of "
                + prevSetsArray[indexPath.row].weight! + " lbs"
        } else {
            cell.lastTimeLabel.text = ""
        }
        
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
