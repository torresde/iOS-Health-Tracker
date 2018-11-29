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
    
    var workoutName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editNameTextField.delegate = self
        workoutNameLabel.text = workoutName
        editNameTextField.text = workoutName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
