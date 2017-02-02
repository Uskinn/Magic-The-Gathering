//
//  CardDetailViewController.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 2/1/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import UIKit


class CardDetailViewController: UIViewController {
    var cardModel: Card?
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardRarity: UILabel!
    @IBOutlet weak var cardText: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardName.text = cardModel?.cardName
        self.cardRarity.text = cardModel?.cardRarity
        self.artist.text = cardModel?.artist
        self.cardText.text = cardModel?.cardText
        self.cardImage.downloadImage(from: (cardModel?.imageUrl)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        
    }
}
