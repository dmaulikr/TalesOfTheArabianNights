//
//  EncounterReactionViewController.swift
//  TalesOfTheArabianNights
//
//  Created by Grace Thompson on 4/27/17.
//  Copyright © 2017 Grace Thompson. All rights reserved.
//

import UIKit

class EncounterReactionViewController: UIViewController {
    
    var encounterNumber: Int? //keeps track of encounter number 
    var dieRoll: Int? //keeps track of die roll 
    
    var adjective: String!
    var encounteredEvent: String!
    var reactionMatrix: String!
    
    //array of strings to hold the encounter
    var list: [String] = [] //initialize empty
    
    @IBOutlet weak var encounterLabel: UILabel!
    
    @IBOutlet weak var reactionPicker: UIPickerView!
    
    @IBOutlet weak var performActionbutton: UIButton!
    
    //access Random Encounters file 
    let randomEncounters = RandomEncounters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customize perform action button 
        performActionbutton.layer.borderColor = UIColor.white.cgColor
        performActionbutton.layer.borderWidth = 1.0
        
        //retrieve and set encounter number
        if let receivedEncounterNumber = encounterNumber, let receivedDieRoll = dieRoll {
            encounterLabel.text = "Current Encounter #: " + String(receivedEncounterNumber)
            
            //determine if character or event type of encounter
            if receivedEncounterNumber < 84 {
                list = randomEncounters.getRandomEncounter(receivedEncounterNumber, dieRoll: receivedDieRoll)
            } else {
                list = randomEncounters.getCharacterEncounter(receivedEncounterNumber, dieRoll: receivedDieRoll)
            }
            displayEncounter(list) //display the encounter to the screen
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
        if encounteredEvent.hasSuffix("s") {
            encounterLabel.self.text = "You've encountered \(adjective!) \(encounteredEvent!)! See Reaction Matrix \(reactionMatrix!)"
        } else if let letter = adjective?[adjective.startIndex] {
            if letter == "A" || letter == "E" || letter == "I" || letter == "O" || letter == "U" {
                encounterLabel.self.text = "You've encountered an \(adjective!) \(encounteredEvent!)! See Reaction Matrix \(reactionMatrix!)"
            } else {
                encounterLabel.self.text = "You've encountered a \(adjective!) \(encounteredEvent!)! See Reaction Matrix \(reactionMatrix)"

            }
        }

    }
    
    @IBAction func performActionPressed(_ sender: Any) {
    }
    
}
