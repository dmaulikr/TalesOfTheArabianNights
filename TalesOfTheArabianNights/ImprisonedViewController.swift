//
//  ImprisonedViewController.swift
//  TalesOfTheArabianNights
//
//  Created by Grace Thompson on 5/4/17.
//  Copyright © 2017 Grace Thompson. All rights reserved.
//

import UIKit

class ImprisonedViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var jailerTypeLabel: UILabel!
    
    @IBOutlet weak var actionTypeLabel: UILabel!
    
    @IBOutlet weak var jailerPicker: UIPickerView!
    
    @IBOutlet weak var actionPicker: UIPickerView!
    
    @IBOutlet weak var attemptActionButton: UIButton!
    
    let reactionMatrices = ReactionMatrices()
    
    let jailerTypes: [String] = ["Friendly", "Foolish", "Ugly", "Crafty", "Mad", "Wicked"]
    var actionOptions: [String] = [] //initialize empty and fill in viewDidLoad
    
    var selectedJailerRow: Int!
    var jailer: String!
    
    var selectedActionRow: Int!
    var action: String!
    
    let letterMatrix = "K" //Jailer Matrix

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customize button appearance
        attemptActionButton.layer.borderWidth = 1.0
        attemptActionButton.layer.borderColor = UIColor.white.cgColor
        
        //customize picker appearance 
        jailerPicker.layer.borderWidth = 2.0
        jailerPicker.layer.borderColor = UIColor.orange.cgColor
        jailerPicker.layer.cornerRadius = 3
        
        actionPicker.layer.borderWidth = 2.0
        actionPicker.layer.borderColor = UIColor.orange.cgColor
        actionPicker.layer.cornerRadius = 3
        
        //Matrix K is for Imprisoned
        actionOptions = reactionMatrices.pickerReactions["K"]!
        
        jailerTypeLabel.text = "Roll a die to determine your jailer:"
        actionTypeLabel.text = "Select an action to attempt:"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "revealImprisonedResultSegue" {
            let revealResultViewController = segue.destination as? RevealResultViewController
            if let next = revealResultViewController {
                //pass action, adjective, and matrix letter
                next.letterMatrix = letterMatrix //K
                next.adjective = jailer
                next.action = action
            }
        }
    }
    
    @IBAction func attemptActionButtonPressed(_ sender: Any) {
        selectedJailerRow = jailerPicker.selectedRow(inComponent: 0)
        jailer = jailerTypes[selectedJailerRow]
        
        selectedActionRow = actionPicker.selectedRow(inComponent: 0)
        action = actionOptions[selectedActionRow]
        
        print("Jailer type: \(jailer!), Action: \(action!)")
        
        performSegue(withIdentifier: "revealImprisonedResultSegue", sender: self)
    }
    
    //picker data source methods 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == jailerPicker {
            return jailerTypes.count
        } else {
            return actionOptions.count
        }
    }
    
    //picker delegate method
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        var rowTitle: String!
        label.adjustsFontSizeToFitWidth = true
        
        if pickerView == jailerPicker {
            rowTitle = String(row + 1) + ". \(jailerTypes[row])"
        } else {
            rowTitle = actionOptions[row]
        }
        let labelInfo = NSAttributedString(string: rowTitle as String, attributes: [NSFontAttributeName: UIFont(name: "Palatino", size: 20.0)!])
        
        label.attributedText = labelInfo
        label.textAlignment = NSTextAlignment.center
        
        return label
    }
    
    //picker delegate method
   /* func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == jailerPicker {
            let jailerTitle = String(row + 1) + ". \(jailerTypes[row])"
            return jailerTitle
        } else {
            return actionOptions[row]
        }
    } */
}
