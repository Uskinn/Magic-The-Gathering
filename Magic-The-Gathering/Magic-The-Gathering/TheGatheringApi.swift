//
//  TheGatheringApi.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 2/1/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import UIKit

struct TheGatheringApi {
    
   static func getCardWith(completion: @escaping ([String : Any]) -> Void) {
        let session = URLSession.shared
        let theGatheringUrl = "https://api.magicthegathering.io/v1/cards"
        let url = URL(string: theGatheringUrl)
        guard let unwrappedUrl = url else {return}
        let dataTask = session.dataTask(with: unwrappedUrl) { (data, response, error) in
            guard let data = data else {return}
            if let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                guard let responseJson = responseData else {return}
                completion(responseJson)
            }
        }
        dataTask.resume()
    }
}
