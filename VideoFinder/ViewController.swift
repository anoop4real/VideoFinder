//
//  ViewController.swift
//  VideoFinder
//
//  Created by anoopm on 20/06/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {

    let videoStore = VideoStore()
    var currentVideoId: String!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var videoCollectionView: UICollectionView!

    var searchController: UISearchController!
    var isSearching: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSearchView() {

    // Initialize and set up the search controller
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
        self.present(searchController, animated: true) {

        }

    }

    func updateSearchResults(for searchController: UISearchController) {
        searchWithText(text: searchController.searchBar.text!)
    }
    // MARK: Searchbar Delegate

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

        self.isSearching = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        self.isSearching = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        self.isSearching = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchWithText(text: searchBar.text!)
    }
    func searchWithText( text: String) {
        self.isSearching = false
        // searchBar.resignFirstResponder()
        self.videoStore.searchMovieDataWithKeyWord(text, year: "") { (success) -> Void in
            if(success) {
                // Reload collectionview after fetch is complete
                DispatchQueue.main.async {

                    self.videoCollectionView.reloadData()
                    self.searchController?.dismiss(animated: true, completion: {

                    })
                }
            }
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: Collectionview delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videoStore.videoArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell {

            cell.configureCellWithData(self.videoStore.videoArray[(indexPath as NSIndexPath).row])
            return cell
        } else {
            return VideoCollectionViewCell()
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = self.videoStore.videoArray[(indexPath as NSIndexPath).row]
        self.currentVideoId = video.imdbId
        self.performSegue(withIdentifier: "showDetails", sender: self)
        
        // API to fetch details of video
        //        self.videoStore.searchVideoBy(video.imdbId, includeRottenTomatoRatings: true) { (success) -> Void in
        //
        //        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 240)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 50.0)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! VideoDetailsViewController
        destinationController.videoId = self.currentVideoId
    }
}

extension ViewController: UISearchBarDelegate {
    
}
