//
//  CardDetailViewController.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 2/1/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import UIKit
import CoreData

var favorImage = Image()
var isFavorButtonChecked = false

class CardDetailViewController: UIViewController {
    
    var cardModel: Card?
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardRarity: UILabel!
    @IBOutlet weak var cardText: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardName.text = cardModel?.cardName
        self.cardRarity.text = cardModel?.cardRarity
        self.artist.text = cardModel?.artist
        self.cardText.text = cardModel?.cardText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.cardRarity.text == "Rare" && !isFavorButtonChecked {
            print("card detail viewWllAppear called")
            callAlert()
        }
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        if !isFavorButtonChecked {
            favoriteButton.image = favorImage.filledFavoriteImage
            self.saveToCoreData()
        }
        
    }
    
    func callAlert() {
        // Declaring alertController
        let alertController = UIAlertController(title: "Hoorray!", message: "You find a really rare card. Do you wonna save it?", preferredStyle: .alert)
        // Creating actions
        let okAction = UIAlertAction(title: "Sure!", style: .default) { (action : UIAlertAction) in
            self.saveToCoreData()
            self.favoriteButton.image = favorImage.filledFavoriteImage
        }
        
        let cancelAction = UIAlertAction(title: "I don't care", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Presenting alertController
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveToCoreData() {
        let newCard = CardEntity(context: CoreDataFile.getContext())
        newCard.cardName = self.cardName.text
        newCard.cardArtist = self.artist.text
        newCard.cardRarity = self.cardRarity.text
        newCard.cardImage = UIImagePNGRepresentation(self.cardImage.image!) as NSData?
        
        CoreDataFile.saveContext()
    }
}


















