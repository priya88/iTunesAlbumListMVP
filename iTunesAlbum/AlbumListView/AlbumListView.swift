//
//  IAlbumList.swift
//  iTunesAlbum
//
//  Created by Priyanka Saroha on 10/26/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import Foundation

protocol AlbumListView {
    
    /// shows album list
    ///
    /// - Parameter results: list of albums
    func showAlbumsList(for results: [Album])
    
    /// Get called if search get fails or error during/after search
    func searchDidFail()
    
    /// Get called if no network connection
    func showNetworkError()
    
    /// Get called to show loading indicator for albums
    func showLoadingIndicator()
    
    /// Get called to hide loading indicator
    func hideLoadingIndicator()
}
