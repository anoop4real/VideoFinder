//
//  ViewController.swift
//  VideoFinder
//
//  Created by anoopm on 20/06/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let videoStore = VideoStore()
    
    
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var videoCollectionView:UICollectionView!
    
    var isSearching:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //Mark: Searchbar Delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        
        self.isSearching = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar){
        
        self.isSearching = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        
        self.isSearching = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        self.isSearching = false
       // searchBar.resignFirstResponder()
        self.videoStore.searchMovieDataWithKeyWord(searchBar.text!, year: "") { (success) -> Void in
            if(success){
                // Reload collectionview after fetch is complete
                dispatch_async(dispatch_get_main_queue()){
                    
                    self.videoCollectionView.reloadData()
                }
            }
        }
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        
    }
    
    // MARK: Collectionview delegates
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.videoStore.videoArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VideoCollectionViewCell", forIndexPath: indexPath) as? VideoCollectionViewCell{
            
            cell.configureCellWithData(self.videoStore.videoArray[indexPath.row])
            return cell
        }
        else
        {
            return VideoCollectionViewCell()
        }
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
//        let video = self.videoStore.videoArray[indexPath.row]
//        // API to fetch details of video
//        self.videoStore.searchVideoBy(video.imdbId, includeRottenTomatoRatings: true) { (success) -> Void in
//            
//        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(150, 240);
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 50.0)
    }
}

