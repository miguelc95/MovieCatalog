//
//  TVViewController.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import Kingfisher

class TVViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedControlView: UIView!
    
    var seriesCategory: String.seriesCategory = .popular
    var series : [TV]?
    let cellId = "artworkCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.setupViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = seriesCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArtworkCollectionViewCell
        if let serie = series?[indexPath.row] {
                let placeholderImage = UIImage(named: "NA")
                let imageURL = URL(string: "\(Endpoints.imageURL)\(serie.posterPath ?? "")?api_key=\(ApiConstants.api_key)")
                cell.posterImageView.kf.setImage(with: imageURL,placeholder: placeholderImage)
        }
        return cell
    }
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            seriesCategory = .popular
        case 1:
            seriesCategory = .top_rated
        case 2:
            seriesCategory = .airing_today
        default:
            break
        }
        self.loadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        if let serie = series?[indexPath.row]  {
            
            if serie.popularity != nil && serie.firstAirDate != nil {
                detailViewController.tv = serie
                self.navigationController?.pushViewController(detailViewController, animated: true)
            } else {
                var endpoint = Endpoints.getSerieById
                if let id = serie.id{
                    endpoint = endpoint.replacingOccurrences(of: "#id#", with: String(id))
                    DataFacade.getSerie(fileLocation: endpoint, id: id) { (serie, error)  in
                        if error != nil {
                            self.alert(message: error?.localizedDescription ?? "Error getting movie")
                        } else {
                            detailViewController.tv = serie
                            self.navigationController?.pushViewController(detailViewController, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func setupViews(){
        title = "TV"
        self.seriesCollectionView.delegate = self
        self.seriesCollectionView.dataSource = self
        if #available(iOS 13.0, * ){
        } else {
            self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            let bar = self.navigationController?.navigationBar
            bar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Text") ?? UIColor.black]
        }
        self.seriesCollectionView.register(UINib(nibName:"ArtworkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:cellId)
        
        
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.setImage(UIImage(named: "my_search_icon"), for: UISearchBar.Icon.search, state: .normal)
        searchController.searchBar.setImage(UIImage(named: "my_search_icon"), for: UISearchBar.Icon.clear, state: .normal)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        searchController.searchBar.tintColor = .white
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    func loadData() {
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        DataFacade.getSeries(fileLocation: Endpoints.getEvents.getTVUrl(type: .tv, event: seriesCategory), seriesCategory: seriesCategory, type: .tv) { (series, error) in
            self.view.activityStopAnimating()
            if let err = error {
                self.alert(message: err.localizedDescription, title: "Error")
            }
                if let series = series {
                    self.series = series
                    self.reloadCollectionData()
                }
        }
    }
    
    func reloadCollectionData() {
        self.seriesCollectionView.performBatchUpdates(
            {
                self.seriesCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
        }, completion: { (finished:Bool) -> Void in
        })
    }
}

extension TVViewController: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        self.segmentedControlView.isHidden = true
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.tintColor = .white
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        loadData()
        self.segmentedControlView.isHidden = true
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = String()
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let enterededText = searchController.searchBar.text {
            var endpoint = Endpoints.search.replacingOccurrences(of: "#query#", with: enterededText)
            endpoint = endpoint.replacingOccurrences(of: " ", with: "%20")
            DataFacade.searchSeries(fileLocation: endpoint, seriesCategory: seriesCategory, type: .tv, search: enterededText) { (series, error) in
                if let err = error {
                    self.alert(message: err.localizedDescription, title: "Error")
                }
                if let series = series {
                    self.series = series
                    self.reloadCollectionData()
                }
            }
        }
    }
    
}

