//
//  WipViewController.swift
//  Wip_Assignment
//
//  Created by Abhijit on 06/01/22.
//

import UIKit

class WipViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //private let contacts = ContactAPI.getContacts() // model /// HERE
    var contacts : ContactAPI?
    let contactsTableView = UITableView() // view

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(contactsTableView)
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        contactsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        contactsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        contactsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        contactsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        //      contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        contactsTableView.register(WipTableViewCell.self, forCellReuseIdentifier: "contactCell")
        self.contacts = ContactAPI()
        if let viewModel = contacts {
            viewModel.bindviewModelToViewControlller = {
                DispatchQueue.main.async {
                    self.contactsTableView.reloadData()
                }
            }
        }
        navigationItem.title = "Contacts"
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return contacts.count //// HERE
        return contacts?.contactApiData?.rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! WipTableViewCell
        if let data = contacts?.contactApiData?.rows?[indexPath.row] {
            cell.setUpApiData(contactData: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
