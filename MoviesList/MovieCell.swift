//
//  MovieCell.swift
//  MoviesList
//
//  Created by Olga Lidman on 10/09/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieNameRUSLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
