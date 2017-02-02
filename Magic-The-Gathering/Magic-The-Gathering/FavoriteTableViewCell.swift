//
//  FavoriteTableViewCell.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 2/2/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var favName: UILabel!
    @IBOutlet weak var favArtist: UILabel!
    @IBOutlet weak var favRarity: UILabel!
    @IBOutlet weak var favText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
