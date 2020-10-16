//
//  SigningAlphabetService.swift
//  test
//
//  Created by Robert Lizardi on 8/10/20.
//

import Foundation

class SigningAlphabetService {
    static let sharedInstance = SigningAlphabetService()
    
    private init() { }
    
    func getLetter(hand: SigningHand) -> String {
        if !hand.isValid() {
            return "unknown"
        }
        
        if isA(hand: hand) { return "a" }
        if isB(hand: hand) { return "b" }
        if isD(hand: hand) { return "d" }
        if isE(hand: hand) { return "e" }
        if isF(hand: hand) { return "f" }
        if isI(hand: hand) { return "i" }
        if isL(hand: hand) { return "l" }
        if isM(hand: hand) { return "m" }
        if isN(hand: hand) { return "n" }
        
        if isY(hand: hand) { return "y"   }
        
        
        return "unknown"
    }
    
    private func isA(hand: SigningHand) -> Bool {
        return hand.areFingersAligned(fingers: [.pinky, .ring, .middle, .index, .thumb]) && hand.thumbIsUp() && hand.fingerTipsUnderMCP(fingers: [.pinky, .ring, .middle, .index])
    }
    
    private func isB(hand: SigningHand) -> Bool {
        return hand.areFingersAligned(fingers: [.pinky, .ring, .middle, .index]) && hand.thumbIsAcross() && hand.areFingersUp(fingers: [.pinky, .ring, .middle, .index])
    }
    
    //TODO: DEFINE WHAT MAKES C
    private func isC(hand: SigningHand) -> Bool {
        return false
    }
    
    //TODO: ADD THUMB IS CLOSE TO MIDDLE TIP ARETOUCHING
    private func isD(hand: SigningHand) -> Bool {
        return hand.fingerTipsUnderMCP(fingers: [.pinky, .ring, .middle]) && hand.areFingersUp(fingers: [.index]) && hand.thumbIsAcross()
    }
    
    private func isE(hand: SigningHand) -> Bool {
        return hand.fingerTipsUnderMCP(fingers: [.pinky, .ring, .middle, .index]) && hand.thumbIsAcross()
    }
    
    private func isF(hand: SigningHand) -> Bool {
        return hand.areFingersUp(fingers: [.pinky, .ring, .middle]) && hand.thumbIsUp() && hand.fingerTipsUnderMCP(fingers: [.index])
    }
    
    private func isI(hand: SigningHand) -> Bool {
        return hand.areFingersUp(fingers: [.pinky]) && hand.fingerTipsUnderMCP(fingers: [.ring, .middle, .index]) && hand.thumbIsAcross()
    }
    
    private func isL(hand: SigningHand) -> Bool {
        return hand.fingerTipsUnderMCP(fingers: [.pinky, .ring, .middle]) && hand.areFingersUp(fingers: [.index]) && hand.thumbIsAcross(direction: .rtl)
    }
    
    private func isM(hand: SigningHand) -> Bool {
        return hand.fingerTipsUnderMCP(fingers: [.pinky, .ring, .middle, .index]) && hand.thumbIsAcross() && hand.fingerUnder(coveringFingers: [.ring, .middle, .index], coveredFinger: .thumb)
    }
    
    private func isN(hand: SigningHand) -> Bool {
        return hand.fingerTipsUnderMCP(fingers: [.pinky, .ring, .middle, .index]) && hand.thumbIsAcross() && hand.fingerUnder(coveringFingers: [.middle, .index], coveredFinger: .thumb)
    }
    
    private func isY(hand: SigningHand) -> Bool {
        return hand.areFingersUp(fingers: [.pinky, .thumb]) && hand.fingerTipsUnderMCP(fingers: [.ring, .middle, .index])
    }
}
