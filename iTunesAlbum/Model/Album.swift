//
//  Album.swift
//  iTunesAlbum
//
//  Created by Priyanka Saroha on 10/26/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import UIKit
struct RawServerResponse: Decodable {
    var resultCount: Int?
    var results: [Album]
}

struct Album: Decodable {
    var albumArtWorkUrlString: String?
    var albumName: String?
    var releaseDate: String?
    var primaryGenreName: String?
    var currency: String?
    var copyright: String?
    var trackPrice: Float?
    private enum CodingKeys: String, CodingKey {
        case albumArtWorkUrlString = "artworkUrl60"
        case albumName = "collectionName"
        case currency = "currency"
        case copyright = "copyright"
        case primaryGenreName = "primaryGenreName"
        case releaseDate = "releaseDate"
        case trackPrice = "trackPrice"
    }
}

