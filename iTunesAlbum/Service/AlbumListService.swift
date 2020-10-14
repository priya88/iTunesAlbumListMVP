//
//  AlbumListService.swift
//  iTunesAlbum
//
//  Created by Priyanka Saroha on 10/26/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import Foundation

class AlbumListService {
    func fetchAlbumList(forQuery searchQuery: String, completion: @escaping (_ result: [Album],_ error: Bool) -> Void ) {
        let albumSearchURL = URL(string: "https://itunes.apple.com/search?term=\(searchQuery)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        )
        URLSession.shared.dataTask(with: albumSearchURL!) { (data, response, error) in
            guard let serverData = data else { return }
            do {
                let decoder = JSONDecoder()
                let rawResponseFromServer = try decoder.decode(RawServerResponse.self, from: serverData)
                completion(rawResponseFromServer.results, error != nil ? true:false)
            } catch let decodingError {
                print("Error while decoding : \(decodingError)")
            }
            }.resume()
    }
}
