//
//  SearchViewController.swift
//  SWApi
//
//  Created by IL1ne on 21/03/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UITableViewController, UISearchResultsUpdating {

    let characters = try! Realm().objects(SWPeopleModel.self)
    var dataTable = [String]()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
//    var selectedCharacterInfo = SWPeopleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(characters)
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        tableView.reloadData()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
       
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            let countOfCharacter = characters.count
            return countOfCharacter
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! SWSearchTableViewCell
        
        if (resultSearchController.isActive) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            return cell
        }
        else {
            cell.textLabel?.text = characters[indexPath.row].name
            return cell
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll()
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        for character in characters {
            dataTable.append(character.name)
        }
        let filteredCharacters = (dataTable as NSArray).filtered(using: searchPredicate)
        
        for people in filteredCharacters as! [String]{
            filteredTableData.append(people)
        }
        
        dataTable.removeAll()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  (resultSearchController.isActive) {
            let Char = filteredTableData[indexPath.row]
//            print()
//            let predicate = NSPredicate(format: )
            
            let selectedCharacter = try! Realm().objects(SWPeopleModel.self).filter ("name == '\(Char)'")
            print(selectedCharacter[0])
            let selectedCharacterInfo = selectedCharacter[0]
            pushToInfo(model: selectedCharacterInfo)
            
            
        } else {
            let selectedCharacterInfo = characters[indexPath.row]
            pushToInfo(model: selectedCharacterInfo)
        }
        
        
        
    }
    
    func pushToInfo(model: SWPeopleModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWCharacterViewController") as! SWCharacterViewController
        vc.currentCharacterInfo = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    enum Constants {
        static let cellId = "searchCell"
    }


}
