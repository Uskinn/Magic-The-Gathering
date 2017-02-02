//
//  CardDetailViewController.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 2/1/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardRarity: UILabel!
    @IBOutlet weak var cardText: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    var cardModel: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cardName.text = cardModel?.cardName
        self.cardRarity.text = cardModel?.cardRarity
        self.artist.text = cardModel?.artist
        self.cardText.text = cardModel?.cardText
        
       // self.cardImage.image =
            //cardImageView.downloadImage(from: (self.cards[indexPath.item].imageUrl)!)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func favoriteButton(_ sender: Any) {
        
    }
}
