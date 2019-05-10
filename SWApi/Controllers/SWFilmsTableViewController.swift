//
//  MoviesTableViewController.swift
//  SWApi
//
//  Created by IL1ne on 21/03/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class SWFilmsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GET entries from API
        fetchAllFilms()
        fetchAllPeople()
        fetchAllPlanets()
    }

    // MARK: - Table view data source

 
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    var films = try! Realm().objects(SWFilmModel.self)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! SWFilmsTableViewCell

        let curCell = films[indexPath.row]
        // Configure the cell...
        cell.set(episodeIdLabel: "\(curCell.episode_id)", episodeTitle: curCell.title)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToInfo(model: films[indexPath.row])
    }
 
    func pushToInfo(model: SWFilmModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWFilmInfoViewController") as! SWFilmInfoViewController
        vc.currentEpisodeInfo = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    enum Constants {
        static let cellId = "filmsCell"
    }

}

