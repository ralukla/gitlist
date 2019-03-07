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
    
    func fetchTrendingList(completion: @escaping ([GitProject]?) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/search/repositories") else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get,
                          parameters: ["q": "created:>2018-03-01",
                                       "sort": "stars",
                                       "order": "desc"])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote projects: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                    let rows = value["items"] as? [[String: Any]] else {
                        print("Malformed data received from fetchTrendingList service")
                        completion(nil)
                        return
                }
                
                let projects = rows.compactMap { jsonData in return GitProject(jsonData: jsonData) }
                completion(projects)
        }
    }
}
