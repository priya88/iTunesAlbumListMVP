//
//  AlbumListPresenter.swift
//  iTunesAlbum
//
//  Created by Priyanka Saroha on 10/26/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import UIKit

class AlbumListPresenter {
    var albumListService = AlbumListService()
    var albumListView: AlbumListView?
    
    init(withService service: AlbumListService) {
        albumListService = service
    }
    
    func attachView(_ view:AlbumListView){
        albumListView = view
    }
    
    func detachView() {
        albumListView = nil
    }
    
    /// method to get the list of albums
    ///
    /// - Parameter query: "https://itunes.apple.com/search?term=%@"
    func searchAlbumsForQuery(for query: String) {
        if Reachability.isConnectedToNetwork() {
            albumListView?.showLoadingIndicator()
            albumListService.fetchAlbumList(forQuery: query) {[unowned self] (results, hasError) in
                DispatchQueue.main.async() {[unowned self] in
                    self.albumListView?.hideLoadingIndicator()
                    if hasError {
                        self.albumListView?.searchDidFail()
                    } else {
                        self.albumListView?.showAlbumsList(for: results)
                    }
                }
            }
        } else {
            DispatchQueue.main.async() {[unowned self] in
                self.albumListView?.showNetworkError()
            }
        }
    }
}
