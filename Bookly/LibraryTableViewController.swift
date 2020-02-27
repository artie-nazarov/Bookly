//
//  LibraryTableViewController.swift
//  Bookly
//
//  Created by Artem Nazarov on 2/13/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit
 var filteredArrays = [BookDataStructure]()

class LibraryTableViewController: UITableViewController {
    
    var brain = LimitsBrain()
    
    let searchController = UISearchController(searchResultsController: nil)
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let us = UserDefaults.standard.object(forKey: "purchasedArray"){
            let decoded  = us as! Data
            let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [BookDataStructure]
             purchasedLibraryArray = decodedArray
            brain.setAfterSleep()

            
            if (brain.functionRunning) && (buttonSetLimitsIsVisible == false) {
                
                brain.timerStarter()
                
            }
            
            
        }
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String) {
        
        
        filteredArrays = purchasedLibraryArray.filter({ $0.title.lowercased().contains(searchText.lowercased())   })
        
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     tableView.reloadData()
        let backgroundImage = UIImage(named: "darkenedBG")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        imageView.contentMode = .scaleAspectFill
        tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        var numberOfSections = 1
        if purchasedLibraryArray.isEmpty
        {
            let backgroundImage = UIImage(named: "darkenedBG")
            let imageView = UIImageView(image: backgroundImage)
            imageView.contentMode = .scaleAspectFill

            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "You didn't purchase anything yet"
            noDataLabel.textColor = UIColor.purple
            
            noDataLabel.textAlignment = .center
            imageView.addSubview(noDataLabel)
            tableView.backgroundView  = imageView
            tableView.separatorStyle  = .none
            numberOfSections = 0
        }
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredArrays.count
        }
        
        return purchasedLibraryArray.count    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LibraryTableViewCell
        
        var dataArray = purchasedLibraryArray[(indexPath as NSIndexPath).row]
        
        if searchController.isActive && searchController.searchBar.text != "" {
            dataArray = filteredArrays[indexPath.row]
            searchActive = true
        } else {
            dataArray = purchasedLibraryArray[(indexPath as NSIndexPath).row]
            searchActive = false
        }
        cell.bookTitle.text = dataArray.title
        cell.bookAuthor.text = dataArray.author
        cell.bookImage.image = dataArray.image
       
        if dataArray.finishedReading {
            cell.progressImage.image = UIImage(named:"Checked Checkbox Filled-100")!
        }
        else if dataArray.inTheMiddleOfReading{
        cell.progressImage.image = UIImage(named:"Unchecked Checkbox FilledGreen-100")!
            }
        else {
        cell.progressImage.image = UIImage(named:"Unchecked Checkbox FilledRED-100")!
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive
        {
        searchedTitle = purchasedLibraryArray[(indexPath as NSIndexPath).row].title
        }
        
        libararyId = (indexPath as NSIndexPath).row
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
}

extension LibraryTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
