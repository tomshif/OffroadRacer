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
    
    var mmAnchor=SKSpriteNode()
    
    

    
    override func didMove(to view: SKView) {
        
        addChild(mmAnchor)

        changeGameState(to: GAMESTATE.MAINMENU)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        // This function will hand off the location of the click
        // to a handler based on the current gameState.
        
        switch gameState
        {
        case GAMESTATE.MAINMENU:
            handleClickMM(at: pos)
            
        default:
            print("Error - Unhandled click in gameState \(gameState).")
        }
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
    
    func handleClickMM(at: CGPoint)
    {
        // This function is the handler for mouse clicks on the main menu
        
        
        
    } // handleClickMM
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {

        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    func changeGameState(to: Int)
    {
        // This function will change the gameState from one state to another.
        // NOTE: NEVER change gameState directly. ALWAYS call this function to change.
        
        if (gameState != to)
        {
            
            switch gameState
            {
            case GAMESTATE.STARTUP:
                if (to == GAMESTATE.MAINMENU)
                {
                    
                    let tempBG=SKSpriteNode(imageNamed: "mmTempBack01")
                    let tempLogo=SKSpriteNode(imageNamed: "tempLogo")
                    let tempFrame=SKSpriteNode(imageNamed: "mmMenuFrame01")
                    
                    gameState=to
                    mmAnchor.addChild(tempBG)
                    
                    tempLogo.position = CGPoint(x: -size.width*0.35, y: size.height*0.35)
                    tempLogo.zPosition=1
                    mmAnchor.addChild(tempLogo)
                    
                    tempFrame.position.x = -size.width*0.35
                    tempFrame.position.y = -size.height*0.1
                    tempFrame.zPosition=2
                    mmAnchor.addChild(tempFrame)
                } // to Main Menu
                else
                {
                    print("Error - Unsupported state change: \(gameState) to \(to)")
                }
                
            
            default:
                print("Error - Unsupported current gameState: \(gameState)")
                break
            } // switch gameState
        
            
        } // if not trying to change to the same gameState
        else
        {
            print("Error - Trying to change to current gameState: \(gameState)")
        }
        
    } // func changeGameState
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
