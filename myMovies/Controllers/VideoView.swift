//
//  VideoView.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/16/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import WebKit


class VideoView: UIView {
    @IBOutlet weak var videoWebView: WKWebView!
    @IBOutlet weak var backdropImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func commonInit(){
        
    }

}
