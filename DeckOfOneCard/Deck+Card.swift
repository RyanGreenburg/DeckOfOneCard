//
//  Deck+Card.swift
//  DeckOfOneCard
//
//  Created by RYAN GREENBURG on 2/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

struct Deck: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let value: String
    let suit: String
    let image: String
}
