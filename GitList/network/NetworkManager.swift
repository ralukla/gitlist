//
//  NetworkManager.swift
//  GitList
//
//  Created by Raluca Radu on 06/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    enum SinceValue: Int {
        case daily
        case weekly
        case monthly
        
        var name: String {
            switch self {
            case .daily:
                return "daily"
            case .weekly:
                return "weekly"
            case .monthly:
                return "monthly"
            }
        }
    }
    
    func fetchTrendingList(since: Int, completion: @escaping ([GitProject]?) -> Void) {
        guard let url = URL(string: "https://github-trending-api.now.sh/repositories") else {
            completion(nil)
            return
        }
        
        guard let sinceParameter = SinceValue(rawValue: since) else {
            return
        }
        
        Alamofire.request(url,
                          method: .get,
                          parameters: ["language": "",
                                       "since": sinceParameter.name])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote projects: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let rows = response.result.value as? [[String: Any]] else {
                        print("Malformed data received from fetchTrendingList service")
                        completion(nil)
                        return
                }
                
                let projects = rows.compactMap { jsonData in return GitProject(jsonData: jsonData) }
                completion(projects)
        }
    }
    
    func fetchOwner(gitProject: GitProject, completion: @escaping (GitProjectOwner?) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/" + gitProject.author) else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching owner: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    print("Malformed data received from fetchOwner service")
                    completion(nil)
                    return
                }
                
                let owner = GitProjectOwner(jsonData: value)
                completion(owner)
        }
    }
    
    func fetchReadMe(owner: String, repo: String, completion: @escaping (Readme?) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/repos/" + owner + "/" + repo + "/readme") else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching readme: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                        print("Malformed data received from fetchReadMe service")
                        completion(nil)
                        return
                }
                
                let readme =  Readme(jsonData: value)
                completion(readme)
        }
    }
}
