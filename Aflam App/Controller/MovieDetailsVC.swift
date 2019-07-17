//
//  MovieDetailsVC.swift
//  Aflam App
//
//  Created by Esraa Hassan on 7/17/19.
//  Copyright © 2019 Developers. All rights reserved.
//

import UIKit
import SDWebImage
import Foundation
import SystemConfiguration
import Cosmos
class MovieDetailsVC: UIViewController ,UITextViewDelegate{
    var imageUrl = "https://image.tmdb.org/t/p/w185/"
    @IBOutlet weak var scrolView: UIScrollView!
    
    @IBOutlet var movieRate: CosmosView!
    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblReleaseYear: UILabel!
    @IBOutlet weak var txtViewOverviewMovie: UITextView!
    var movie = Movie()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lblTitleMovie.text = movie.getOriginalTitle()
        movieRate.rating = Double(movie.getVoteAverage()/2)
        movieRate.text = String(movie.getVoteAverage())
        lblReleaseYear.text = movie.getReleaseDate()
        txtViewOverviewMovie.text = movie.getoverView()
        txtViewOverviewMovie.isEditable = false
        imgMovie.sd_setImage(with: URL(string: imageUrl + movie.getPosterPath()),
                             placeholderImage: UIImage(named: "1.jpg")) ;
        
    }
    
}

