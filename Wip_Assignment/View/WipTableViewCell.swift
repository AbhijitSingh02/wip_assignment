//
//  WipTableViewCell.swift
//  Wip_Assignment
//
//  Created by Abhijit on 06/01/22.
//

import UIKit

class WipTableViewCell: UITableViewCell {

        let containerView:UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
        
        let profileImageView:UIImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            img.layer.cornerRadius = 35
            img.clipsToBounds = true
            return img
        }()
        
        let titleLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let descriptionLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor =  .white
            label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            label.layer.cornerRadius = 5
            label.clipsToBounds = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.contentView.addSubview(profileImageView)
            containerView.addSubview(titleLabel)
            containerView.addSubview(descriptionLabel)
            self.contentView.addSubview(containerView)
            
            profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
            profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:5).isActive = true
            profileImageView.widthAnchor.constraint(equalToConstant:50).isActive = true
            profileImageView.heightAnchor.constraint(equalToConstant:50).isActive = true
            
            containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:-10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
            
            titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant: 50).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
            
            descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
            descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant: 50).isActive = true
           
            

        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }
        
        func setUpApiData(contactData: Row) {
            self.titleLabel.text = contactData.title
            self.descriptionLabel.text = contactData.rowDescription
            self.loadImageToCell(url: contactData.imageHref ?? "")
        }

        func loadImageToCell(url: String){
            if let imageurl = URL(string : url){
                DispatchQueue.global().async {
                    let some = try? Data(contentsOf: imageurl)
                    if let data = some{
                        let image = UIImage(data:data)
                        DispatchQueue.main.async {
                            self.imageView?.image = image
                        }
                    }
                }
            } else {
                self.imageView?.image = UIImage(named: "Delivery Bike 1")
            }
        }
    }
