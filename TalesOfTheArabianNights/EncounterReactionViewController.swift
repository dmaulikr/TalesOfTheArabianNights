//
//  EncounterReactionViewController.swift
//  TalesOfTheArabianNights
//
//  Created by Grace Thompson on 4/27/17.
//  Copyright © 2017 Grace Thompson. All rights reserved.
//

import UIKit

class EncounterReactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var encounterNumber: Int? //keeps track of encounter number 
    var dieRoll: Int? //keeps track of die roll 
    
    var adjective: String!
    var encounteredEvent: String!
    var reactionMatrix: String!
    
    //array of strings to hold the encounter
    var list: [String] = [] //initialize empty
    
    var reactionPickerList: [String] = [] //initialize empty
    
    var selectedRow: Int? //row in picker that is selected by user 
    var action: String? //chosen action by user
    
    @IBOutlet weak var encounterLabel: UILabel!
    
    //@IBOutlet weak var reactionMatrixLabel: UILabel!
    
    @IBOutlet weak var reactionPicker: UIPickerView!
    
    @IBOutlet weak var performActionbutton: UIButton!
    
    @IBOutlet weak var encounterNumLabel: UILabel!
    
    
    //access Random Encounters file 
    let randomEncounters = RandomEncounters()
    //access Reaction Matrices file 
    let reactionMatrices = ReactionMatrices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customize perform action button 
        performActionbutton.layer.borderColor = UIColor.white.cgColor
        performActionbutton.layer.borderWidth = 1.0
        
        //customize picker
        reactionPicker.layer.borderWidth = 2.0
        reactionPicker.layer.borderColor = UIColor.orange.cgColor
        reactionPicker.layer.cornerRadius = 3
        
        //retrieve and set encounter number
        if let receivedEncounterNumber = encounterNumber, let receivedDieRoll = dieRoll {
            encounterNumLabel.text = "Current Encounter #: " + String(receivedEncounterNumber)
            
            //determine if character or event type of encounter
            if receivedEncounterNumber < 84 {
                list = randomEncounters.getRandomEncounter(receivedEncounterNumber, dieRoll: receivedDieRoll)
            } else {
                list = randomEncounters.getCharacterEncounter(receivedEncounterNumber, dieRoll: receivedDieRoll)
            }
            displayEncounter(list) //display the encounter to the screen
            //get picker options to display according to reaction matrix 
            reactionPickerList = reactionMatrices.pickerReactions[reactionMatrix]!
            
        } else {
            print("Error receiving encounter number and die roll from DieRollViewController")
        }
        
    }
    
    //function to formulate and display the encounter 
    func displayEncounter(_ list: [String]) {
        for _ in list {
            adjective = list[0]
            encounteredEvent = list[1]
            reactionMatrix = list[2]
        }
        
        //check for plurality or a/an article specifics
        //check if last two letters are both s, such as 'enchantress'
        let last2 = encounteredEvent.substring(from: encounteredEvent.index(encounteredEvent.endIndex, offsetBy: -2))
        if encounteredEvent.hasSuffix("s"), last2 != "ss" {
            encounterLabel.self.text = "You've encountered \(adjective!) \(encounteredEvent!)!"
        } else if let letter = adjective?[adjective.startIndex] {
            if letter == "A" || letter == "E" || letter == "I" || letter == "O" || letter == "U" {
                encounterLabel.self.text = "You've encountered an \(adjective!) \(encounteredEvent!)!"
            } else {
                encounterLabel.self.text = "You've encountered a \(adjective!) \(encounteredEvent!)!"

            }
        }
        
        //reactionMatrixLabel.self.text = "See Reaction Matrix \(reactionMatrix!) below"

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "revealResultSegue" {
            let revealResultViewController = segue.destination as? RevealResultViewController
            if let next = revealResultViewController {
                //pass action chosen, adjective and letter of matrix to refer to 
                next.action = action
                next.adjective = adjective
                next.letterMatrix = reactionMatrix
            }
        }
    }
    
    @IBAction func performActionPressed(_ sender: Any) {
        selectedRow = reactionPicker.selectedRow(inComponent: 0)
        action = reactionPickerList[selectedRow!]
        
        print("You've selected to \(action)!")
        
        performSegue(withIdentifier: "revealResultSegue", sender: self)
    }
    
    //PIcker Data Source Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reactionPickerList.count
    }
    
    //Picker Delegate Methods 
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        let rowTitle = reactionPickerList[row]
        label.adjustsFontSizeToFitWidth = true
        let labelInfo = NSAttributedString(string: rowTitle as String, attributes: [NSFontAttributeName: UIFont(name: "Palatino", size: 20.0)!])
        
        label.attributedText = labelInfo
        label.textAlignment = NSTextAlignment.center
        
        return label
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reactionPickerList[row]
    }
    
}
