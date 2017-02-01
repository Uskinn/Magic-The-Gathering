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
    
    var images = ["ima", "ima", "ima", "ima", "ima"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        cell.cardImageView.image = UIImage(named: images[indexPath.row])
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
