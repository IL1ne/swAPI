//
//  SWFilmInfoViewController.swift
//  SWApi
//
//  Created by IL1ne on 04/04/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import UIKit
import RealmSwift

class SWFilmInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var episodeIdLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeCrawlLabel: UILabel!
    @IBOutlet weak var episodeDirectorLabel: UILabel!
    @IBOutlet weak var episodeReleaseDateLabel: UILabel!
    @IBOutlet weak var charactersTableView: UITableView!
    var currentEpisodeInfo = SWFilmModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeIdLabel.text = "\(currentEpisodeInfo.episode_id)"
        episodeTitleLabel.text = currentEpisodeInfo.title
        episodeCrawlLabel.text = currentEpisodeInfo.opening_crawl
        episodeDirectorLabel.text = currentEpisodeInfo.director
        episodeReleaseDateLabel.text = currentEpisodeInfo.release_date
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        charactersTableView.reloadData()
    }
    
    func tableView(_ charactersTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentEpisodeInfo.characters.count
    }
    
    func tableView(_ charactersTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! SWCharacterTableViewCell
        let peoplePrimaryKey = currentEpisodeInfo.characters[indexPath.row]
        let realm = try! Realm()
        let specificPerson = realm.object(ofType: SWPeopleModel.self, forPrimaryKey: peoplePrimaryKey)
        if let characterName = specificPerson?.name {
            cell.set(characterName: characterName)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let peoplePrimaryKey = currentEpisodeInfo.characters[indexPath.row]
        let realm = try! Realm()

        if let specificPerson = realm.object(ofType: SWPeopleModel.self, forPrimaryKey: peoplePrimaryKey) {
            pushToInfo(model: specificPerson)
        }
    }
    
    func pushToInfo(model: SWPeopleModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWCharacterViewController") as! SWCharacterViewController
        vc.currentCharacterInfo = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    enum Constants {
        static let cellId = "characterCell"
    }
}
