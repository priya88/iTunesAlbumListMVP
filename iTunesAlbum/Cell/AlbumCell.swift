//
//  AlbumCell.swift
//  iTunesAlbum
//
//  Created by Priyanka Saroha on 10/26/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var artworkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCell(forAlbum album: Album) {
        if let urlString = album.albumArtWorkUrlString  {
            URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
                guard let imageData = data, error == nil else { return }
                DispatchQueue.main.async() {[unowned self] in
                    self.artworkImageView.image = UIImage(data: imageData)
                }
                }.resume()
        }
        albumNameLabel.text = album.albumName
        releaseDateLabel.text = dateInReadableFormat(album.releaseDate.wrappedString())
    }
    
    func dateInReadableFormat(_ releaseDate: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: releaseDate)!
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        return dateFormatter.string(from: date)
    }
}
