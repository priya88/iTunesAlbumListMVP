//
//  AlbumsListController.swift
//  iTunesAlbum
//
//  Created by Priyanka Saroha on 10/26/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import UIKit
class AlbumsListController: UIViewController {
    @IBOutlet var albumsListTableView: UITableView!
    @IBOutlet weak var albumsLoadingIndicator: UIActivityIndicatorView!
    
    fileprivate let albumListPresenter = AlbumListPresenter(withService: AlbumListService())
    var albumsList = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         albumListPresenter.attachView(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AlbumsListController: UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumCell
        let album = albumsList[indexPath.row]
        cell.updateCell(forAlbum: album)
        return cell
    }
}

extension AlbumsListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = albumsList[indexPath.row]
        let primaryGenreNameInfo = GENRE_NAME + (selectedAlbum.primaryGenreName.wrappedString())
        let currencyInfo = CURRENCY + (selectedAlbum.currency.wrappedString())
        let trackPriceInfo = TRACK_PRICE + "\(selectedAlbum.trackPrice.wrappedFloat())"
        let moreInfoAlert = UIAlertController(title: "", message: "\(primaryGenreNameInfo) \n \(trackPriceInfo) \n \(currencyInfo)", preferredStyle: .alert)
        moreInfoAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(moreInfoAlert, animated: true)
    }
}

extension AlbumsListController: AlbumListView {
    func showLoadingIndicator() {
        albumsLoadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        albumsLoadingIndicator.stopAnimating()
    }
    
    func showAlbumsList(for results: [Album]) {
        albumsList = results
        albumsListTableView.reloadData()
    }
    
    func showNetworkError() {
        let noNetworkAlert = UIAlertController(title: NO_NET_CONNECTION_ALERT_TITLE, message: NO_NET_CONNECTION_ALERT_MESSAGE, preferredStyle: .alert)
        noNetworkAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(noNetworkAlert, animated: true)
    }
    
    func searchDidFail() {
        let albumSearchFailedAlert = UIAlertController(title: ALBUM_SEARCH_FAIL_ALERT_TITLE, message: ALBUM_SEARCH_FAIL_ALERT_MESSAGE, preferredStyle: .alert)
        albumSearchFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(albumSearchFailedAlert, animated: true)
    }
}

extension AlbumsListController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchString = searchBar.text  else {
            return
        }
        albumListPresenter.searchAlbumsForQuery(for: searchString)
    }
}

