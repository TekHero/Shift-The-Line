//
//  GameManager.swift
//  Shift The Line
//
//  Created by Brian Lim on 6/25/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit

class GameManager {
    
    static let instance = GameManager()
    private init() {}
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    // Saving and Grabbing highscores
    func setHighscore(highscore: Int) {
        NSUserDefaults.standardUserDefaults().setInteger(highscore, forKey: "HIGHSCORE")
    }
    
    func getHighscore() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey("HIGHSCORE")
    }
}