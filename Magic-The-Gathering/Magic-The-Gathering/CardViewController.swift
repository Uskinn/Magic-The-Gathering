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
    
    var cards: [Card]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        
        fetchCards()
    }
    
    func fetchCards() {
        
        let urlRequest = URLRequest(url: URL(string: TheGatheringApi.theGatheringUrl)!)
        
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            self.cards = [Card]()
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                
                guard let cardFromJson = json?["cards"] as? [[String : Any]] else { return }
                
                for card in cardFromJson {
                    guard let cardImageUrl = card["imageUrl"] as? String else {return}
                    
                    let newCard = Card()
                    
                    newCard.imageUrl = cardImageUrl
                    
                    self.cards?.append(newCard)
                }
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        urlTask.resume()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        cell.cardImageView.downloadImage(from: (self.cards?[indexPath.item].imageUrl)!)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
