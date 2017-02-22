//
//  CardViewController.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 1/31/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import UIKit
import CoreData

class CardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        
        TheGatheringApi.getCardWith { results in
            guard let searchCard = results["cards"] as? [[String : Any]] else {return}
            for card in searchCard {
                let newCard = Card(details: card)
                self.cards.append(newCard)
            }
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        if cell.delegate == nil {
            cell.delegate = self
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 9
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cardCell = cell as! CardCollectionViewCell
        let card = cards[indexPath.item]
        cardCell.card = card
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCardDetail" {
            if let indexPaths = self.myCollectionView.indexPathsForSelectedItems {
                let indexPath = indexPaths[0]
                let destinationVC = segue.destination as! CardDetailViewController
                destinationVC.cardModel = self.cards[indexPath.row]
                print("cardViewController called")
            } else {
                print("error occured")
            }
        }
    }
}

extension CardViewController: CardCellDelegate {
    
    func canUpdateImage(sender: Card) -> Bool {
        let visibleCells = myCollectionView.visibleCells as! [CardCollectionViewCell]
        for cell in visibleCells {
            if cell.card == sender {
                return true
            }
        }
        return false
    }
}


