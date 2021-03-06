//
//  HomeTableViewController.swift
//  SDPWeather
//
//  Created by Errabelli Anil on 24/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    // MARK: - Properties

    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var searchResults: [ResultsOfCities]?
    var searchedCities = [[String: Any]]()

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        configureSearchController() // Config Controller in VC

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let loadedCart = UserDefaults.standard.array(forKey: "searchedCities") as? [[String: Any]] {
            print(loadedCart as Any)
            searchedCities = loadedCart
            
            tableView.reloadData()
        }

    }

    // MARK: - VC Methods

    @objc func loadListOfCities(_ searchBar: UISearchBar) {

//            let session = URLSession.shared
//        let urlString = "http://api.worldweatheronline.com/premium/v1/search.ashx?num_of_results=10&format=json&key=e6b8915fb40d45dd93b50608192412&query=\(searchBar.text ?? "")"
//            let url = URL(string: urlString)!
//
//            let task = session.dataTask(with: url) { data, response, error in
//
//                if error != nil || data == nil {
//                    print("Client error!")
//                    return
//                }
//
//                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                    print("Server error!")
//                    return
//                }
//
//                guard let mime = response.mimeType, mime == "application/json" else {
//                    print("Wrong MIME type!")
//                    return
//                }
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
//                    print(json)
//
//                    guard json.value(forKeyPath: "search_api") != nil else {
//                        print("Unable to find any matching weather location to the query submitted!")
//                        return
//                    }
//
//
//                    self.filteredArray = json.value(forKeyPath: "search_api.result") as! [[String:Any]]
//
//                    DispatchQueue.main.async {
//                        //Do UI Code here.
//                        self.tableView.reloadData()
//                    }
//
//                } catch {
//                    print("JSON error: \(error.localizedDescription)")
//                }
//            }
//
//            task.resume()

        SearchManager.getCity(for: searchBar.text ?? "") { (searchCity) in
            
            DispatchQueue.main.async {
                self.searchResults = searchCity?.searchApi.result
                print(self.searchResults as Any)

                self.tableView.reloadData()

            }
        }

    }

        func configureSearchController() {
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.placeholder = "Search here..."
            searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
            searchController.searchBar.sizeToFit()

            tableView.tableHeaderView = searchController.searchBar
        }

    // MARK: - search update delegate

    public func updateSearchResults(for searchController: UISearchController) {
        _ = searchController.searchBar.text
        tableView.reloadData()
    }

    // MARK: - search bar delegate

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // to limit network activity, reload half a second after last key press.
        if searchText.count > 2 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.loadListOfCities(_:)), object: searchBar)
            perform(#selector(self.loadListOfCities(_:)), with: searchBar, afterDelay: 0.50)
        }

    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searchController.searchBar.text!.isEmpty {
            if searchResults == nil {
                return searchedCities.count
            } else {
                return searchResults?.count ?? 0
            }
        } else {
            return searchResults?.count ?? 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if searchController.searchBar.text!.isEmpty {
            if searchResults == nil {
                let  city = "\(searchedCities[indexPath.row]["cityName"] ?? "")  , \(searchedCities[indexPath.row]["country"] ?? "")"
                cell.textLabel?.text = city
                return cell
            } else {
                let  city = (searchResults?[indexPath.row].areaName[0].value)! + ", " + (searchResults?[indexPath.row].country[0].value)!
                cell.textLabel?.text = city
                return cell
            }
        } else {
            let  city = (searchResults?[indexPath.row].areaName[0].value)! + ", " + (searchResults?[indexPath.row].country[0].value)!
            cell.textLabel?.text = city
        }

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        guard let weatherDetailViewController = segue.destination as? CityWeatherViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
//        weatherDetailViewController.latLong = (searchResults?[index].latitude)! + "," + (searchResults?[index].longitude)!
//        weatherDetailViewController.city = searchResults?[index].areaName[0].value
        
        if searchResults == nil {
            weatherDetailViewController.cityDataDefaults = searchedCities[index]
            weatherDetailViewController.searched = false

        } else {
            weatherDetailViewController.cityData = searchResults?[index]
            weatherDetailViewController.searched = true
        }

    }

}
