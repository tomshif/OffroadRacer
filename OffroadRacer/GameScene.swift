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
    var crAnchor=SKSpriteNode()
    var srAnchor=SKSpriteNode()
    var erAnchor=SKSpriteNode()
    var irAnchor=SKSpriteNode()
    var rpAnchor=SKSpriteNode()
    
    var hudAnchor=SKSpriteNode()
    
    var hud=HUDClass()
    
    var cam=SKCameraNode()
    

    
    override func didMove(to view: SKView) {
        
        addChild(cam)
        self.camera=cam
        
        
        // add anchors
        cam.addChild(hudAnchor)
        addChild(mmAnchor)
        addChild(crAnchor)
        addChild(erAnchor)
        addChild(irAnchor)
        addChild(srAnchor)
        addChild(rpAnchor)
        

        changeGameState(to: GAMESTATE.MAINMENU)
    }// didMove
    
    func touchDown(atPoint pos : CGPoint) {
        
        // This function will hand off the location of the click
        // to a handler based on the current gameState.
        
        switch gameState
        {
        case GAMESTATE.MAINMENU:
            handleClickMM(at: pos)
            
        case GAMESTATE.CHOOSERACE:
            handleClickCR(at: pos)
            
        case GAMESTATE.STARTRACE:
            changeGameState(to: GAMESTATE.INRACE)
            
        case GAMESTATE.RACEPREVIEW:
            changeGameState(to: GAMESTATE.CHOOSERACE)
            
        case GAMESTATE.INRACE:
            changeGameState(to: GAMESTATE.ENDRACE)
            
        case GAMESTATE.ENDRACE:
            changeGameState(to: GAMESTATE.CHOOSERACE)
            
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
        
        for node in self.nodes(at: at)
        {
            if node.name != nil
            {
                if node.name=="mmLogo"
                {
                    print("Logo click.")
                    changeGameState(to: GAMESTATE.CHOOSERACE)
                }
            } // if the name is not nil
        } // for each node
        
        
    } // handleClickMM
    
    func handleClickCR(at: CGPoint)
    {
        // This function is the handler for mouse clicks on the choose race screen
        
        for node in self.nodes(at: at)
        {
            if node.name != nil
            {
                if node.name=="rpButton"
                {
                    print("Race Preview click.")
                    changeGameState(to: GAMESTATE.RACEPREVIEW)
                }
                else if node.name == "crButton"
                {
                    print("Choose Race clicked.")
                    changeGameState(to: GAMESTATE.STARTRACE)
                }
            } // if the name is not nil
        } // for each node
        
    } // handleClickCR()
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {

        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    func loadMainMenu()
    {
        cam.position = CGPoint.zero
        
        let tempBG=SKSpriteNode(imageNamed: "mmTempBack01")
        let tempLogo=SKSpriteNode(imageNamed: "tempLogo")
        let tempFrame=SKSpriteNode(imageNamed: "mmMenuFrame01")
        
        gameState=GAMESTATE.MAINMENU
        mmAnchor.addChild(tempBG)
        
        tempLogo.position = CGPoint(x: -size.width*0.35, y: size.height*0.35)
        tempLogo.zPosition=1
        tempLogo.name="mmLogo"
        mmAnchor.addChild(tempLogo)
        
        tempFrame.position.x = -size.width*0.35
        tempFrame.position.y = -size.height*0.1
        tempFrame.zPosition=2
        mmAnchor.addChild(tempFrame)
    } // load main menu
    
    func loadChooseRaceScreen()
    {
        // Temp Images
        var crTemp=SKSpriteNode(imageNamed: "crTemp")
        crTemp.name="crButton"
        crAnchor.addChild(crTemp)
        
        // Temp image to go to Race Preview
        var rpTemp=SKSpriteNode(imageNamed: "rpTemp")
        rpTemp.name="rpButton"
        rpTemp.setScale(0.5)
        rpTemp.position=CGPoint(x: -size.width*0.25, y: -size.height*0.25)
        crAnchor.addChild(rpTemp)
        
        gameState=GAMESTATE.CHOOSERACE
        
    } // loadChooseRaceScreen
    
    func loadRacePreviewScreen()
    {
        var rpTemp=SKSpriteNode(imageNamed: "rpTemp")
        rpAnchor.addChild(rpTemp)
        
        gameState=GAMESTATE.RACEPREVIEW
    } // loadRacePreviewScreen()
    
    func loadStartRaceScreen()
    {
        var srTemp=SKSpriteNode(imageNamed: "srTemp")
        srAnchor.addChild(srTemp)
        gameState=GAMESTATE.STARTRACE
    } // loadStartRaceScreen
    
    func loadInRaceScreen()
    {
        var irTemp=SKSpriteNode(imageNamed: "irTemp")
        irAnchor.addChild(irTemp)
        gameState=GAMESTATE.INRACE
        
    } // loadInRaceScreen
    
    func loadEndRaceScreen()
    {
        var erTemp=SKSpriteNode(imageNamed: "erTemp")
        erAnchor.addChild(erTemp)
        gameState=GAMESTATE.ENDRACE
    }
    
    func changeGameState(to: Int)
    {
        // This function will change the gameState from one state to another.
        // NOTE: NEVER change gameState directly. ALWAYS call this function to change, not the functions that may load certain screens (such as 'loadMainMenu()'). This is important because there will be clean up of screens that we're leaving in this function, as well as (possibly) loading new assets, etc.
        
        if (gameState != to)
        {
            
            switch gameState
            {
            case GAMESTATE.STARTUP:
                if (to == GAMESTATE.MAINMENU)
                {
                    loadMainMenu()
 
                } // to Main Menu
                else
                {
                    print("Error - Unsupported state change: \(gameState) to \(to)")
                }
            
            case GAMESTATE.MAINMENU:
                if(to==GAMESTATE.CHOOSERACE)
                {
                    mmAnchor.removeAllChildren()
                    loadChooseRaceScreen()
                } // to Choose Race Screen
                
            case GAMESTATE.CHOOSERACE:
                if(to==GAMESTATE.STARTRACE)
                {
                    crAnchor.removeAllChildren()
                    loadStartRaceScreen()
                }
                else if to==GAMESTATE.RACEPREVIEW
                {
                    crAnchor.removeAllChildren()
                    loadRacePreviewScreen()
                }
            
            case GAMESTATE.RACEPREVIEW:
                if(to==GAMESTATE.CHOOSERACE)
                {
                    rpAnchor.removeAllChildren()
                    loadChooseRaceScreen()
                }
            case GAMESTATE.STARTRACE:
                if(to==GAMESTATE.INRACE)
                {
                    srAnchor.removeAllChildren()
                    loadInRaceScreen()
                }
                
            case GAMESTATE.INRACE:
                if(to==GAMESTATE.ENDRACE)
                {
                    irAnchor.removeAllChildren()
                    loadEndRaceScreen()
                }
                
            case GAMESTATE.ENDRACE:
                if(to==GAMESTATE.CHOOSERACE)
                {
                    erAnchor.removeAllChildren()
                    loadChooseRaceScreen()
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
