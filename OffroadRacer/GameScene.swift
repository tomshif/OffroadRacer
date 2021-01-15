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
    var upAnchor=SKSpriteNode()
    
    
    var puAnchor=SKSpriteNode()
    
    
    var hudAnchor=SKSpriteNode()
    
    var hud=HUDClass()
    
    var cam=SKCameraNode()
    
    var currentPopUp:PopUpClass?
    

    
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
        addChild(upAnchor)
        cam.addChild(puAnchor)
        puAnchor.name="puAnchor"

    
        
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
            
        case GAMESTATE.UPGRADE:
            changeGameState(to: GAMESTATE.CHOOSERACE)
            
        case GAMESTATE.POPUP:
            handleClickPU(at: pos)
        
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
                    
                    changeGameState(to: GAMESTATE.RACEPREVIEW)
                }
                else if node.name == "crButton"
                {
                    
                    changeGameState(to: GAMESTATE.STARTRACE)
                }
                else if node.name == "upButton"
                {
                    changeGameState(to: GAMESTATE.UPGRADE)
                }
            } // if the name is not nil
        } // for each node
        
    } // handleClickCR()
    
    func handleClickPU(at: CGPoint) -> Int
    {
        // This function handles clicks when we're showing a pop up window
        // For now, all it does is remove the pop up if the user clicks OK or YES
        
        
        var retValue:Int=PUBUTTONS.ERROR

        
        if (currentPopUp != nil)
        {
            retValue = currentPopUp!.checkClick(pos: at)
            
            if (retValue == PUBUTTONS.OK && currentPopUp!.type == POPTYPE.INFO)
            {
                currentPopUp!.destroy()
            }
            else if (retValue == PUBUTTONS.YES && currentPopUp!.type == POPTYPE.YESNO)
            {
                currentPopUp!.destroy()
            }
            else if (retValue == PUBUTTONS.NO && currentPopUp!.type == POPTYPE.YESNO)
            {
                currentPopUp!.destroy()
                print("User selected no.")
            }
            
        } // if current popup isn't nil
        else
        {
            print("ERROR - No current pop up while in pop up state.")
        }
        
        return retValue
        
    } // handleClickPU()
    
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {

        case 35: // P -- Testing Pop up Menus
            if (currentPopUp == nil)
            {
                currentPopUp=PopUpClass(theScene: self, popType: POPTYPE.INFO, parentNode: puAnchor, popText: "This is a test Pop up")
            }
            
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
        
        
        if (currentPopUp == nil)
        {
            currentPopUp=PopUpClass(theScene: self, popType: POPTYPE.YESNO, parentNode: puAnchor, popText: "Testing - Do you know how to use pop up windows?")
        }
        
    } // load main menu
    
    func loadUpgradeScreen()
    {
        var upTemp=SKSpriteNode(imageNamed: "upTemp")
        upTemp.name="upButton"
        upAnchor.addChild(upTemp)
        gameState=GAMESTATE.UPGRADE
        
    } // loadUpgradeScreen
    
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
        
        // Temp image to go to upgrade
        var upTemp=SKSpriteNode(imageNamed: "upTemp")
        upTemp.name="upButton"
        upTemp.position.x = -size.width*0.25
        upTemp.position.y = size.height*0.25
        upTemp.setScale(0.5)
        crAnchor.addChild(upTemp)
        
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
                else if to==GAMESTATE.UPGRADE
                {
                    crAnchor.removeAllChildren()
                    loadUpgradeScreen()
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
                
            case GAMESTATE.UPGRADE:
                if (to==GAMESTATE.CHOOSERACE)
                {
                    upAnchor.removeAllChildren()
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
