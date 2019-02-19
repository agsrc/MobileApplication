//
//  YelpItemsViewController.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/14/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import AlamofireImage


var landmarks = [Landmark]()

var landmarkNames = [String]()
var landmarkImages = [String]()
var landmarkLatitude = [Double]()
var landmarkLongititude = [Double]()
var landmarkRating = [float_t]()
var landmarkAddress = [String]()

var check = ""
var landmarkDetails : [LandmarkDetails] = []

class YelpItemsViewController: UIViewController {

    @IBOutlet weak var yelpTableView: UITableView!
    
    let cellID="YelpTableViewCell"
    let name = "Landmarks"
    let sequeIdentifier = "segYelpFav"
    let loading="Loading"
    
    // object of yelpAPIManager
    let yelpAPI = YelpAPIManager()
    
    
    func clearLandmarks() {
        landmarkNames.removeAll()
        landmarkImages.removeAll()
        landmarkLatitude.removeAll()
        landmarkLongititude.removeAll()
        landmarkRating.removeAll()
        landmarkAddress.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        yelpTableView.delegate = self as UITableViewDelegate
        yelpTableView.dataSource = self as UITableViewDataSource
        
        clearLandmarks()
        
        // to load
        SVProgressHUD.show(withStatus: loading)
        
        callYelp()
    }
        // fetching landmarks
        func callYelp(){
            yelpAPI.fetchlandmarks(selectedStation: metroStationNames[currentRowIndex], selectedLat: sLat[currentRowIndex], selectedLon: sLon[currentRowIndex]) { (results:yelpData) in
                
                for val in results.businesses{
                    
                    landmarkNames.append(val.name!)
                    landmarkDetails.append(LandmarkDetails(landmarkname: val.name!, landmarkurl: val.image_url!))
                    landmarkImages.append(val.image_url!)
                    landmarkRating.append(val.rating!)
                    landmarkLatitude.append(val.coordinates.latitude!)
                    landmarkLongititude.append(val.coordinates.longitude!)
                    print(landmarkAddress)
                    print(val.location?.address1)
                    print(val.location?.city)
                    landmarkAddress.append((val.location?.address1)! + " " + (val.location?.city)!)
                }
                
                SVProgressHUD.dismiss()
                
                DispatchQueue.main.async{
                    self.yelpTableView.reloadData()
            }
        }
    }
}
    // delegating cell filling task
    extension YelpItemsViewController:UITableViewDataSource , UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return landmarkNames.count
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            currentRowIndex=indexPath.row
            performSegue(withIdentifier: sequeIdentifier, sender: self)
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! YelpItemsTableViewCell
            
            cell .YelpLabel.text=landmarkNames[indexPath.row]
           
           // loading image
            Alamofire.request(landmarkImages[indexPath.row]).responseImage(completionHandler: { response in
                
                if let image = response.result.value{
                    DispatchQueue.main.async {
                        cell.YelpImage.image=image
                    }
                }
            }
        )
            
            return cell
    }
        
        
        
}

  


