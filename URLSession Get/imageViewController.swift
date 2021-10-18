//
//  imageViewController.swift
//  URLSession Get
//
//  Created by Gold_Mock on 15.09.2021.
//

import UIKit
import Alamofire

class imageViewController: UIViewController {

    private let imageUrl = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let largeImageUrl = "https://i.imgur.com/3416rvI.jpg"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        progressLabel.isHidden = true
        progressView.isHidden = true
        
    }
    
    func downloadImage() {
        
        NetworkManager.downloadImage(url: imageUrl) { (image) in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            self.imageView.image = image
        }
    }
    
    func fetchImageWithAlamofire() {
        
        AlamofireNetworkRequest.downloadImage(url: imageUrl) { image in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func downloadImageWithProgress() {
        
        AlamofireNetworkRequest.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
        
        AlamofireNetworkRequest.completed = { completed in
            self.progressLabel.isHidden = false
            self.progressLabel.text = completed
        }
        
        AlamofireNetworkRequest.downloadImageWithProgress(url: largeImageUrl) { (image) in
            self.activityIndicator.stopAnimating()
            
            self.progressLabel.isHidden = true
            self.progressView.isHidden = true
            
            self.imageView.image = image
        }
    }
    
}
