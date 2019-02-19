//
//  FavoriteViewController.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/14/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favLandmarkTableView: UITableView!
    
    let cellID="FavsTableViewCell"
    let name = "Favorites"
    let sequeIdentifier = "seg3Fav"
    
      var fetchedFavLandmarks = FavPersistenceManager.sharedInstance.fetchFavLandmarks()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = name
        navigationController?.navigationBar.prefersLargeTitles=false
        
        favLandmarkTableView.delegate = self as UITableViewDelegate
        favLandmarkTableView.dataSource = self as UITableViewDataSource
        
        clearLandmarks()
        populateLandmarks(landmarks:fetchedFavLandmarks)
        
        favLandmarkTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // fetch favorite Landmarks
        
        fetchedFavLandmarks = FavPersistenceManager.sharedInstance.fetchFavLandmarks()
        
        super.viewWillAppear(animated)
        
        clearLandmarks()
        populateLandmarks(landmarks:fetchedFavLandmarks)
        
        favLandmarkTableView.reloadData()
       
        
        
    }
    
    
    
}

extension FavoriteViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ favLandmark: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  fetchedFavLandmarks.count
    }
    
    func tableView(_ favLandmark: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favLandmark.dequeueReusableCell(withIdentifier: cellID) as! FavsTableViewCell
        
        cell.favLandmarkName.text = fetchedFavLandmarks[indexPath.row].name
        
        Alamofire.request(fetchedFavLandmarks[indexPath.row].url).responseImage(completionHandler: { response in
            
            if let image = response.result.value{
                DispatchQueue.main.async {
                    cell.favLandmarkImage.image = image
                }
                
            }
            
        } )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRowIndex = indexPath.row
        performSegue(withIdentifier: sequeIdentifier, sender: self)
    }
    
    // reset list of landmarks (clear it)
    func clearLandmarks() {
        landmarkNames.removeAll()
        landmarkImages.removeAll()
        landmarkLatitude.removeAll()
        landmarkLongititude.removeAll()
        landmarkRating.removeAll()
        landmarkAddress.removeAll()
    }
    
    // fill landmark data from favorite landmarks
    func populateLandmarks(landmarks:[Landmark]) {
        for value in landmarks {
            landmarkNames.append(value.name)
            landmarkImages.append(value.url)
            landmarkRating.append(value.landmarkRating)
            landmarkLatitude.append(value.landmarkLat)
            landmarkLongititude.append(value.landmarkLong)
            landmarkAddress.append( value.landmarkAddress )
        }
        
    
    }

    
    
}
