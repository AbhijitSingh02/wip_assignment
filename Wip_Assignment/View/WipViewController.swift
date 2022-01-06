//
//  WipViewController.swift
//  Wip_Assignment
//
//  Created by Abhijit on 06/01/22.
//

import UIKit

class WipViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel = WipViewModel()
    let contactsTableView = UITableView() // view

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(contactsTableView)
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        contactsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        contactsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        contactsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        contactsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
      
        contactsTableView.register(WipTableViewCell.self, forCellReuseIdentifier: "contactCell")
        viewModel.reloadData = {
            DispatchQueue.main.async {
                self.contactsTableView.reloadData()
            }
        }
        navigationItem.title = StringConstants.title
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactApiData?.rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! WipTableViewCell
        if let data = viewModel.contactApiData?.rows?[indexPath.row] {
            cell.setUpApiData(contactData: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
