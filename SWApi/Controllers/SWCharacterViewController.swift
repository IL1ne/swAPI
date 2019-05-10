//
//  SWCharacterViewController.swift
//  SWApi
//
//  Created by IL1ne on 18/04/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import UIKit
import RealmSwift

class SWCharacterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var genderlabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var homeWorldLabel: UILabel!
    @IBOutlet weak var speciesTableView: UITableView!
    @IBOutlet weak var relatedFilmsTableView: UITableView!
    
    var currentCharacterInfo = SWPeopleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        characterNameLabel.text = currentCharacterInfo.name
        genderlabel.text = currentCharacterInfo.gender
        birthDateLabel.text = currentCharacterInfo.birthYear
        
        let realm = try! Realm()
        if let homeWorldName = realm.object(ofType: SWPlanetModel.self, forPrimaryKey: currentCharacterInfo.homeworld) {
            homeWorldLabel.text = homeWorldName.name
        }
        
        speciesTableView.delegate = self
        speciesTableView.dataSource = self
        
        relatedFilmsTableView.delegate = self
        relatedFilmsTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch  tableView {
        case self.speciesTableView:
            return currentCharacterInfo.species.count
        case self.relatedFilmsTableView:
            return currentCharacterInfo.films.count
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        switch  tableView {
        case self.speciesTableView:
            let cell = speciesTableView.dequeueReusableCell(withIdentifier: Constants.cellId2, for: indexPath) as! SWSpeciesTableViewCell
            let realm = try! Realm()
            let speciesInfo = currentCharacterInfo.species[indexPath.row]
            if let curCell = realm.object(ofType: SWSpeciesModel.self, forPrimaryKey: speciesInfo) {
                cell.textLabel?.text = curCell.name
            }
            return cell
            
        case self.relatedFilmsTableView:
            let cell = relatedFilmsTableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! SWCharacterFilmsTableViewCell
            let realm = try! Realm()
            let filmInfo = currentCharacterInfo.films[indexPath.row]
            if let curCell = realm.object(ofType: SWFilmModel.self, forPrimaryKey: filmInfo) {
                cell.set(episodeIdLabel: "\(curCell.episode_id)", episodeTitle: curCell.title)
            }
            return cell
        default:
            print("fail")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch  tableView {
        case self.relatedFilmsTableView:
            let filmPrimaryKey = currentCharacterInfo.films[indexPath.row]
            let realm = try! Realm()
            if let specificFilm = realm.object(ofType: SWFilmModel.self, forPrimaryKey: filmPrimaryKey) {
                pushToInfo(model: specificFilm)
            }
        default:
            print("fail")
        }
    }
    
    func pushToInfo(model: SWFilmModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWFilmInfoViewController") as! SWFilmInfoViewController
        vc.currentEpisodeInfo = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

enum Constants {
    static let cellId = "filmsCharacterCell"
    static let cellId2 = "speciesCell"
}
