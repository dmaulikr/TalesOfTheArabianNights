//
//  MatrixNViewController.swift
//  TalesOfTheArabianNights
//
//  Created by Grace Thompson on 5/4/17.
//  Matrix N View Controller displays the Matrix N Encounters and the actions to choose from.
//

import UIKit

class MatrixNViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var matrixNPicker: UIPickerView!
    
    @IBOutlet weak var performActionButton: UIButton!
    
    let reactionMatrices = ReactionMatrices() //get matrix n reaction options 
    
    var encounterTypes: [String]! //holds the different possible encounters for matrix N
    var actionOptions: [String]! //holds the different action options
    
    let encounterComponent = 0 //first component holds the encounter types 
    let actionComponent = 1 //second component holds the action options
    
    var encounter: String! //will hold chosen encounter type
    var action: String! //will hold chosen action 
    let letterMatrix = "N" //Matrix N
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customize appearance of button 
        performActionButton.layer.borderWidth = 1.0
        performActionButton.layer.borderColor = UIColor.white.cgColor
        
        //customize appearance of picker
        matrixNPicker.layer.borderWidth = 2.0
        matrixNPicker.layer.borderColor = UIColor.orange.cgColor
        matrixNPicker.layer.cornerRadius = 3
        
        //get encounter and action array options
        encounterTypes = reactionMatrices.matrixNEncounters
        actionOptions = reactionMatrices.pickerReactions["N"]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "revealMatrixNResultSegue" {
            let revealResultViewController = segue.destination as? RevealResultViewController
            if let next = revealResultViewController {
                //pass encounter, action, and matrix letter 
                next.letterMatrix = letterMatrix
                next.adjective = encounter
                next.action = action
            }
        }
    }
    
    @IBAction func performActionPressed(_ sender: Any) {
        //get encounter type selected
        let encounterRow = matrixNPicker.selectedRow(inComponent: encounterComponent)
        encounter = encounterTypes[encounterRow]
        //get action type selected 
        let actionRow = matrixNPicker.selectedRow(inComponent: actionComponent)
        action = actionOptions[actionRow]
        
        print("Encounter: \(encounter!), Action: \(action!)")
        performSegue(withIdentifier: "revealMatrixNResultSegue", sender: self)
    }
    
    //Picker Delegate and Data Source Methods 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 //encounter and action in one picker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == encounterComponent {
            return encounterTypes.count
        } else {
            return actionOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        var rowTitle: String!
        label.adjustsFontSizeToFitWidth = true
        if component == encounterComponent {
            rowTitle = encounterTypes[row]
        } else {
            rowTitle = actionOptions[row]
        }
        let labelInfo = NSAttributedString(string: rowTitle as String, attributes: [NSFontAttributeName: UIFont(name: "Palatino", size: 16.0)!])
        
        label.attributedText = labelInfo
        label.textAlignment = NSTextAlignment.center
        
        return label
    }
    
  /*  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == encounterComponent {
            return encounterTypes[row]
        } else {
            return actionOptions[row]
        }
    } */
}
