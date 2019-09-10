//
//  MovieDescriptionViewController.swift
//  MoviesList
//
//  Created by Olga Lidman on 10/09/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class MovieDescriptionViewController: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var posterImagiView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rating: UILabel!
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = movie.nameRus
        
        if movie.imageURL == "" {
            posterImagiView.image = #imageLiteral(resourceName: "movieTape")
        } else {
            posterImagiView.downloaded(from: movie.imageURL)
        }
        movieNameLabel.text = movie.name
        yearLabel.text = "\(movie.year)"
        setRatingColor(rating: movie.rating, label: ratingLabel)
        ratingLabel.text = "\(movie.rating)"
        descriptionLabel.text = movie.description
        if movie.year == 0 {
            year.isHidden = true
        }
        if movie.rating == 0 {
            rating.isHidden = true
        }
    }
}
