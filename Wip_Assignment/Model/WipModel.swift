//
//  WipModel.swift
//  Wip_Assignment
//
//  Created by Abhijit on 06/01/22.
//

import Foundation

struct ContactModal: Codable {
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


/*
struct Json4Swift_Base : Codable {
    let title : String?
    //let rows : [Rows]?

    enum CodingKeys: String, CodingKey {

        case title = "title"
       // case rows = "rows"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
       // rows = try values.decodeIfPresent([Rows].self, forKey: .rows)
    }

}

struct Rows : Codable {
    let title : String?
    let description : String?
    let imageHref : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)
    }

}
*/
