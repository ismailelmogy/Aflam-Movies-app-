//
//  moviesCollectionView.swift
//  MoviesApp
//
//  Created by jets on 7/24/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class MoviesCV: UICollectionViewController {
    var moviesList : Array<Movie>=[];
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        getTopRatedMovies()
        
    }
    
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            self.getTopRatedMovies()
            break
        case 1:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            self.getMostPopularMovies()
            break
        default:
            
            break
        }
    }
    @objc func getTopRatedMovies(){
        moviesList.removeAll()
        let topRatedUrl = URL(string : URLS.TOP_RATED_URL)
        Alamofire.request(topRatedUrl!).responseJSON{response in
            switch response.result {
            case .success:
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                let responseValue = response.result.value as! [String : Any]?
                
                print("\(String(describing: responseValue))")
                let responseMovies = responseValue?["results"] as! [[ String: Any]]?
                for var item in responseMovies! {
                    let movie = Movie()
                    movie.setID(id: item["id"] as! Int)
                    movie.setOverView(overview: item["overview"]as! String)
                    movie.setPosterPath(posterPath: item["poster_path"]as! String)
                    movie.setRealeasDate(releaseDate: item["release_date"]as! String)
                    movie.setVoteAverage(voteAverage: (item["vote_average"]as! NSNumber).floatValue)
                    movie.setOriginalTitle(originalTitle: item["title"]as! String)
                    self.moviesList.append(movie)
                }
                self.collectionView?.reloadData()
            case .failure( _):
                print ("failure  in parsing")
            }
        }
        
        
    }
    @objc func getMostPopularMovies(){
        moviesList.removeAll()
        let popularMoviesUrl = URL(string : URLS.POPULAR_URL)
        Alamofire.request(popularMoviesUrl!).responseJSON{response in
            switch response.result {
            case .success:
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                let responseValue = response.result.value as! [String : Any]?
                let responseMovies = responseValue?["results"] as! [[ String: Any]]?
                for var item in responseMovies! {
                    let movie = Movie()
                    movie.setID(id: item["id"] as! Int)
                    movie.setOverView(overview: item["overview"]as! String)
                    movie.setPosterPath(posterPath: item["poster_path"]as! String)
                    movie.setRealeasDate(releaseDate: item["release_date"]as! String)
                    movie.setVoteAverage(voteAverage: (item["vote_average"]as! NSNumber).floatValue)
                    movie.setOriginalTitle(originalTitle: item["title"]as! String)
                    self.moviesList.append(movie)
                    
                }
                self.collectionView?.reloadData()
            case .failure(_):
                print ("failure  in parsing")
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "details") as! MovieDetailsVC
        detailsVC.movie = moviesList[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCVCell
        
        cell.imageMovie.sd_setImage(with: URL(string: URLS.IMAGE_URL + moviesList[indexPath.row].getPosterPath()), placeholderImage: UIImage(named: "1.jpg"))
        
        return cell
    }
    
    
    
    
    
}

