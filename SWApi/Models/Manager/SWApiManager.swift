//
//  SWApiManager.swift
//  SWApi
//
//  Created by IL1ne on 28/03/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift


// With Alamofire
func fetchAllFilms() {
    
    guard let url = URL(string: "https://swapi.co/api/films") else { return }
    Alamofire.request(url,
                      method: .get,
                      parameters: ["include_docs": "true"])
        .validate()
        .responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching films")
                
                return
            }
            if let value = response.result.value as? [String: Any]{
                
                if let filmsArray = value["results"] as? [NSDictionary] {
                    for film in filmsArray {
                        let realm = try! Realm()
                        try! realm.write({
                            
                            let entry = SWFilmModel()
                            entry.title = film["title"] as! String
                            entry.episode_id = film["episode_id"] as! Int
                            entry.opening_crawl = film["opening_crawl"] as! String
                            entry.director = film["director"] as! String
                            entry.producer = film["producer"] as! String
                            entry.release_date = film["release_date"] as! String
                            
                            entry.url = film["url"] as! String
                            
                            for char in film["characters"] as! [String]{
                                entry.characters.append(char)
                            }
                            realm.add(entry, update: true)
                        })
                    }
                    
                }
            }
    }
}

func fetchAllPeople() {
    
//    get count of People records
    guard let url = URL(string: "https://swapi.co/api/people") else { return }
    Alamofire.request(url,
                      method: .get,
                      parameters: ["include_docs": "true"])
        .validate()
        .responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching peoples")
                return
            }
            if let value = response.result.value as? [String: Any]{
                if let peoplesCount = value["count"] as? Int {
//                    fetch Info about all Peoples
                    for people in 1...peoplesCount {
//                        generate people unic url
                        let peopleUrl = "https://swapi.co/api/people/" + "\(people)"
//                        fetch info from Api and store in Realm
                        fetchCharacterInfo(characterUrl: peopleUrl)
                    }
                }
            }
    }
}


func fetchAllPlanets() {
    
    //    get count of Planet records
    guard let url = URL(string: "https://swapi.co/api/planets") else { return }
    Alamofire.request(url,
                      method: .get,
                      parameters: ["include_docs": "true"])
        .validate()
        .responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching planets")
                return
            }
            if let value = response.result.value as? [String: Any]{
                if let planetsCount = value["count"] as? Int {
                    //                    fetch Info about all Planet
                    for planet in 1...planetsCount {
                        //                        generate planet unic url
                        let planetUrl = "https://swapi.co/api/planets/" + "\(planet)"
                        //                        fetch info from Api and store in Realm
                        fetchPlanetInfo(planetUrl: planetUrl)
                    }
                }
            }
    }
}




// With Alamofire get information from API about 1 Character from direct URL
func fetchCharacterInfo(characterUrl:String) {
    guard let url = URL(string: "\(characterUrl)") else { return }
    Alamofire.request(url,
                      method: .get,
                      parameters: ["include_docs": "true"])
        .validate()
        .responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching character")
                return
            }
            if let value = response.result.value {
                if let charapterInfo = value as? NSDictionary {
                    
                    let realm = try! Realm()
                    try! realm.write({
                        let entry = SWPeopleModel()
                        entry.name = charapterInfo["name"] as! String
                        entry.gender = charapterInfo["gender"] as! String
                        entry.birthYear = charapterInfo["birth_year"] as! String
                        entry.homeworld = charapterInfo["homeworld"] as! String
                        for species in charapterInfo["species"] as! [String]{
                            entry.species.append(species)
                            fetchSpeciesInfo(specyUrl: species)
                        }
                        for film in charapterInfo["films"] as! [String]{
                            entry.films.append(film)
                        }
                        entry.url = charapterInfo["url"] as! String
                        realm.add(entry, update: true)
                    })
                }
            }
    }
}

// With Alamofire get information from API about 1 Planet from direct URL
func fetchPlanetInfo(planetUrl: String) {
    
    guard let url = URL(string: "\(planetUrl)") else { return }
    Alamofire.request(url,
                      method: .get,
                      parameters: ["include_docs": "true"])
        .validate()
        .responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching planet")
                return
            }
            if let value = response.result.value {
                if let planetInfo = value as? NSDictionary {
                    let realm = try! Realm()
                    try! realm.write({
                        let entry = SWPlanetModel()
                        entry.name = planetInfo["name"] as! String
                        entry.population = planetInfo["population"] as! String
                        entry.climate = planetInfo["climate"] as! String
                        entry.diameter = planetInfo["diameter"] as! String
                        entry.terrain = planetInfo["terrain"] as! String
                        entry.url = planetInfo["url"] as! String
                        realm.add(entry, update: true)
                    })
                }
                
            }
    }
}


// With Alamofire get information from API about 1 Species from direct URL
func fetchSpeciesInfo(specyUrl: String) {

    guard let url = URL(string: "\(specyUrl)") else { return}
    Alamofire.request(url,
                      method: .get,
                      parameters: ["include_docs": "true"])
        .validate()
        .responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching planet")
                return
            }
            if let value = response.result.value {
                if let speciesInfo = value as? NSDictionary {
                    let realm = try! Realm()
                    try! realm.write({
                        let entry = SWSpeciesModel()
                        entry.name = speciesInfo["name"] as! String
                        entry.url = speciesInfo["url"] as! String
                        realm.add(entry, update: true)
                    })
                }
            }
    }
}
