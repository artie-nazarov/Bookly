//
//  BookShopTableViewController.swift
//  Bookly
//
//  Created by Artem Nazarov on 1/24/17.
//  Copyright © 2017 APPSkill. All rights reserved.
//

import UIKit

var searchActive = false

var searchedTitle:String!

class BookShopTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let us = UserDefaults.standard.object(forKey: "shopLibrary"){
            let decoded  = us as! Data
            let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [BookDataStructure]
            bookLibraryArray = decodedArray
        
        if let bal = UserDefaults.standard.object(forKey: "balance") as? Int {
            balance = bal
        }

        }
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func filterContentForSearchText(searchText: String) {
        
     
            filteredArrays = bookLibraryArray.filter({ $0.title.lowercased().contains(searchText.lowercased())   })
        
        tableView.reloadData()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        let backgroundImage = UIImage(named: "darkenedBG")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        imageView.contentMode = .scaleAspectFill
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSections = 1
        if bookLibraryArray.isEmpty
        {
            let backgroundImage = UIImage(named: "darkenedBG")
            let imageView = UIImageView(image: backgroundImage)
            imageView.contentMode = .scaleAspectFill
            
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "There are no available books at the moment"
            noDataLabel.textColor     = UIColor.purple
            
            noDataLabel.textAlignment = .center
            imageView.addSubview(noDataLabel)
            tableView.backgroundView  = imageView
            tableView.separatorStyle  = .none
            numberOfSections = 0
        }
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredArrays.count
        }
        return bookLibraryArray.count
        }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShopTableViewCell
        var dataArray = bookLibraryArray[(indexPath as NSIndexPath).row]
        
        if searchController.isActive && searchController.searchBar.text != "" {
            dataArray = filteredArrays[(indexPath as NSIndexPath).row]
            searchActive = true
        } else {
            dataArray = bookLibraryArray[(indexPath as NSIndexPath).row]
            searchActive = false
        }
        
        cell.bookName.text = dataArray.title
        cell.bookAuthor.text = dataArray.author
        cell.bookImage.image = dataArray.image
        cell.bookPrice.text = String(format: "Price : %d", dataArray.price)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrayId = (indexPath as NSIndexPath).row
        if searchActive{
        searchedTitle = filteredArrays[(indexPath as NSIndexPath).row].title
        }
        print(arrayId)
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
   
}

extension BookShopTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
   }
