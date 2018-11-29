//
//  CompletedWorkoutViewController.swift
//  Health Tracker
//
//  Created by Naveen Varadharaj on 11/29/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit
import CoreData

class CompletedWorkoutViewController: UIViewController {

    @IBOutlet var workoutTableView: UITableView!
    
    var arr = GlobalVariables.workouts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        
        do {
            let workouts = try PersistenceServce.context.fetch(fetchRequest)
            arr = workouts
            print(arr)
            workoutTableView.reloadData()
        } catch {}
        
    }
    

}

extension CompletedWorkoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = arr[indexPath.row].name
        return cell
    }
    
    
}
