//
//  VideoCollectionViewCell.swift
//  VideoFinder
//
//  Created by anoopm on 25/06/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    func configureCellWithData(_ videoData: Video) {

        if let videoTitle = videoData.title {

            self.titleLabel.text = videoTitle
        }
        if let posterPath = videoData.posterURL {
            if(posterPath.isValidForUrl()) {
                if(posterPath == "N/A") {

                    posterImageView.alpha = 1
                    return
                }
                let url = URL(string: posterPath)

                if let image = url?.cachedImage {
                    posterImageView.image = image
                    posterImageView.alpha = 1
                } else {

                    posterImageView.alpha = 0

                    url?.fetchImage({ (image) -> Void in
                        self.posterImageView.image = image
                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                            self.posterImageView.alpha = 1
                        })
                    })

                }

            } else {
                print("Invalid URL set default image")
                posterImageView.image = UIImage(named: "CollectionImage")
                posterImageView.alpha = 1
            }

        }
    }

}
