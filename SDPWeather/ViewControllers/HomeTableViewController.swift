//
//  HomeTableViewController.swift
//  SDPWeather
//
//  Created by Errabelli Anil on 24/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
        
    
    //MARK:- Properties
    
    var filteredArray = [[String:Any]]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var query = String()
    

    //MARK:- ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        configureSearchController() // Config Controller in VC
                
    }
    
    //MARK:- VC Methods

    @objc func loadListOfCities(_ searchBar: UISearchBar) {

            let session = URLSession.shared
        let urlString = "http://api.worldweatheronline.com/premium/v1/search.ashx?num_of_results=10&format=json&key=e6b8915fb40d45dd93b50608192412&query=\(searchBar.text ?? "")"
            let url = URL(string: urlString)!

            let task = session.dataTask(with: url) { data, response, error in

                if error != nil || data == nil {
                    print("Client error!")
                    return
                }

                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }

                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }

                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    print(json)
                    
                    guard json.value(forKeyPath: "search_api") != nil else {
                        print("Unable to find any matching weather location to the query submitted!")
                        return
                    }


                    self.filteredArray = json.value(forKeyPath: "search_api.result") as! [[String:Any]]
                    
                    DispatchQueue.main.async {
                        //Do UI Code here.
                        self.tableView.reloadData()
                    }

                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }

            task.resume()
        }


        func configureSearchController() {
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.placeholder = "Search here..."
            searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
            searchController.searchBar.sizeToFit()

            tableView.tableHeaderView = searchController.searchBar
        }
    
    //MARK:- search update delegate

    public func updateSearchResults(for searchController: UISearchController){
        let _ = searchController.searchBar.text
        tableView.reloadData()
    }

    //MARK:- search bar delegate

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // to limit network activity, reload half a second after last key press.
         NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.loadListOfCities(_:)), object: searchBar)
         perform(#selector(self.loadListOfCities(_:)), with: searchBar, afterDelay: 0.75)
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
        return filteredArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let  areaArray = filteredArray[0]["areaName"] as! [[String:Any]]

        cell.textLabel?.text = areaArray[0]["value"] as? String

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
//        weatherDetailViewController.city = cities[index]
//        weatherDetailViewController.city = cities[index]
    }
    
}
