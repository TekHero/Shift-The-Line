//
//  GameplayScene.swift
//  Shift The Line
//
//  Created by Brian Lim on 6/23/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
import AudioToolbox

class GameplayScene: SKScene {
    
    var circle = SKSpriteNode()
    var scoreLbl = SKLabelNode()
    var colorLbl = SKLabelNode()
    var separatorLine = SKSpriteNode()
    var blueBall = SKSpriteNode()
    var redBall = SKSpriteNode()
    var greenBall = SKSpriteNode()
    var yellowBall = SKSpriteNode()
    
    var line = SKSpriteNode()
    var path = UIBezierPath()
    
    var tapToPlayTitle = SKLabelNode()
    var tapToPlayScreen = SKSpriteNode()
    
    var colorBallsArray = ["BlueBall", "RedBall", "GreenBall", "YellowBall"]
    
    var movingClockwise = Bool()
    var gameStarted = false
    var blueIntersected = false
    var redIntersected = false
    var greenIntersected = false
    var yellowIntersected = false
    
    var counter = 0
    
    var ballPositions = [CGPoint]()
    
    override func didMoveToView(view: SKView) {
        
        initialize()
    }
    
    func initialize() {
        
        createPos()
        createTapToPlayTitleAndScreen()
        createCircle()
        createScoreLbl()
        createColorLbl()
        createSeparatorLine()
        createLine()
        addBlueBall()
        addYellowBall()
        addRedBall()
        addGreenBall()
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        if blueBall.position == redBall.position || blueBall.position == greenBall.position || blueBall.position == yellowBall.position {
            
            self.blueBall.removeFromParent()
            self.addNewBlueBall()
            self.randomizePositions()
        }
        
        if redBall.position == blueBall.position || redBall.position == greenBall.position || redBall.position == yellowBall.position {
            
            self.redBall.removeFromParent()
            self.addNewRedBall()
            self.randomizePositions()
        }
        
        if greenBall.position == blueBall.position || greenBall.position == redBall.position || greenBall.position == yellowBall.position {
            
            self.greenBall.removeFromParent()
            self.addNewGreenBall()
            self.randomizePositions()
        }
        
        if yellowBall.position == blueBall.position || yellowBall.position == greenBall.position || yellowBall.position == redBall.position {
            
            self.yellowBall.removeFromParent()
            self.addNewYellowBall()
            self.randomizePositions()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location) == tapToPlayScreen {
                
                tapToPlayScreen.removeFromParent()
                tapToPlayTitle.removeFromParent()
            }
        }
        
        if line.intersectsNode(blueBall) {
            
            blueIntersected = true
            
        } else {
            
            blueIntersected = false
        }
        
        if line.intersectsNode(redBall) {
            
            redIntersected = true
            
        } else {
            
            redIntersected = false
            
        }
        
        if line.intersectsNode(greenBall) {
            
            greenIntersected = true
            
        } else {
            
            greenIntersected = false
        }
        
        if line.intersectsNode(yellowBall) {
            
            yellowIntersected = true
            
        } else {
            
            yellowIntersected = false
        }
        
