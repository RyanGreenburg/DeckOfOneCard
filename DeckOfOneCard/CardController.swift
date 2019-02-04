//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by RYAN GREENBURG on 2/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

class CardController {
    //CRUD
    
    //Base URL
    private static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    
    //Create
    static func drawCard(numberOfCards: Int, completion: @escaping ((_ cards: [Card]) -> Void)) {
        //build URL
        guard let url = baseURL else { fatalError("URL could not be found") }
    
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let countQueryItem = URLQueryItem(name: "count", value: "\(numberOfCards)")
        components?.queryItems = [countQueryItem]
        
        // Build request
        guard let requestURL = components?.url else { return }
        print(requestURL)
        
        //Get my data
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        //Data task
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            do {
            if let downloadError = error { throw downloadError }
            guard let data = data else { throw NSError() }
            // Decode
            let jsonDecoder = JSONDecoder()
            let deck = try! jsonDecoder.decode(Deck.self, from: data)
            completion(deck.cards)
                
            } catch {
                print("Error retrieving cards from \(requestURL)")
                completion([])
                return
            }
        }
        dataTask.resume()
    }
}
