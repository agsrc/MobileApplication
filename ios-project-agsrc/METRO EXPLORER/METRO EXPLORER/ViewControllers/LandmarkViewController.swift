//
//  LandmarkViewController.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/14/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MapKit

class LandmarkViewController: UIViewController {

    let sharingText = "Landmark "
    let sharingTextTwo = " YELP WILL RATE YOU "
    let name = " Details"
    let ratings = "Ratings : "
    
    @IBOutlet weak var imageOFLandmark: UIImageView!
    @IBOutlet weak var nameofLandmark: UILabel!
    @IBOutlet weak var phoneNumberOfLandmark: UILabel!
    @IBOutlet weak var addressOfLandmark: UILabel!
    
    // share information about the landmark
    @IBAction func shareInfo(_ sender: Any) {
        let shareText = sharingText + landmarkNames[currentRowIndex] + sharingTextTwo + landmarkRating[currentRowIndex].description
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    // Unfavorite a landmark
    @IBAction func unFav(_ sender: Any) {
        FavPersistenceManager.sharedInstance.remove(name: landmarkNames[currentRowIndex])
    }
    // Favorite a landmark
    @IBAction func Fav(_ sender: Any) {
        let myFav = Landmark(name: landmarkNames[currentRowIndex], url: landmarkImages[currentRowIndex], landmarkLat : landmarkLatitude[currentRowIndex], landmarkLong : landmarkLongititude[currentRowIndex], landmarkRating : landmarkRating[currentRowIndex] , landmarkAddress : landmarkAddress[currentRowIndex] )
        FavPersistenceManager.sharedInstance.saveFavoriteLandmarks(favorites: myFav)
    }
    
    @IBAction func redirectToMaps(_ sender: Any) {
        // apple map navigation
        let latitude:CLLocationDegrees = landmarkLatitude[currentRowIndex]
        let longitude:CLLocationDegrees = landmarkLongititude[currentRowIndex]
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeTransit] as [String : Any]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = landmarkNames[currentRowIndex]
        mapItem.openInMaps(launchOptions: options)
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        navigationItem.title = name
        navigationController?.navigationBar.prefersLargeTitles=false
        
        nameofLandmark.text=landmarkNames[currentRowIndex]
        
       // better response from image
        Alamofire.request(landmarkImages[currentRowIndex]).responseImage(completionHandler: {response in
            DispatchQueue.main.async {
                self.imageOFLandmark.image = response.result.value
            }
        }
        )
        
        phoneNumberOfLandmark.text = ratings + landmarkRating[currentRowIndex].description
        
        addressOfLandmark.text = landmarkAddress[currentRowIndex]
        
        
        
        
    }
    
    
    
    
}