        if gameStarted == false {
            
            moveClockwise()
            movingClockwise = true
            gameStarted = true
        } else {
            
            if movingClockwise == true {
                
                moveCounterClockwise()
                movingClockwise = false
                
            } else {
                
                moveClockwise()
                movingClockwise = true
                
            }
            
            if colorLbl.text == "BLUE" {
                
                blueBallTouched()
            }
            
            if colorLbl.text == "RED" {
                
                redBallTouched()
            }
            
            if colorLbl.text == "GREEN" {
                
                greenBallTouched()
                
            }
            
            if colorLbl.text == "YELLOW" {
                
                yellowBallTouched()
            }
        }
        
    }
    
    func createLine() {
        
        line = SKSpriteNode(imageNamed: "Line")
        line.size = CGSize(width: 90, height: 10)
        line.position = CGPoint(x: 0, y: 370)
        line.zRotation = 3.14 / 2
        line.zPosition = 5
        
        self.addChild(line)
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
    
    func createScoreLbl() {
        
        scoreLbl = SKLabelNode(fontNamed: "Gill Sans Light")
        scoreLbl.name = "ScoreLbl"
        scoreLbl.text = "0"
        scoreLbl.fontSize = 180
        scoreLbl.fontColor = SKColor.darkGrayColor()
        scoreLbl.position = CGPoint(x: 0, y: 50)
        scoreLbl.zPosition = 2
        
        self.addChild(scoreLbl)
    }
    
    func createColorLbl() {
        
        colorLbl = SKLabelNode(fontNamed: "Gill Sans Light")
        colorLbl.name = "ColorLbl"
        colorLbl.text = "BLUE"
        colorLbl.fontSize = 130
        colorLbl.fontColor = SKColor(red: 74.0 / 255.0, green: 144.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        colorLbl.position = CGPoint(x: 0, y: separatorLine.position.y - 170)
        colorLbl.zPosition = 2
        
        self.addChild(colorLbl)
    }
    
    func createSeparatorLine() {
        // SKColor(red: 88.0 / 255.0, green: 99.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        separatorLine = SKSpriteNode(color: SKColor.darkGrayColor(), size: CGSize(width: 450, height: 15))
        separatorLine.name = "Separator"
        separatorLine.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        separatorLine.zPosition = 1
        separatorLine.position = CGPoint(x: 0, y: 0)
        
        self.addChild(separatorLine)
    }
    
    func createTapToPlayTitleAndScreen() {
        
        tapToPlayScreen = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!))
        tapToPlayScreen.name = "TapToPlayScreen"
        tapToPlayScreen.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        tapToPlayScreen.position = CGPoint(x: 0, y: 0)
        tapToPlayScreen.zPosition = 10
        
        tapToPlayTitle = SKLabelNode(fontNamed: "Gill Sans Light")
        tapToPlayTitle.name = "TapToPlay"
        tapToPlayTitle.fontSize = 150
        tapToPlayTitle.fontColor = SKColor.darkGrayColor()
        tapToPlayTitle.text = "Tap To Play"
        tapToPlayTitle.position = CGPoint(x: 0, y: 640)
        tapToPlayTitle.zPosition = 11
        
        self.addChild(tapToPlayTitle)
        self.addChild(tapToPlayScreen)
    }
    
    func addBlueBall() {
        
        blueBall = SKSpriteNode(imageNamed: "BlueBall")
        blueBall.size = CGSize(width: 90, height: 90)
        blueBall.zPosition = 4
        blueBall.position = CGPoint(x: 0, y: 370)
        
        self.addChild(blueBall)
    }
    
    func addGreenBall() {
        
        greenBall = SKSpriteNode(imageNamed: "GreenBall")
        greenBall.size = CGSize(width: 90, height: 90)
        greenBall.zPosition = 4
        greenBall.position = CGPoint(x: -370, y: 0)
        
        self.addChild(greenBall)
    }
    
    func addRedBall() {
        
        redBall = SKSpriteNode(imageNamed: "RedBall")
        redBall.size = CGSize(width: 90, height: 90)
        redBall.zPosition = 4
        redBall.position = CGPoint(x: 0, y: -370)
        
        self.addChild(redBall)

    }
    
    func addYellowBall() {
        
        yellowBall = SKSpriteNode(imageNamed: "YellowBall")
        yellowBall.size = CGSize(width: 90, height: 90)
        yellowBall.zPosition = 4
        yellowBall.position = CGPoint(x: 370, y: 0)
        
        self.addChild(yellowBall)

    }
    
    func moveClockwise() {
        
        let rand = GameManager.instance.randomBetweenNumbers(1100, secondNum: 1500)
        
        let dx = line.position.x - self.position.x
        let dy = line.position.y - self.position.y
        let radian = atan2(dy, dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 370, startAngle: radian, endAngle: radian + CGFloat(M_PI * 4), clockwise: true)
        
        let follow = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: rand)
        line.runAction(SKAction.repeatActionForever(follow).reversedAction())
    }
    
    func moveCounterClockwise() {
        
        let rand = GameManager.instance.randomBetweenNumbers(1100, secondNum: 1500)
        
        let dx = line.position.x - self.position.x
        let dy = line.position.y - self.position.y
        let radian = atan2(dy, dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: 0,y: 0), radius: 370, startAngle: radian, endAngle: radian + CGFloat(M_PI * 4), clockwise: true)
        
        let follow = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: rand)
        line.runAction(SKAction.repeatActionForever(follow))
    }
    
    func blueBallTouched() {
        
        if blueIntersected == true && colorLbl.text == "BLUE" {
            
            playCorrectSound()
            blueBall.removeFromParent()
            addBlueBall()
            blueIntersected = false
            
            counter = counter + 1
            scoreLbl.text = "\(counter)"
            
        } else {
            
            endGame()
        }
        
        if counter != 0 && counter % 3 == 0 {
            
            let wait = SKAction.waitForDuration(0.1)
            let run = SKAction.runBlock {
                
                self.changeColor()
                self.randomizePositions()
                
            }
            
            self.runAction(SKAction.sequence([wait, run]))
        }
    }
    
    func redBallTouched() {
        
        if redIntersected == true && colorLbl.text == "RED" {
            
            playCorrectSound()
            redBall.removeFromParent()
            addRedBall()
            redIntersected = false
            
            counter = counter + 1
            scoreLbl.text = "\(counter)"
            
        } else {
            
            endGame()
        }
        
        if counter != 0 && counter % 3 == 0 {
            
            let wait = SKAction.waitForDuration(0.1)
            let run = SKAction.runBlock {
                
                self.changeColor()
                self.randomizePositions()
                
            }
            
            self.runAction(SKAction.sequence([wait, run]))
        }
    }
    
    func greenBallTouched() {
        
        if greenIntersected == true && colorLbl.text == "GREEN" {
            
            playCorrectSound()
            greenBall.removeFromParent()
            addGreenBall()
            greenIntersected = false
            
            counter = counter + 1
            scoreLbl.text = "\(counter)"
            
        } else {
            
            endGame()
        }
        
        if counter != 0 && counter % 3 == 0 {
            
            let wait = SKAction.waitForDuration(0.1)
            let run = SKAction.runBlock {
                
                self.changeColor()
                self.randomizePositions()
                
            }
            
            self.runAction(SKAction.sequence([wait, run]))
        }
    }
    
    func yellowBallTouched() {
        
        if yellowIntersected == true && colorLbl.text == "YELLOW" {
            
            playCorrectSound()
            yellowBall.removeFromParent()
            addYellowBall()
            yellowIntersected = false
            
            counter = counter + 1
            scoreLbl.text = "\(counter)"
            
        } else {
            
            endGame()
        }
        
        if counter != 0 && counter % 3 == 0 {
            
            let wait = SKAction.waitForDuration(0.1)
            let run = SKAction.runBlock {
                
                self.changeColor()
                self.randomizePositions()
                
            }
            
            self.runAction(SKAction.sequence([wait, run]))
            
        }
    
    }
    
    func endGame() {
        
        NSUserDefaults.standardUserDefaults().setInteger(counter, forKey: "SCORE")
        
        let gameover = GameoverScene(fileNamed: "GameoverScene")
        gameover?.scaleMode = .AspectFill
        self.view?.presentScene(gameover!, transition: SKTransition.fadeWithDuration(0.5))
        
        self.removeAllChildren()
    }
    
    func changeColor() {
        
        let rand = Int(arc4random_uniform(4))
        let color = colorBallsArray[rand]
        
        if color == "BlueBall" {
            
            colorLbl.text = "BLUE"
            colorLbl.fontColor = SKColor(red: 74.0 / 255.0, green: 144.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
            blueBall.zPosition = 5
            redBall.zPosition = 4
            greenBall.zPosition = 4
            yellowBall.zPosition = 4
        }
        
        if color == "RedBall" {
            
            colorLbl.text = "RED"
            colorLbl.fontColor = SKColor.redColor()
            blueBall.zPosition = 4
            redBall.zPosition = 5
            greenBall.zPosition = 4
            yellowBall.zPosition = 4
        }
        
        if color == "GreenBall" {
            
            colorLbl.text = "GREEN"
            colorLbl.fontColor = SKColor.greenColor()
            blueBall.zPosition = 4
            redBall.zPosition = 4
            greenBall.zPosition = 5
            yellowBall.zPosition = 4
            
        }
        
        if color == "YellowBall" {
            
            colorLbl.text = "YELLOW"
            colorLbl.fontColor = SKColor.yellowColor()
            blueBall.zPosition = 4
            redBall.zPosition = 4
            greenBall.zPosition = 4
            yellowBall.zPosition = 5
        }
        
    }
    
    func playCorrectSound() {
        
        let play = SKAction.playSoundFileNamed("CorrectSound4", waitForCompletion: false)
        if soundOn == true {
            
            self.runAction(play)
        }
    }
    
    func randomizePositions() {
        
        let rand = Int(arc4random_uniform(4))
        let pos = ballPositions[rand]
        
        blueBall.position = pos
        
        let rand2 = Int(arc4random_uniform(4))
        let pos2 = ballPositions[rand2]
        
        redBall.position = pos2
        
        let rand3 = Int(arc4random_uniform(4))
        let pos3 = ballPositions[rand3]
        
        greenBall.position = pos3
        
        let rand4 = Int(arc4random_uniform(4))
        let pos4 = ballPositions[rand4]
        
        yellowBall.position = pos4
    }
    
    func createPos() {
        
        let blueBallPos = CGPoint(x: 0, y: 370)
        let redBallPos = CGPoint(x: 0, y: -370)
        let yellowBallPos = CGPoint(x: 370, y: 0)
        let greenBallPos = CGPoint(x: -370, y: 0)
        
        ballPositions.append(blueBallPos)
        ballPositions.append(redBallPos)
        ballPositions.append(yellowBallPos)
        ballPositions.append(greenBallPos)
    }
    
    func addNewBlueBall() {
        
        blueBall = SKSpriteNode(imageNamed: "BlueBall")
        blueBall.size = CGSize(width: 90, height: 90)
        blueBall.zPosition = 4
        
        self.addChild(blueBall)
    }
    
    func addNewRedBall() {
        
        redBall = SKSpriteNode(imageNamed: "RedBall")
        redBall.size = CGSize(width: 90, height: 90)
        redBall.zPosition = 4
        
        self.addChild(redBall)
    }
    
    func addNewGreenBall() {
        
        greenBall = SKSpriteNode(imageNamed: "GreenBall")
        greenBall.size = CGSize(width: 90, height: 90)
        greenBall.zPosition = 4
        
        self.addChild(greenBall)
    }
    
    func addNewYellowBall() {
        
        yellowBall = SKSpriteNode(imageNamed: "YellowBall")
        yellowBall.size = CGSize(width: 90, height: 90)
        yellowBall.zPosition = 4
        
        self.addChild(yellowBall)
    }
}




