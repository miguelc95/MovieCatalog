//
//  DetailViewController.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/15/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, UIScrollViewDelegate {

    var movie: Movie?
    var tv: TV?
    @IBOutlet weak var pageScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var avgImageView: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var languageOriginalLbl: UILabel!
    
    @IBOutlet var stars: [UIButton]!
    
    var videos = [Video]()
    
    var rate : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        pageScrollView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ConnectionStatus.shared.connected {
            rateBtn.isEnabled = true
        } else {
            rateBtn.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let id = movie == nil ? tv?.id : movie?.id else {return}
        let backdrop = movie == nil ? tv?.backdropPath : movie?.backdropPath
        let type = movie == nil ? "tv" : "movie"
        let imageURL = URL(string: "\(Endpoints.imageURL)\(backdrop ?? "")?api_key=\(ApiConstants.api_key)")
        var endpoint =  Endpoints.getMovieVideos.replacingOccurrences(of: "#movie_id#", with:"\(id)")
        endpoint = endpoint.replacingOccurrences(of: "#type#", with: type)

        DataFacade.getVideos(endpoint: endpoint, id: id) { (videos) in
            self.videos = videos
            var videoViews = [VideoView]()
            let backdropView:VideoView = Bundle.main.loadNibNamed("VideoView", owner: self, options: nil)?.first as! VideoView
            backdropView.backdropImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "NABACK"))
            backdropView.videoWebView.isHidden = true
            videoViews.append(backdropView)

            for video in videos {
                let videoSlide:VideoView = Bundle.main.loadNibNamed("VideoView", owner: self, options: nil)?.first as! VideoView
                let endpoint = Endpoints.youtube.replacingOccurrences(of: "#key#", with: video.key)
                if let url = URL(string: endpoint) {
                    videoSlide.videoWebView.load(URLRequest(url: url))
                    videoSlide.backdropImageView.isHidden = true

                }
                videoViews.append(videoSlide)
            }
            self.setupSlideScrollView(videosViews: videoViews)
            
            self.pageControl.numberOfPages = videoViews.count
            self.pageControl.currentPage = 0
            self.view.bringSubviewToFront(self.pageControl)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageScrollView.scrollsToTop = true
        pageControl.currentPage = Int(pageIndex)
    }
    
    func setupSlideScrollView(videosViews : [VideoView]) {
        pageScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: pageScrollView.frame.height)
        pageScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(videosViews.count), height: pageScrollView.frame.height)
        pageScrollView.isPagingEnabled = true
        
        for i in 0 ..< videosViews.count {
            videosViews[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: pageScrollView.frame.height)
            pageScrollView.addSubview(videosViews[i])
        }
    }
    
    func setupViews() {
        navigationController?.navigationBar.tintColor = .white
        if let movie = movie {
            title = movie.title
            self.dateLbl?.text = movie.releaseDate
            self.descriptionLbl?.text = movie.overview
            self.languageLbl.text = movie.originalLanguage?.uppercased() ?? "No information"
            self.avgImageView.text = "\(movie.voteAverage ?? 0)"
            self.languageOriginalLbl.text = "Language: "
            
        } else if let serie = tv {
            title = serie.name
            self.dateLbl?.text = serie.firstAirDate
            self.descriptionLbl?.text = serie.overview
            self.languageLbl.text = serie.originalName
            self.avgImageView.text = "\(serie.voteAverage ?? 0)"
            self.languageOriginalLbl.text = "Original title: "


        }
    }
    
    @IBAction func setRating(_ sender: UIButton) {
        setRating(rating: sender.tag)
    }
    
    @IBAction func rate(_ sender: UIButton) {
        var type: String.type
        if rate == 0 {
            alert(message: "You must first select a rating")
        } else {
            type = movie == nil ? String.type.tv : String.type.movie
            Network.postRating(rating: self.rate, type: type) { (error) in
                if error != nil {
                    if let errorDesc = error?.localizedDescription {
                        self.alert(message: errorDesc, title: "Error")
                    } else {
                        self.alert(message: "Error rating", title: "Error")
                    }
                } else {
                    self.alert(message: "Rate sent")
                }
            }
        }
    }
    
    func setRating(rating:Int) {
        self.rate = rating
        if rating != 5 {
            for rate in 0...rating - 1 {
                self.stars?[rate].setImage(UIImage(named: "Star_filled"), for: .normal)
            }
            
            for rate in rating...4 {
                self.stars?[rate].setImage(UIImage(named: "Star-1"), for: .normal)
            }
        } else {
            for rate in 0...rating - 1 {
                self.stars?[rate].setImage(UIImage(named: "Star_filled"), for: .normal)
            }
        }
    }
}
