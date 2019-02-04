//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by RYAN GREENBURG on 2/4/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func drawCard() {
        CardController.drawCard(numberOfCards: 1) { (cards) in
            let card = cards[0]
            CardController.image(forURL: card.image, completion: { (cardImage) in
                guard let image = cardImage else { return }
                self.cardImageView.image = image
            })
        }
    }
    
    @IBAction func drawCardButtonTapped(_ sender: Any) {
        drawCard()
    }
}
