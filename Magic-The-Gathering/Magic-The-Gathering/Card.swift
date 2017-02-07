//
//  Card.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 2/1/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import Foundation
import UIKit

final class Card: Equatable {
    
    var cardName: String?
    var cardRarity: String?
    var cardText: String?
    var artist: String?
    var imageUrl: String?
    var image: UIImage?
    var isDownloading: Bool = false
    
    init(details: [String : Any]) {
        self.cardName = details["name"] as? String
        self.cardRarity = details["rarity"] as? String
        self.cardText = details["text"] as? String
        self.artist = details["artist"] as? String
        self.imageUrl = details["imageUrl"] as? String
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.imageUrl == rhs.imageUrl
    }
    
    
    func downloadImage(handler: @escaping (Bool) -> Void) {
        
        isDownloading = true
        
        guard let urlString = imageUrl, let url = URL(string: urlString)
            else { handler(false); return }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let rawData = data, let newImage = UIImage(data: rawData)
                    else { handler(false); return }
                
                self.image = newImage
                
                handler(true)

            }
        }
        task.resume()
    }
}
