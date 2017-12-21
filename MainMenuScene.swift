//
//  MainMenuScene.swift
//  Shift The Line
//
//  Created by Brian Lim on 6/22/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class MainMenuScene: SKScene, GKGameCenterControllerDelegate {
    
    var circle = SKSpriteNode()
    var titleLbl = SKLabelNode()
    
    var playTitle = SKLabelNode()
    var playBtn = SKLabelNode()
    var separatorLine = SKSpriteNode()
    var musicBtn = SKSpriteNode()
    var tutorialBtn = SKSpriteNode()
    var leaderboardBtn = SKSpriteNode()
    
    var playBtnDetector = SKSpriteNode()
    
    var blueBall = SKSpriteNode()
    var yellowBall = SKSpriteNode()
    var redBall = SKSpriteNode()
    var greenBall = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        initialize()
        
        if soundOn == true {
            
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOn")))
        } else {
            
            musicBtn.runAction(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOff")))
        }
    }
    
    func initialize() {
        authenticateLocalPlayer()
        
        createCircle()
        createTitle()
        createSeparatorLine()
        createPlayTitleAndBtn()
        createBlueBall()
        createYellowBall()
        createRedBall()
        createGreenBall()
        createMusicBtn()
        createRateBtn()
        createLeaderboardBtn()
        createPlayBtnDetector()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location) == playBtnDetector {
                
                playButtonTappedSound()
                let gameplay = GameplayScene(fileNamed: "GameplayScene")
                gameplay?.scaleMode = .AspectFill
                self.view?.presentScene(gameplay!, transition: SKTransition.doorsOpenHorizontalWithDuration(0.4))
            }
            
            if nodeAtPoint(location) == tutorialBtn {
                
                playButtonTappedSound()
                createTutorialAlertView()
            }
            
            if nodeAtPoint(location) == musicBtn {
                
                playButtonTappedSound()
                soundBtnPressed()
            }
            
            if nodeAtPoint(location) == leaderboardBtn {
                
                playButtonTappedSound()
                leaderboardBtnPressed()
            }
        }
    }
    
    func createCircle() {
        
        circle = SKSpriteNode(imageNamed: "Circle")
        circle.name = "Circle"
        circle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        circle.zPosition = 1
        circle.size = CGSize(width: 850, height: 850)
        circle.position = CGPoint(x: 0, y: 0)
        
        self.addChild(circle)
    }
    
    func createTitle() {
        
        titleLbl = SKLabelNode(fontNamed: "Gill Sans Light")
        titleLbl.name = "Title"
        titleLbl.fontColor = SKColor(red: 88.0 / 255.0, green: 99.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        titleLbl.fontSize = 180
        titleLbl.text = "Shift The Line"
        titleLbl.position = CGPoint(x: 0, y: 640)
        
        self.addChild(titleLbl)
    }
    
    func createPlayTitleAndBtn() {
        
        playTitle = SKLabelNode(fontNamed: "Gill Sans Light")
        playTitle.name = "PlayTitle"
        playTitle.fontColor = SKColor(red: 88.0 / 255.0, green: 99.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        playTitle.fontSize = 120
        playTitle.text = "TAP TO"
        playTitle.position = CGPoint(x: 0, y: separatorLine.position.y + 80)
        
        self.addChild(playTitle)
        
        playBtn = SKLabelNode(fontNamed: "Gill Sans Light")
        playBtn.name = "PlayBtn"
        playBtn.fontColor = SKColor(red: 88.0 / 255.0, green: 99.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        playBtn.fontSize = 140
        playBtn.text = "PLAY"
        playBtn.position = CGPoint(x: 0, y: separatorLine.position.y - 180)
        
        let fadeOut = SKAction.fadeOutWithDuration(0.5)
        let fadeIn = SKAction.fadeInWithDuration(0.5)
        playBtn.runAction(SKAction.repeatActionForever(SKAction.sequence([fadeOut, fadeIn])))
        
        self.addChild(playBtn)
    }
    
    func createPlayBtnDetector() {
        
        playBtnDetector = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 450, height: 450))
        playBtnDetector.name = "PlayDetector"
        playBtnDetector.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playBtnDetector.position = CGPoint(x: separatorLine.position.x, y: separatorLine.position.y)
        playBtnDetector.zPosition = 4
        
        self.addChild(playBtnDetector)
    }
    
    func createSeparatorLine() {
    
        separatorLine = SKSpriteNode(color: SKColor.darkGrayColor(), size: CGSize(width: 450, height: 15))
        separatorLine.name = "Separator"
        separatorLine.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        separatorLine.zPosition = 1
        separatorLine.position = CGPoint(x: 0, y: 0)
        
        self.addChild(separatorLine)
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
    
    func createMusicBtn() {
        
        musicBtn = SKSpriteNode(imageNamed: "MusicBtnOn")
        musicBtn.name = "MusicBtn"
        musicBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        musicBtn.size = CGSize(width: 170, height: 170)
        musicBtn.position = CGPoint(x: 0, y: redBall.position.y - 280)
        musicBtn.zPosition = 1
        
        self.addChild(musicBtn)
    }
    
    func createRateBtn() {
        
        tutorialBtn = SKSpriteNode(imageNamed: "TutorialBtn")
        tutorialBtn.name = "TutorialBtn"
        tutorialBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        tutorialBtn.size = CGSize(width: 170, height: 170)
        tutorialBtn.position = CGPoint(x: greenBall.position.x, y: musicBtn.position.y)
        tutorialBtn.zPosition = 1
        
        self.addChild(tutorialBtn)
    }
    
    func createLeaderboardBtn() {
        
        leaderboardBtn = SKSpriteNode(imageNamed: "LeaderboardBtn")
        leaderboardBtn.name = "LeaderboardBtn"
        leaderboardBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leaderboardBtn.size = CGSize(width: 170, height: 170)
        leaderboardBtn.position = CGPoint(x: yellowBall.position.x, y: musicBtn.position.y)
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
    
    func createTutorialAlertView() {
        let alert = UIAlertController(title: "How-To-Play", message: "Stop the line on the color circle matching the color that pops up, try to stop it on every matching colored circle or it is GAMEOVER!", preferredStyle: UIAlertControllerStyle.Alert)
        let okay = UIAlertAction(title: "Let's Play", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(okay)
        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // ShiftTheLine_26
    
    func leaderboardBtnPressed() {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
        gcVC.leaderboardIdentifier = "PUT YOUR ID HERE"
        self.view?.window?.rootViewController?.presentViewController(gcVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //initiate gamecenter
    func authenticateLocalPlayer(){
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.view?.window?.rootViewController?.presentViewController(viewController!, animated: true, completion: nil)
                
            }
                
            else {
                print((GKLocalPlayer.localPlayer().authenticated))
            }
        }
        
    }
    
    func playButtonTappedSound() {
        
        let play = SKAction.playSoundFileNamed("ButtonTapped2", waitForCompletion: false)
        if soundOn == true {
            
            self.runAction(play)
        }
    }
    
}























