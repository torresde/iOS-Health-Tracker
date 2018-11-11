//
//  NameViewController.swift
//  Health Tracker
//
//  Created by David Torres on 11/6/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit

class SetNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterNameTextField.delegate = self
        nextButton.isUserInteractionEnabled = false
        nextButton.alpha = 0.5
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendNameForward", sender: self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let nameText: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if nameText.isEmpty == true {
            nextButton.isUserInteractionEnabled = false
            nextButton.alpha = 0.5
        } else {
            nextButton.isUserInteractionEnabled = true
            nextButton.alpha = 1.0
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendNameForward" {
            let secondVC = segue.destination as! WorkoutViewController
            secondVC.workoutName = enterNameTextField.text!
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
