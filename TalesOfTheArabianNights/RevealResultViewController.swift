//
//  RevealResultViewController.swift
//  TalesOfTheArabianNights
//
//  Created by Grace Thompson on 5/4/17.
//  Reveal Result View Controller displays the paragraph results based on destiny die result, showing all three 
//  in the case that the player has master level talents to use
//

import UIKit

class RevealResultViewController: UIViewController {
    
    var action: String? //holds action user chose 
    
    var letterMatrix: String? //Letter of Matrix to access 
    var adjective: String? //Adjective List in Matrix with Action/Paragraph pairs 
    
    var paragraphNumber: Int? //Paragraph Number result 
    
    @IBOutlet weak var chosenActionLabel: UILabel!
    
    @IBOutlet weak var paragraphResultLabel: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var minusResultLabel: UILabel!
    
    @IBOutlet weak var blankResultLabel: UILabel!
    
    @IBOutlet weak var plusResultLabel: UILabel!
    
    @IBOutlet weak var minusLabel: UILabel!
    
    @IBOutlet weak var blankLabel: UILabel!
    
    @IBOutlet weak var plusLabel: UILabel!
    
    //access Reaction Matrices file
    let reactionMatrices = ReactionMatrices()
    
    override func viewDidLoad() {
        //customize return button 
        returnButton.layer.borderColor = UIColor.white.cgColor
        returnButton.layer.borderWidth = 1.0
        
        //customize destiny die labels 
        minusLabel.layer.borderWidth = 3.0
        minusLabel.layer.borderColor = UIColor.orange.cgColor
        blankLabel.layer.borderWidth = 3.0
        blankLabel.layer.borderColor = UIColor.orange.cgColor
        plusLabel.layer.borderWidth = 3.0
        plusLabel.layer.borderColor = UIColor.orange.cgColor
        
        //retrieve paragraph number of result 
        if let receivedAdj = adjective, let receivedLetter = letterMatrix, let receivedAction = action {
            //set action chosen in label text
            chosenActionLabel.text = "You've chosen to \(receivedAction)!"

            print("based on adjective \(receivedAdj) and letter matrix \(receivedLetter)")
            
            //get matrix of received letter 
            let matrix = reactionMatrices.matrices[receivedLetter]?[receivedAdj]
            paragraphNumber = matrix?[receivedAction]
            paragraphResultLabel.text = "Roll the destiny die to look up the result in the Book of Tales."
            //paragraph number can't go below 184 
            if paragraphNumber == 184 {
                minusResultLabel.text = "See Paragraph \(paragraphNumber!)"
            } else {
                minusResultLabel.text = "See Paragraph \(paragraphNumber! - 1)"
            }
            blankResultLabel.text = "See Paragraph \(paragraphNumber!)"
            //paragraph number can't exceed 2600
            if paragraphNumber == 2600 {
                plusResultLabel.text = "See Paragraph \(paragraphNumber!)"
            } else {
                plusResultLabel.text = "See Paragraph \(paragraphNumber! + 1)"
            }
        }
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        //go back to main page 
        performSegue(withIdentifier: "toMainSegue", sender: self)
    }
    
}
