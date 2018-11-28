//
//  SetExerciseName.swift
//  Health Tracker
//
//  Created by Naveen Varadharaj on 11/25/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit

class SetExerciseName: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendExerciseForward", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setRepsController = segue.destination as! SetRepsViewController
        
        setRepsController.myString = textField.text!
        
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
