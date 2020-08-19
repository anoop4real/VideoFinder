//
//  VideoDetailsViewController.swift
//  VideoFinder
//
//  Created by anoopm on 02/07/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

import UIKit

class VideoDetailsViewController: UIViewController {

    let videoStore = VideoStore()
    var videoId: String!

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        detailTableView.delegate = self
        detailTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        self.videoStore.searchVideoBy(self.videoId, includeRottenTomatoRatings: true) { (_) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                self.detailTableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            })

        }
    }

}

extension VideoDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.videoStore.videoDetailsDict.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoDetail", for: indexPath)
        
        let key = Array(self.videoStore.videoDetailsDict.keys)[(indexPath as NSIndexPath).row]
        if let property = self.videoStore.videoDetailsDict[key] as? String {
            cell.textLabel?.text = key
            cell.detailTextLabel?.text = property
        }
        
        return cell
    }
}
