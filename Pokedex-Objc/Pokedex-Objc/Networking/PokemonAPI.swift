//
//  PokemonAPI.swift
//  Pokedex-Objc
//
//  Created by patelpra on 8/16/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

enum HTTPMethod: String, Error {
    case urlerror = "URLError"
    case dataerror = "DataError"
    case jsondecodeerror = "JSONDecodeError"
    case invalidresponse = "InvalidResponse"
    case networkerror = "NetworkError"
}

@objc(CRUPokemonAPI)
class PokemonAPI: NSObject {
    
    private let baseURLString = "https://pokeapi.co/api/v2/pokemon/"
    
    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    @objc(fetchAllPokemonWithCompletionHandler:)
    func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(string: baseURLString)
        urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "999"),
                                     URLQueryItem(name: "offset", value: "0")]
        
        guard let url = urlComponents?.url else {
            completion(nil, HTTPMethod.urlerror)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, HTTPMethod.dataerror)
                }
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw HTTPMethod.jsondecodeerror
                }
                
                guard let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                    throw HTTPMethod.dataerror
                }
                
                let pokemonArray = pokemonDictionaries.compactMap { Pokemon(dictionary: $0) }
                
                DispatchQueue.main.async {
                    completion(pokemonArray, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    @objc(fillInDetailsForPokemon:)
    func fillInDetails(for pokemon: Pokemon) {
        
        URLSession.shared.dataTask(with: pokemon.detailsURL!) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error fetching pokemon details: \(error)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    print("Error fetching pokemon details: \(HTTPMethod.dataerror)")
                }
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw HTTPMethod.jsondecodeerror
                }
                
                guard let pokemonDetails = PokemonDetail(dictionary: dictionary) else {
                    throw HTTPMethod.jsondecodeerror
                }
                
                DispatchQueue.main.async {
                    pokemon.details = pokemonDetails
                    self.fetchImage(for: pokemon, using: pokemonDetails.spriteURL!)
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error decoding pokemon details: \(error)")
                }
            }
        }.resume()
    }
    
    private func fetchImage(for pokemon: Pokemon, using url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error fetching pokemon image: \(error)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    print("Error fetching pokemon image: \(HTTPMethod.dataerror)")
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    print("Error decoding pokemon image: \(HTTPMethod.dataerror)")
                }
                return
            }
            
            DispatchQueue.main.async {
                pokemon.sprite = image
            }
        }.resume()
    }
}

