//
//  GameScene.swift
//  OffroadRacer
//
//  Created by LCS Game Design on 1/11/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameState = -1
    
    var tempBG=SKSpriteNode(imageNamed: "mmTempBack01")
    var tempLogo=SKSpriteNode(imageNamed: "tempLogo")
    var tempFrame=SKSpriteNode(imageNamed: "mmMenuFrame01")
    
    override func didMove(to view: SKView) {
        gameState=GAMESTATE.MAINMENU
        
        addChild(tempBG)
        
        tempLogo.position = CGPoint(x: -size.width*0.35, y: size.height*0.35)
        tempLogo.zPosition=1
        addChild(tempLogo)
        
        tempFrame.position.x = -size.width*0.35
        tempFrame.position.y = -size.height*0.1
        tempFrame.zPosition=2
        addChild(tempFrame)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
 
    }
    
    func touchMoved(toPoint pos : CGPoint) {
 
    }
    
    func touchUp(atPoint pos : CGPoint) {
  
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {

        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
