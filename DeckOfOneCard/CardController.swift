//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by RYAN GREENBURG on 2/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

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
    
    static func image(forURL urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Create URL
        guard let url = URL(string: urlString) else { return print("Error creating image URL")}
        // Data Task
        let imageDataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let imageError = error {
                print("Error retrieving image: \(imageError.localizedDescription)")
                completion(nil)
            }
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        imageDataTask.resume()
    }
}
