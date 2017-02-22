//
//  FavoriteViewController.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 2/2/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    
    var cardArray: [CardEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fetchResult: NSFetchRequest<CardEntity> = CardEntity.fetchRequest()
        
        do {
            cardArray = try CoreDataFile.getContext().fetch(fetchResult)
            print(cardArray.count)
            
        } catch let error {
            print(error)
        }
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! FavoriteTableViewCell
        let card = cardArray[indexPath.row]
        cell.favName.text = card.cardName
        cell.favArtist.text = card.cardArtist
        cell.favRarity.text = card.cardRarity
        if let image = UIImage(data: card.cardImage as! Data) {
            cell.favImage.image = image
        }
        
        print("card image: \(card.cardImage)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            // delete from core data
            CoreDataFile.getContext().delete(cardArray[indexPath.row])
            // save new changed core data
            do {
                try CoreDataFile.getContext().save()
            } catch {
                print(error)
            }
            // delete from array
            cardArray.remove(at: indexPath.row)
            // delete from tableView
            myTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}












