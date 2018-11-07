//
//  NameViewController.swift
//  Health Tracker
//
//  Created by David Torres on 11/6/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//

import UIKit

class NameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isUserInteractionEnabled = false
        nextButton.alpha = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if enterNameTextField.text == "" {
            return
        }
        
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
        enterNameTextField.resignFirstResponder()
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
