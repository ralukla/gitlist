//
//  ListViewController.swift
//  GitList
//
//  Created by Raluca Radu on 01/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: ListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ListViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        title = "Github Trends"
        
        tableView.tableFooterView = UIView()
        
        viewModel?.getArray(completion: {
            self.tableView.reloadData()
        })
    }

}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard viewModel?.array != nil else {
            return 0
        }
        return (viewModel?.array?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCellIdentifier", for: indexPath) as! ProjectsTableViewCell
        
        let project = viewModel?.array![indexPath.row]
        
        cell.projectStars.text = NumberFormatter.localizedString(from: NSNumber(value: project!.stars), number: NumberFormatter.Style.decimal)
        
        cell.projectName.text = project!.name
        cell.projectName.textColor = .black
        
        if (searchBar.text?.count)! >= 3 {
            let range = (project!.name.lowercased() as NSString).range(of: (searchBar.text?.lowercased())!)
            let attribute = NSMutableAttributedString.init(string: project!.name)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
            
            cell.projectName.attributedText = attribute
        }
        
        cell.projectDescription.text = project!.desc
        cell.projectDescription.textColor = .lightGray
        
        if (searchBar.text?.count)! >= 3 {
            let range = (project!.desc.lowercased() as NSString).range(of: (searchBar.text?.lowercased())!)
            let attribute = NSMutableAttributedString.init(string: project!.desc)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
            
            cell.projectDescription.attributedText = attribute
        }
        
        return cell
    }
    
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText.count != 0 && searchText.count >= 3 else {
            viewModel?.fullList()
            tableView.reloadData()
            return
        }
        
        viewModel?.search(searchText: searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.fullList()
        tableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
