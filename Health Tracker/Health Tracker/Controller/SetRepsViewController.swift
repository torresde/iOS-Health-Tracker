//
//  SetRepsViewController.swift
//  Health Tracker
//
//  Created by Naveen Varadharaj on 11/28/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit

class SetRepsViewController: UIViewController {

    
    var sets: [String] = []
    @IBOutlet var exerciseName: UILabel!
    @IBOutlet var finishButton: UIButton!
    @IBOutlet var setRepsTableView: UITableView!
    @IBOutlet var repsField: UITextField!
    @IBOutlet var weightField: UITextField!
    @IBOutlet var addSetButton: UIButton!
    
    var exerciseNameText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRepsTableView.delegate = self
        setRepsTableView.dataSource = self
        
        exerciseName.text = exerciseNameText
        setRepsTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func finishButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "finishExerciseSegue", sender: self)
    }
    
    @IBAction func addSetPressed(_ sender: Any) {
        insertNewCell()
    }
    
    func insertNewCell() {
        sets.append("REPS: " + String(repsField.text!) + "     WEIGHT: " + String(weightField.text!) + "lbs")
        let indexPath = IndexPath(row: sets.count - 1, section: 0)
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
        return sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setsTableViewCell")! as UITableViewCell

        cell.textLabel?.text = sets[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            sets.remove(at: indexPath.row)
            
            setRepsTableView.beginUpdates()
            setRepsTableView.deleteRows(at: [indexPath], with: .automatic)
            setRepsTableView.endUpdates()
        }
    }
    
}
