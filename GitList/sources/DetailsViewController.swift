//
//  DetailsViewController.swift
//  GitList
//
//  Created by Raluca Radu on 06/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class DetailsViewController: UIViewController {

    struct Constants {
        static let radiusCornerEmphasise = CGFloat(5)
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emphasiseView: UIView!
    @IBOutlet weak var interiorEmphasiseView: UIView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var gitProject: GitProject! = nil
    
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DetailsViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = gitProject?.name
        
        loadInfo()
        loadWebPage()
    }
    
    // MARK: - Helpers
    
    func loadInfo() {
        
        usernameLabel.text = gitProject.owner.userName
        descriptionLabel.text = gitProject.desc

        loadAvatar()
        
        emphasiseView.layer.cornerRadius = Constants.radiusCornerEmphasise
        emphasiseView.clipsToBounds = true
        interiorEmphasiseView.layer.cornerRadius = Constants.radiusCornerEmphasise - 1
        interiorEmphasiseView.clipsToBounds = true
        
        starsLabel.text = NumberFormatter.localizedString(from: NSNumber(value: gitProject.stars), number: NumberFormatter.Style.decimal) + " Stars"
        forksLabel.text = NumberFormatter.localizedString(from: NSNumber(value: gitProject.forks), number: NumberFormatter.Style.decimal) + " Forks"
    }
    
    func loadAvatar() {
        let url = URL(string: gitProject.owner.avatarUrl)!
        avatarImageView.image = UIImage(named: "profile")!
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2.0
        avatarImageView.clipsToBounds = true
        
        Alamofire.request(url).responseData { (response) in
            guard response.error == nil else {
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.avatarImageView.image = UIImage(data: data)
        }
    }
    
    func loadWebPage() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
        webView.navigationDelegate = self
        
        webView.isOpaque = false
        webView.backgroundColor = .clear
        
        viewModel?.getReadme(gitProject: gitProject, completion: { readme in
            guard let url = URL(string: readme.url) else {
                return
            }
            
            self.webView.load(URLRequest(url: url as URL))
        })
    }
}

extension DetailsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
}
