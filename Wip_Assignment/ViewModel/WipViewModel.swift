//
//  WipViewModel.swift
//  Wip_Assignment
//
//  Created by Abhijit on 06/01/22.
//

import Foundation
import UIKit


class WipViewModel: NSObject {
    
    var reloadData : (() -> Void) = { return }
    var urlSTring: String = StringConstants.urlString
    var contactApiData: WipModel? {
        didSet {
            self.reloadData()
        }
    }
    
    override init() {
        super.init()
        self.getData()
    }
    
    
    func getData() {
        WipNetworkManager.getUserData(urlstring: urlSTring) { (model, msg) in
            self.contactApiData = model
        }
    }
}

