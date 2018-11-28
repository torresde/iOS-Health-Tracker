//
//  SetRepsViewController.swift
//  Health Tracker
//
//  Created by Naveen Varadharaj on 11/27/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit

class SetRepsViewController: UIViewController {

    @IBOutlet var header: UILabel!
    @IBOutlet var finishButton: UIButton!
    
    var myString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.text = myString
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func finishButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "finishExercise", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let workoutViewController = segue.destination as! WorkoutViewController
        
        workoutViewController.exerciseLabel = myString
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
