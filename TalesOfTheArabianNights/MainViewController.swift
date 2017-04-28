//
//  ViewController.swift
//  TalesOfTheArabianNights
//
//  Created by Grace Thompson on 4/24/17.
//  Copyright © 2017 Grace Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var userInputNumber: Int! //holds value of encounter entered by user 
    
    // Main Screen Objects 
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var companionAppLabel: UILabel!
    
    @IBOutlet weak var encounterNumberField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var imprisonedButton: UIButton!
    @IBOutlet weak var matrixNButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //handle text field's user input through delegate callbacks 
        encounterNumberField.delegate = self
        
        //customize buttons so they have a border around them 
        goButton.layer.borderColor = UIColor.white.cgColor //white around buttons 
        goButton.layer.borderWidth = 1.0
        imprisonedButton.layer.borderColor = UIColor.white.cgColor
        imprisonedButton.layer.borderWidth = 1.0
        matrixNButton.layer.borderColor = UIColor.white.cgColor
        matrixNButton.layer.borderWidth = 1.0
    }

    //close the number pad when touching outside of the pad 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        encounterNumberField.resignFirstResponder()
    }
    
    //set the userInputNumber if text field is not empty on exit
    func textFieldDidEndEditing(_ encounterNumberField: UITextField) {
        if let userValue = encounterNumberField.text, !userValue.isEmpty {
            userInputNumber = Int(userValue)
            print("user entered number ", userInputNumber)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dieRollSegue" {
            let dieRollViewController = segue.destination as? DieRollViewController
            if let next = dieRollViewController {
                next.encounterNumber = userInputNumber //pass the encounter number to the next view controller 
            }
        }
    }
    
    //function to check the valid encounter number 
    //returns true if valid, false if not
    func checkUserEncounterNumber(_ num: Int) -> Bool {
        let invalidValues = [89, 96, 103, 104, 111, 112]
        //if value is less than 1 or greater than 121
        if num < 1 || num > 121 {
            return false
        }
        //check against list of invalid numbers
        for val in invalidValues {
            if num == val {
                return false
            }
        }
        //if none of these apply, return true 
        return true
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        //if number pad is open, exit 
        encounterNumberField.resignFirstResponder()
        //check if the user entered a valid encounter number 
        if userInputNumber != nil {
            if checkUserEncounterNumber(userInputNumber) {
                print("Valid Encounter Number entered")
                performSegue(withIdentifier: "dieRollSegue", sender: self)
            } else {
                let error = UIAlertController(title: "Invalid Encounter Number", message: "You've entered an invalid encounter number. Please try again.", preferredStyle: .alert)
                let response = UIAlertAction(title: "OK", style: .default, handler: nil)
                error.addAction(response)
                error.view.tintColor = UIColor.black
                present(error, animated: true, completion: nil)
            }
        } else {
            let error = UIAlertController(title: "Missing Encounter Number", message: "Please enter an encounter number.", preferredStyle: .alert)
            let response = UIAlertAction(title: "OK", style: .default, handler: nil)
            error.addAction(response)
            error.view.tintColor = UIColor.black
            present(error, animated: true, completion: nil)
        }
        
    }
    
    
}



