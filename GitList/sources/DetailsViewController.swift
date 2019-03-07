//
//  DetailsViewController.swift
//  GitList
//
//  Created by Raluca Radu on 06/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var gitProject: GitProject! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = gitProject?.name
        
        loadInfo()
    }
    
    // MARK: - Helpers
    
    func loadInfo() {
        
        usernameLabel.text = gitProject.owner.userName
        descriptionLabel.text = gitProject.desc
        
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
}
