//
//  NearestTableViewController.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/15/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD




class NearestTableViewController: UITableViewController {
    var  userLocation:CLLocation? = nil
    var userZipCode = ""
    
    func getStations() {
        
        
        SVProgressHUD.dismiss()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        
        
        // fetches station information from WMATA ApI
        wmata.fetchMetroStation(){(results:Stations) in
            
            
            metroStationNames.removeAll()
            
            
            let stationsSortedByDistance = results.Stations.sorted(
                by: {CLLocation(latitude: $0.Lat!, longitude: $0.Lon!)
                        .distance(from: self.userLocation ?? CLLocation(latitude: 0.0, longitude: 0.0))
                    
                    >
                    
                    CLLocation(latitude: $1.Lat!, longitude: $1.Lon!)
                        .distance(from: self.userLocation ?? CLLocation(latitude: 0.0, longitude: 0.0))} )
            
            if stationsSortedByDistance.count > 0 {
                self.nearestStationName = stationsSortedByDistance[0].Name!
                if self.nearestStationName != nil {
                    metroStationNames.append(self.nearestStationName!)
                    sLat.append(stationsSortedByDistance[0].Lat!)
                    sLon.append(stationsSortedByDistance[0].Lon!)
                }
            }
            
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            
        }
    }
    
    let wmata=WmataAPIManager()
    let locationDetector = LocationDetector()
    
    let cellID = "NearestCellID"
    let sequeIdentifier = "seg2"
    
    var nearestStationName:String? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationDetector.delegate = (self as LocationDetectorDelegate)
        locationDetector.findLocation()
        SVProgressHUD.show(withStatus: "Getting location...")

        
        
        navigationItem.title = "Nearest Station"
        navigationController?.navigationBar.prefersLargeTitles=true
        
        if(userLocation != nil){
            getStations()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        metroStationNames.removeAll()
        if nearestStationName != nil {
            metroStationNames.append(nearestStationName!)
        }
        tableView.reloadData()
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metroStationNames.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let name=metroStationNames[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRowIndex=indexPath.row
        performSegue(withIdentifier: sequeIdentifier, sender: self)
    }
    
    
    
    
    
    
}

extension NearestTableViewController: LocationDetectorDelegate {
    func locationNotDetected() {
        self.userZipCode = ""
        self.userLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        self.present(UIAlertController(title: "Error", message: "Could not detect location", preferredStyle: UIAlertController.Style.alert), animated: true)
    }
    
    func locationZipCode(zipcode: String) {
        self.userZipCode = zipcode
        
    }
    
    func locationDetected(latitude: Double, longitude: Double) {
        SVProgressHUD.dismiss()
        self.userLocation = CLLocation(latitude: latitude, longitude: longitude)
        DispatchQueue.main.async {
            self.getStations()
        }
        
    }
   
    
}
