//
//  StationsTableViewController.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/13/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import UIKit

// variables
var currentRowIndex=0
var metroStationNames = [String]()
var sLat = [Double]()
var sLon = [Double]()


class StationsTableViewController: UITableViewController {

    // object of WmataAPIManager
    let wmataR = WmataAPIManager()
    
    // paramters to use below
    let tableCellIndex = "TCI"
    let name = "MetroStations"
    let sequeID = "seg2-yelp"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  additional setup after loading the view.
        navigationItem.title = name
        navigationController?.navigationBar.prefersLargeTitles=true
        
        // registerning cell to table
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableCellIndex)
        
        metroStationNames.removeAll()
        sLat.removeAll()
        sLon.removeAll()
        
        
        
        // to fetch station information from WMATA's API
        wmataR.fetchMetroStation(){(results:Stations) in
            for value in results.Stations{
                metroStationNames.append(value.Name!)
                sLat.append(value.Lat!)
                sLon.append(value.Lon!)
            }
            DispatchQueue.main.async{
                
                self.tableView.reloadData()
            }
            for name in metroStationNames{
                
                print(name)
            }
        }
    }
    
    // based on number of metroStationNames number of rows would be selected.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metroStationNames.count
    }
    
    // returns (tableViewCell-- with row representation)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: tableCellIndex, for: indexPath)
        let name=metroStationNames[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    // select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRowIndex=indexPath.row
        performSegue(withIdentifier: sequeID, sender: self)
    }

}
