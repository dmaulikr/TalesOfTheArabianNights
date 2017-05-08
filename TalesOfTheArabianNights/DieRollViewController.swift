//
//  DieRollViewController.swift
//  TalesOfTheArabianNights
//
//  Created by Grace Thompson on 4/25/17.
//  Copyright © 2017 Grace Thompson. All rights reserved.
//

import UIKit

class DieRollViewController: UIViewController, UITextFieldDelegate {
    
    var dieRoll: Int! //die roll + modifiers
    
    var encounterNumber: Int?
    
    @IBOutlet weak var encounterNumLabel: UILabel!
    
    @IBOutlet weak var dieRollTextField: UITextField!
    
    @IBOutlet weak var revealEncounterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //handle text field's user input through delegate callbacks 
        dieRollTextField.delegate = self
        
        //customize reveal encounter button 
        revealEncounterButton.layer.borderColor = UIColor.white.cgColor
        revealEncounterButton.layer.borderWidth = 1.0
        //retrieve and set encounter number 
        if let receivedNumber = encounterNumber {
            encounterNumLabel.text = "Current Encounter #: " + String(receivedNumber)
        }
    }
    
    //close the number pad when touching outside of the pad
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dieRollTextField.resignFirstResponder()
    }
    
    //set the userDieRoll if text field is not empty on exit 
    func textFieldDidEndEditing(_ dieRollTextField: UITextField) {
        if let userValue = dieRollTextField.text, !userValue.isEmpty {
            dieRoll = Int(userValue)
            print("user entered die roll ", dieRoll)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "revealEncounterSegue" {
            let encounterReactionViewController = segue.destination as? EncounterReactionViewController
            if let next = encounterReactionViewController {
                //pass encounter number and die roll result to next view for processing 
                next.encounterNumber = encounterNumber
                next.dieRoll = dieRoll
            }
        }
    }
    
    //function to check that die roll is greater than 0, if greater than 12, set as 12 
    func checkDieRoll(_ num: Int) -> Bool {
        if num < 1 {
            return false //minimum value is 1
        }
        return true
    }
    
    @IBAction func revealEncounterPressed(_ sender: Any) {
        //if number pad is open, exit 
        dieRollTextField.resignFirstResponder()
        
        //check for valid die roll
        //check if number greater than 12, set to 12 
        if dieRoll != nil {
            if dieRoll > 12 {
                dieRoll = 12
            }
            if checkDieRoll(dieRoll) {
                print("Valid Die Roll entered: ", dieRoll)
                //perform segue to encounter results 
                performSegue(withIdentifier: "revealEncounterSegue", sender: self)
            } else {
                let error = UIAlertController(title: "Invalid Die Roll", message: "You've entered an invalid die roll result. Please try again.", preferredStyle: .alert)
                let response = UIAlertAction(title: "OK", style: .default, handler: nil)
                error.addAction(response)
                error.view.tintColor = UIColor.black
                present(error, animated: true, completion: nil)
            }
        } else {
            //error, need to enter a die roll 
            let error = UIAlertController(title: "Mising Die Roll", message: "Please enter your die roll result.", preferredStyle: .alert)
            let response = UIAlertAction(title: "OK", style: .default, handler: nil)
            error.addAction(response)
            error.view.tintColor = UIColor.black
            present(error, animated: true, completion: nil)
        }
        
    }
    
    
}
