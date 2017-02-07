//
//  CardCollectionViewCell.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 1/31/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import UIKit

protocol CardCellDelegate: class {
    func canUpdateImage(sender: Card) -> Bool
}

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    weak var delegate: CardCellDelegate!
    
    weak var card: Card! {
        didSet {
            setupCard()
        }
    }
    
    func setupCard() {
        
        if card.image != nil {
            cardImageView.image = card.image
            return
        }
        
        if card.image == nil && !card.isDownloading {
            card.downloadImage(handler: { [unowned self] success in
                guard success else { return }
                if self.delegate.canUpdateImage(sender: self.card) {
                    
                    self.cardImageView.alpha = 0.0
                    self.cardImageView.image = self.card.image

                    UIView.animate(withDuration: 0.8, animations: {
                        
                        self.cardImageView.alpha = 1.0
                        
                    })
                    
                }
            })
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
    }
    
}
