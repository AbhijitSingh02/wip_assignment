//
//  NetworkManager.swift
//  Wip_Assignment
//
//  Created by Abhijit on 06/01/22.
//

import Foundation
class WipNetworkManager {
    static func getUserData(urlstring: String, completion: @escaping (WipModel?, String?)  ->Void) {
        if let url = URL(string: urlstring) {
            URLSession.shared.dataTask(with: url) {
                data, response, err in
                if let data = data {
                    if let value = String(data: data, encoding: String.Encoding.ascii) {
                        if let jsonData = value.data(using: String.Encoding.utf8) {
                            do {
                                print(data)
                                let modelValue = try JSONDecoder().decode(WipModel.self, from: jsonData)
                                completion(modelValue, nil)
                            } catch let jsonError as NSError {
                                print("JSON decode failed: \(jsonError.localizedDescription)")
                            }
                        }
                    }
                } else {
                    completion(nil, "Data not Found")
                    print("Data not found")
                }
            }.resume()
        } else {
            completion(nil, "Wrong Url provided")
        }
    
    }
}
