//
//  WipModel.swift
//  Wip_Assignment
//
//  Created by Abhijit on 06/01/22.
//

import Foundation

struct WipModel: Codable {
    let title: String?
    let rows: [Row]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rows = "rows"
    }
}

// MARK: - Row
struct Row: Codable {
    let title: String?
    let rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rowDescription = "description"
        case imageHref = "imageHref"
    }
}
