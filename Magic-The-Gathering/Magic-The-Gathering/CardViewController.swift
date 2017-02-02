//
//  CardViewController.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 1/31/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import UIKit

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
            OperationQueue.main.addOperation {
                self.myCollectionView.reloadData()
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        cell.cardImageView.downloadImage(from: (self.cards[indexPath.item].imageUrl)!)
        
        
        // set round corners to cells
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 9
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            if let indexPaths = self.myCollectionView.indexPathsForSelectedItems {
                let indexPath = indexPaths[0]
                let destinationVC = segue.destination as! CardDetailViewController
                destinationVC.cardModel = self.cards[indexPath.row]
            } else {
                print("error occured")
            }
        }
    }

}

extension UIImageView {
    
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
