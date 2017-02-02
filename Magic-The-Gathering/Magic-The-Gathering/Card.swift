//
//  Card.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 2/1/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import Foundation

struct Card {
    
    var cardName: String?
    var cardRarity: String?
    var cardText: String?
    var artist: String?
    var imageUrl: String?
    
    init(details: [String : Any]) {
        self.cardName = details["name"] as? String
        self.cardRarity = details["rarity"] as? String
        self.cardText = details["text"] as? String
        self.artist = details["artist"] as? String
        self.imageUrl = details["imageUrl"] as? String
    }
}
