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
var isFavorButtunChecked = false

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
        self.cardImage.downloadImage(from: (cardModel?.imageUrl)!)
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        if !isFavorButtunChecked {
            favoriteButton.image = favorImage.filledFavoriteImage
        }
        let newCard = CardEntity(context: CoreDataFile.getContext())
        newCard.cardName = self.cardName.text
        newCard.cardArtist = self.artist.text
        newCard.cardRarity = self.cardRarity.text
        newCard.cardImage = UIImagePNGRepresentation(self.cardImage.image!) as NSData?

        CoreDataFile.saveContext()
    }
}
