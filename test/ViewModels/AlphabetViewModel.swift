//
//  AlphabetViewModel.swift
//  test
//
//  Created by Robert Lizardi on 8/10/20.
//

import Foundation

class AlphabetViewModel {
    var hand: SigningHand?
    
    func getSign() -> String {
        if let hand = hand {
            return SigningAlphabetService.sharedInstance.getLetter(hand: hand)
        } else { return "unknown" }
    }
}
