//
//  ViewController.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {

    

fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var segmentedControlView: UIView!
    var filmCategory: String.filmCategory = .popular
    var movies : [Movie]?
    let cellId = "artworkCell"
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.setupViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArtworkCollectionViewCell
        if let movie = movies?[indexPath.row] {
            let placeholderImage = UIImage(named: "NA")
            let imageURL = URL(string: "\(Endpoints.imageURL)\(movie.posterPath ?? "")?api_key=\(ApiConstants.api_key)")
            cell.posterImageView.kf.setImage(with: imageURL, placeholder: placeholderImage)
        }
        return cell
    }
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filmCategory = .popular
        case 1:
            filmCategory = .top_rated
        case 2:
            filmCategory = .upcoming
        default:
            break
        }
        self.loadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        if let movie = movies?[indexPath.row]  {
            if movie.originalLanguage != nil && movie.popularity != nil {
                detailViewController.movie = movie
                self.navigationController?.pushViewController(detailViewController, animated: true)
            } else {
                var endpoint = Endpoints.getMovieById
                if let id = movie.id{
                endpoint = endpoint.replacingOccurrences(of: "#id#", with: String(id))
                    DataFacade.getMovie(fileLocation: Endpoints.getMovieById, id: id) { (movie, error)  in
                        if error != nil {
                            self.alert(message: error?.localizedDescription ?? "Error getting movie")
                        } else {
                            detailViewController.movie = movie
                            self.navigationController?.pushViewController(detailViewController, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func setupViews(){
        title = "Movies"
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.register(UINib(nibName:"ArtworkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:cellId)
        let bar = self.navigationController?.navigationBar
        bar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if #available(iOS 13.0, * ){
    
        } else {
            self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)

            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Text") ?? UIColor.black]
        }
        
        
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.setImage(UIImage(named: "my_search_icon"), for: UISearchBar.Icon.search, state: .normal)
        searchController.searchBar.setImage(UIImage(named: "my_search_icon"), for: UISearchBar.Icon.clear, state: .normal)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "SearchBar") ?? UIColor.white]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "SearchBar") ?? UIColor.white])
        
        searchController.searchBar.tintColor = UIColor(named: "SearchBar")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    func loadData() {
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        DataFacade.getMovies(fileLocation: Endpoints.getEvents.getMovieUrl(type: .movie, event: filmCategory), filmCategory: filmCategory, type: .movie) { (movies, error) in
            self.view.activityStopAnimating()
            if let err = error {
                self.alert(message: err.localizedDescription, title: "Error")
            }
                if let movies = movies {
                    self.movies = movies
                    self.reloadCollectionData()
                }
        }
    }
    
    func reloadCollectionData() {
        self.moviesCollectionView.performBatchUpdates(
            {
                self.moviesCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
        }, completion: { (finished:Bool) -> Void in
        })
    }
}

extension MoviesViewController: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.tintColor = .white
        self.segmentedControlView.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        self.segmentedControlView.isHidden = false
        loadData()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = String()
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let enterededText = searchController.searchBar.text {
            var endpoint = Endpoints.search.replacingOccurrences(of: "#query#", with: enterededText)
            endpoint = endpoint.replacingOccurrences(of: " ", with: "%20")
            DataFacade.searchMovies(fileLocation: endpoint, filmCategory: filmCategory, type: .movie, search: enterededText) { (movies, error) in
                if let err = error {
                    self.alert(message: err.localizedDescription, title: "Error")
                }
                if let movies = movies {
                    self.movies = movies
                    self.reloadCollectionData()
                }
            }
        }
    }
}

