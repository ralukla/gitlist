//
//  ListViewController.swift
//  GitList
//
//  Created by Raluca Radu on 01/03/2019.
//  Copyright © 2019 Raluca Phillimore. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    struct Constants {
        static let numberOfCharactersSearch = 3
        static let heightCell = CGFloat(140)
    }

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
        
        viewModel?.getProjectList(completion: {
            self.tableView.reloadData()
        })
    }

     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detailsSegue" else {
            return
        }
        
        let destinationVC = segue.destination as! DetailsViewController
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        destinationVC.gitProject = viewModel?.projectsList![indexPath.row]
     }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard viewModel?.projectsList != nil else {
            return 0
        }
        return (viewModel?.projectsList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCellIdentifier", for: indexPath) as! ProjectsTableViewCell
        
        let project = viewModel?.projectsList![indexPath.row]
        
        cell.projectStars.text = NumberFormatter.localizedString(from: NSNumber(value: project!.stars), number: NumberFormatter.Style.decimal)
        
        cell.projectName.text = project!.fullName
        cell.projectName.textColor = .black
        
        cell.projectDescription.text = project!.desc
        cell.projectDescription.textColor = .lightGray
        
        guard (searchBar.text?.count)! >= Constants.numberOfCharactersSearch else {
            return cell
        }
       
        let rangeName = (project!.fullName.lowercased() as NSString).range(of: (searchBar.text?.lowercased())!)
        let attributeName = NSMutableAttributedString.init(string: project!.fullName)
        attributeName.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: rangeName)
        
        cell.projectName.attributedText = attributeName
        
        let rangeDesc = (project!.desc.lowercased() as NSString).range(of: (searchBar.text?.lowercased())!)
        let attributeDesc = NSMutableAttributedString.init(string: project!.desc)
        attributeDesc.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: rangeDesc)
        
        cell.projectDescription.attributedText = attributeDesc
        
        return cell
    }
    
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count != 0 && searchText.count >= Constants.numberOfCharactersSearch else {
            viewModel?.getDefaultProjectList()
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
        viewModel?.getDefaultProjectList()
        tableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
