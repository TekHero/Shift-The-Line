//
//  GameoverScene.swift
//  Shift The Line
//
//  Created by Brian Lim on 6/25/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class GameoverScene: SKScene, GKGameCenterControllerDelegate {
    
    var circle = SKSpriteNode()
    
    var blueBall = SKSpriteNode()
    var yellowBall = SKSpriteNode()
    var redBall = SKSpriteNode()
    var greenBall = SKSpriteNode()
    var separatorLine = SKSpriteNode()
    
    var retryBtn = SKLabelNode()
    var retryBtnDetector = SKSpriteNode()
    
    var scoreTitle = SKLabelNode()
    var scoreLbl = SKLabelNode()
    var recordTitle = SKLabelNode()
    var recordLbl = SKLabelNode()
    var titleLbl = SKLabelNode()
    
    var homeBtn = SKSpriteNode()
    var musicBtn = SKSpriteNode()
    var rateBtn = SKSpriteNode()
    var leaderboardBtn = SKSpriteNode()
    
    var userScore = 0
    var userHighscore = 0
    
    var shouldAnimate = false
    
    override func didMoveToView(view: SKView) {
        adShown += 1
        
        checkScore()
        initialize()
        waitBeforeShowingAd()
        
        if soundOn == true {
            
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOn")))
        } else {
            
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOff")))
        }
    }
    
    func initialize() {
        
        createCircle()
        createRedBall()
        createBlueBall()
        createGreenBall()
        createYellowBall()
        createSeparatorLine()
        createRetryBtn()
        createScoreTitleAndLabel()
        createRecordTitleAndLabel()
        createRetryBtnDetector()
        createTitleLbl()
        createHomeBtn()
        createRateBtn()
        createMusicBtn()
        createLeaderboardBtn()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location) == retryBtnDetector {
                
                playButtonTappedSound()
                let gameplay = GameplayScene(fileNamed: "GameplayScene")
                gameplay?.scaleMode = .AspectFill
                self.view?.presentScene(gameplay!, transition: SKTransition.fadeWithDuration(0.5))
            }
            
            if nodeAtPoint(location) == rateBtn {
                
                playButtonTappedSound()
                rateBtnPressed()
            }
            
            if nodeAtPoint(location) == musicBtn {
                
                playButtonTappedSound()
                soundBtnPressed()
            }
            
            if nodeAtPoint(location) == homeBtn {
                
                playButtonTappedSound()
                let mainMenu = MainMenuScene(fileNamed: "MainMenuScene")
                mainMenu?.scaleMode = .AspectFill
                self.view?.presentScene(mainMenu!, transition: SKTransition.fadeWithDuration(0.5))
            }
            
            if nodeAtPoint(location) == leaderboardBtn {
                
                playButtonTappedSound()
                leaderboardBtnPressed()
            }
        }
    }
    
    func checkScore() {
        
        // Checking to see if there is a integer for the key "SCORE"
        if let score: Int = NSUserDefaults.standardUserDefaults().integerForKey("SCORE") {
            userScore = score
            
            // Checking to see if there if a integer for the key "HIGHSCORE"
            if let highscore: Int = NSUserDefaults.standardUserDefaults().integerForKey("HIGHSCORE") {
                
                // If there is, check if the current score is greater then the value of the current highscore
                if score > highscore {
                    // If it is, set the current score as the new high score
                    GameManager.instance.setHighscore(score)
                    userHighscore = score
                    saveHighscore(score)
                    shouldAnimate = true
                    
                } else {
                    // Score is not greater then highscore
                }
            } else {
                // There is no integer for the key "HIGHSCORE"
                // Set the current score as the highscore since there is no value for highscore yet
                GameManager.instance.setHighscore(score)
                userHighscore = score
                saveHighscore(score)
                shouldAnimate = true
                
            }
        }
        
        // Checking to see if there a integer for the key "HIGHSCORE"
        if let highscore: Int = NSUserDefaults.standardUserDefaults().integerForKey("HIGHSCORE") {
            // If so, then set the value of this key to the userHighscore variable
            userHighscore = highscore
        }
        
    }
    
    func createTitleLbl() {
        
        titleLbl = SKLabelNode(fontNamed: "Gill Sans Light")
        titleLbl.name = "TitleLbl"
        titleLbl.fontSize = 160
        titleLbl.fontColor = SKColor.darkGrayColor()
        titleLbl.text = "YOU MISSED!"
        titleLbl.position = CGPoint(x: 0, y: 640)
        
        self.addChild(titleLbl)
    }
    
    func createSeparatorLine() {
        
        separatorLine = SKSpriteNode(color: SKColor.darkGrayColor(), size: CGSize(width: 450, height: 15))
        separatorLine.name = "Separator"
        separatorLine.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        separatorLine.zPosition = 1
        separatorLine.position = CGPoint(x: 0, y: 0)
        
        self.addChild(separatorLine)
    }
    
    func createCircle() {
        
        circle = SKSpriteNode(imageNamed: "Circle")
        circle.name = "Circle"
        circle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        circle.size = CGSize(width: 850, height: 850)
        circle.position = CGPoint(x: 0, y: 0)
        circle.zPosition = 1
        
        self.addChild(circle)
    }
    
    func createBlueBall() {
        
        blueBall = SKSpriteNode(imageNamed: "BlueBall")
        blueBall.name = "BlueBall"
        blueBall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        blueBall.size = CGSize(width: 90, height: 90)
        blueBall.position = CGPoint(x: 0, y: 370)
        blueBall.zPosition = 2
        
        self.addChild(blueBall)
    }
    
    func createYellowBall() {
        
        yellowBall = SKSpriteNode(imageNamed: "YellowBall")
        yellowBall.name = "YellowBall"
        yellowBall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        yellowBall.size = CGSize(width: 90, height: 90)
        yellowBall.position = CGPoint(x: 370, y: 0)
        yellowBall.zPosition = 2
        
        self.addChild(yellowBall)
    }
    
    func createRedBall() {
        
        redBall = SKSpriteNode(imageNamed: "RedBall")
        redBall.name = "RedBall"
        redBall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        redBall.size = CGSize(width: 90, height: 90)
        redBall.position = CGPoint(x: 0, y: -370)
        redBall.zPosition = 2
        
        self.addChild(redBall)
    }
    
    func createGreenBall() {
        
        greenBall = SKSpriteNode(imageNamed: "GreenBall")
        greenBall.name = "GreenBall"
        greenBall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        greenBall.size = CGSize(width: 90, height: 90)
        greenBall.position = CGPoint(x: -370, y: 0)
        greenBall.zPosition = 2
        
        self.addChild(greenBall)
    }
    
    func createRetryBtn() {
        
        retryBtn = SKLabelNode(fontNamed: "Gill Sans Light")
        retryBtn.name = "RetryBtn"
        retryBtn.fontSize = 140
        retryBtn.fontColor = SKColor(red: 88.0 / 255.0, green: 99.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        retryBtn.text = "RETRY"
        retryBtn.position = CGPoint(x: 0, y: separatorLine.position.y - 180)
        
        self.addChild(retryBtn)
    }
    
    func createRetryBtnDetector() {
        
        retryBtnDetector = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 500, height: 300))
        retryBtnDetector.name = "PlayDetector"
        retryBtnDetector.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        retryBtnDetector.position = CGPoint(x: retryBtn.position.x, y: retryBtn.position.y + 70)
        retryBtnDetector.zPosition = 4
        
        self.addChild(retryBtnDetector)
    }
    
    func createScoreTitleAndLabel() {
        
        scoreTitle = SKLabelNode(fontNamed: "Gill Sans Light")
        scoreTitle.name = "ScoreTitle"
        scoreTitle.fontSize = 50
        scoreTitle.fontColor = SKColor(red: 88.0 / 255.0, green: 99.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        scoreTitle.text = "SCORE"
        scoreTitle.position = CGPoint(x: -130, y: 170)
        
        self.addChild(scoreTitle)
        
        scoreLbl = SKLabelNode(fontNamed: "Gill Sans Medium")
        scoreLbl.name = "ScoreLbl"
        scoreLbl.fontSize = 70
        scoreLbl.fontColor = SKColor(red: 88.0 / 255.0, green: 99.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        scoreLbl.text = "\(userScore)"
        scoreLbl.position = CGPoint(x: -130, y: scoreTitle.position.y - 100)
        
        self.addChild(scoreLbl)
    }
    
    func createRecordTitleAndLabel() {
        
        recordTitle = SKLabelNode(fontNamed: "Gill Sans Light")
        recordTitle.name = "RecordTitle"
        recordTitle.fontSize = 50
        recordTitle.fontColor = SKColor(red: 88.0 / 255.0, green: 99.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        recordTitle.text = "RECORD"
        recordTitle.position = CGPoint(x: 130, y: 170)
        
        self.addChild(recordTitle)
        
        recordLbl = SKLabelNode(fontNamed: "Gill Sans Medium")
        recordLbl.name = "RecordLbl"
        recordLbl.fontSize = 70
        recordLbl.fontColor = SKColor(red: 88.0 / 255.0, green: 99.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        recordLbl.text = "\(userHighscore)"
        recordLbl.position = CGPoint(x: 130, y: recordTitle.position.y - 100)
        if shouldAnimate == true {
            
            let scaleUp = SKAction.scaleTo(1.3, duration: 0.5)
            let scaleDown = SKAction.scaleTo(1.0, duration: 0.5)
            recordLbl.runAction(SKAction.repeatActionForever(SKAction.sequence([scaleUp, scaleDown])))
        }
        
        self.addChild(recordLbl)
    }
    
    func createRateBtn() {
        
        rateBtn = SKSpriteNode(imageNamed: "RateBtn")
        rateBtn.name = "RateBtn"
        rateBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rateBtn.size = CGSize(width: 170, height: 170)
        rateBtn.position = CGPoint(x: greenBall.position.x, y: redBall.position.y - 280)
        rateBtn.zPosition = 1
        
        self.addChild(rateBtn)
    }
    
    func createMusicBtn() {
        
        musicBtn = SKSpriteNode(imageNamed: "MusicBtnOn")
        musicBtn.name = "MusicBtn"
        musicBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        musicBtn.size = CGSize(width: 170, height: 170)
        musicBtn.position = CGPoint(x: -120, y: redBall.position.y - 280)
        musicBtn.zPosition = 1
        
        self.addChild(musicBtn)
    }
    
    func createHomeBtn() {
        
        homeBtn = SKSpriteNode(imageNamed: "HomeBtn")
        homeBtn.name = "HomeBtn"
        homeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        homeBtn.size = CGSize(width: 170, height: 170)
        homeBtn.position = CGPoint(x: 120, y: redBall.position.y - 280)
        homeBtn.zPosition = 1
        
        self.addChild(homeBtn)
    }
    
    func createLeaderboardBtn() {
        
        leaderboardBtn = SKSpriteNode(imageNamed: "LeaderboardBtn")
        leaderboardBtn.name = "LeaderboardBtn"
        leaderboardBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leaderboardBtn.size = CGSize(width: 170, height: 170)
        leaderboardBtn.position = CGPoint(x: yellowBall.position.x, y: redBall.position.y - 280)
        leaderboardBtn.zPosition = 1
        
        self.addChild(leaderboardBtn)
    }
    
    func soundBtnPressed() {
        if soundOn == true {
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOff")))
            soundOn = false
            // Sound is OFF
        } else {
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOn")))
            soundOn = true
            // Sound is ON
        }
    }
    
    func rateBtnPressed() {
        
        let wait = SKAction.waitForDuration(0.1)
        let run = SKAction.runBlock {
            
            UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://itunes.apple.com/app/id1129863500")!)
        }
        
        self.runAction(SKAction.sequence([wait, run]))
    }
    
    func waitBeforeShowingAd() {
        let wait = SKAction.waitForDuration(0.5)
        let run = SKAction.runBlock {
            
            NSNotificationCenter.defaultCenter().postNotificationName("showInterstitialKey", object: nil)
        }
        let sequence = SKAction.sequence([wait, run])
        self.runAction(sequence)
    }
    
    func leaderboardBtnPressed() {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
        gcVC.leaderboardIdentifier = "PUT ID HERE"
        self.view?.window?.rootViewController?.presentViewController(gcVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //send high score to leaderboard
    func saveHighscore(score:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "PUT ID HERE") //leaderboard id here
            
            scoreReporter.value = Int64(score) //score variable here (same as above)
            
            let scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError?) -> Void in
                if error != nil {
                    // error
                }
            })
            
        }
        
        
    }
    
    // ShiftTheLine_26
    
    func playButtonTappedSound() {
        
        let play = SKAction.playSoundFileNamed("ButtonTapped2", waitForCompletion: false)
        if soundOn == true {
            
            self.runAction(play)
        }
    }
    
}
















