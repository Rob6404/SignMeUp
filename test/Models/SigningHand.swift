//
//  SigningHand.swift
//  test
//
//  Created by Robert Lizardi on 8/10/20.
//

import Foundation
import Vision

enum FingerDirections {
    case ltr
    case rtl
}

enum FingerTypes {
    case pinky
    case ring
    case middle
    case index
    case thumb
}

class SigningHand {
    var fingerSpacingThreshold = 0.001
    var confidenceThreshold: Float = 0.3
    var thumbPoints: [VNRecognizedPointKey : VNRecognizedPoint]?
    var indexPoints: [VNRecognizedPointKey : VNRecognizedPoint]?
    var middlePoints: [VNRecognizedPointKey : VNRecognizedPoint]?
    var ringPoints: [VNRecognizedPointKey : VNRecognizedPoint]?
    var pinkyPoints: [VNRecognizedPointKey : VNRecognizedPoint]?
    
    init() { }
    
    init(thumb: [VNRecognizedPointKey : VNRecognizedPoint]?, index: [VNRecognizedPointKey : VNRecognizedPoint]?,
         middle: [VNRecognizedPointKey : VNRecognizedPoint]?, ring: [VNRecognizedPointKey : VNRecognizedPoint]?,
         pinky: [VNRecognizedPointKey : VNRecognizedPoint]?) {
        thumbPoints = thumb
        indexPoints = index
        middlePoints = middle
        ringPoints = ring
        pinkyPoints = pinky
    }
    
    //TODO: Figure out how to correctly judge fingers are pressed
    func areFingersTouching(fingers: [FingerTypes]) -> Bool {
        return false
    }
    
    ///Note, fingers must be consecutive, with no gaps
    func areFingersAligned(fingers: [FingerTypes]) -> Bool {
        if fingers.isEmpty || fingers.count == 1 { return true }
        
        if fingers.contains(.pinky) && fingers.contains(.ring) && !(pinkyPoints?[.handLandmarkKeyLittleTIP]?.x ?? 0.0 + fingerSpacingThreshold > ringPoints?[.handLandmarkKeyRingTIP]?.x ?? 0.0) {
            return false
        }
        if fingers.contains(.ring) && fingers.contains(.middle) && !(ringPoints?[.handLandmarkKeyRingTIP]?.x ?? 0.0 + fingerSpacingThreshold > middlePoints?[.handLandmarkKeyMiddleTIP]?.x ?? 0.0) {
            return false
        }
        if fingers.contains(.middle) && fingers.contains(.index) && !(middlePoints?[.handLandmarkKeyMiddleTIP]?.x ?? 0.0 + fingerSpacingThreshold > indexPoints?[.handLandmarkKeyIndexTIP]?.x ?? 0.0) {
            return false
        }
        if fingers.contains(.index) && fingers.contains(.thumb) && !(indexPoints?[.handLandmarkKeyIndexTIP]?.x ?? 0.0 + fingerSpacingThreshold > thumbPoints?[.handLandmarkKeyThumbTIP]?.x ?? 0.0) {
            return false
        }
        
        return true
    }
    
    //TODO: Make finger under finger method
    func fingerUnder(coveringFingers: [FingerTypes], coveredFinger: FingerTypes) -> Bool {
        return true
    }
    
    func fingerTipsUnderMCP(fingers: [FingerTypes]) -> Bool {
        if fingers.isEmpty { return true }
        
        if fingers.contains(.pinky) && !(pinkyPoints?[.handLandmarkKeyLittleTIP]?.y ?? 0 + fingerSpacingThreshold > pinkyPoints?[.handLandmarkKeyLittleMCP]?.y ?? 0.0) {
            return false
        }
        if fingers.contains(.ring) && !(ringPoints?[.handLandmarkKeyRingTIP]?.y ?? 0 + fingerSpacingThreshold > ringPoints?[.handLandmarkKeyRingMCP]?.y ?? 0.0 ) {
            return false
        }
        if fingers.contains(.middle) && !(middlePoints?[.handLandmarkKeyMiddleTIP]?.y ?? 0 + fingerSpacingThreshold > middlePoints?[.handLandmarkKeyMiddleMCP]?.y ?? 0.0) {
            return false
        }
        if fingers.contains(.index) && !(indexPoints?[.handLandmarkKeyIndexTIP]?.y ?? 0 + fingerSpacingThreshold > indexPoints?[.handLandmarkKeyIndexMCP]?.y ?? 0.0) {
            return false
        }
        return true
    }
    
    //TODO: FINISH
    func areFingersUp(fingers: [FingerTypes]) -> Bool {
        if fingers.contains(.pinky) && !(pinkyPoints?[.handLandmarkKeyLittleTIP]?.y ?? 0 - fingerSpacingThreshold < pinkyPoints?[.handLandmarkKeyLittleDIP]?.y ?? 0.0) {
            return false
        }
        if fingers.contains(.ring) && !(ringPoints?[.handLandmarkKeyRingTIP]?.y ?? 0 - fingerSpacingThreshold < ringPoints?[.handLandmarkKeyRingDIP]?.y ?? 0.0) {
            return false
        }
        if fingers.contains(.middle) && !(middlePoints?[.handLandmarkKeyMiddleTIP]?.y ?? 0 - fingerSpacingThreshold < middlePoints?[.handLandmarkKeyMiddleDIP]?.y ?? 0.0) {
            return false
        }
        if fingers.contains(.index) && !(indexPoints?[.handLandmarkKeyIndexTIP]?.y ?? 0 - fingerSpacingThreshold < indexPoints?[.handLandmarkKeyIndexDIP]?.y ?? 0.0) {
            return false
        }
        if fingers.contains(.thumb) && !(thumbPoints?[.handLandmarkKeyThumbTIP]?.y ?? 0 - fingerSpacingThreshold < thumbPoints?[.handLandmarkKeyThumbIP]?.y ?? 0.0) {
            return false
        }
        return true
    }
    
    //TODO: FINISH
    func fingersDirection() -> FingerDirections {
        return .ltr
    }
    
    //TODO: VERIFY VALIDITY REQUIRES ALL FINGERS PRESENT, AND VALIDATE CONFIDENCE LEVEL
    func isValid() -> Bool {
        return pinkyPoints != nil && ringPoints != nil && middlePoints != nil && indexPoints != nil && thumbPoints != nil
    }
    
    func isPointValid(point: VNRecognizedPoint?) -> Bool {
        return point != nil && point!.confidence > confidenceThreshold
    }
    
    func thumbIsUp() -> Bool {
        return thumbPoints?[.handLandmarkKeyThumbTIP]?.y ?? 0.0 - fingerSpacingThreshold < thumbPoints?[.handLandmarkKeyThumbIP]?.y ?? 0.0
    }
    
    func thumbIsAcross(direction: FingerDirections = .ltr) -> Bool {
        if direction == .rtl {
            return thumbPoints?[.handLandmarkKeyThumbTIP]?.x ?? 0.0 + fingerSpacingThreshold > thumbPoints?[.handLandmarkKeyThumbIP]?.x ?? 0.0
        }
        return thumbPoints?[.handLandmarkKeyThumbTIP]?.x ?? 0.0 - fingerSpacingThreshold < thumbPoints?[.handLandmarkKeyThumbIP]?.x ?? 0.0
    }
}
