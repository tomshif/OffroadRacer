//
//  PopUpClass.swift
//  OffroadRacer
//
//  Created by Tom on 1/15/21.
//

import Foundation
import SpriteKit

class PopUpClass
{
    // This class will spawn different types of pop up windows and manage the interactions with them.
    
    // NOTES:
    
    // - Always call the Destroy() function of a popup to remove it
    // - Always check to make sure that currentPopUp in GameScene is nil before initiating a pop up. It should virtually impossible to double up, but just in case, check.
    // - If you need to handle the result of a YES/NO pop up, you need to handle it in the GameScene/handleClickPU() function.
    // - Make sure to check your text spacing. There is only one size of pop up box...make sure that your text fits appropriately.
    // - in GameScene, if you need to see what the previous mode was (before the pop up), you can reach into currentPopUp.prevGameState to check. This will be important in how the pop up results are handled.
    
    
    
    
    var scene:GameScene?
    var frame=SKSpriteNode()
    var parent:SKSpriteNode?
    var type:Int = -1
    var text:String=""
    var prevGameState:Int = -1
    
    
    init(theScene: GameScene, popType: Int, parentNode: SKSpriteNode, popText: String)
    {
        scene=theScene
        type=popType
        parent=parentNode
        text=popText
        
        frame=SKSpriteNode(imageNamed: "popFrame")
        
        parent!.addChild(frame)
        
        frame.zPosition=1000
        
        let msgText=SKLabelNode(fontNamed: "Arial")
        msgText.text = text
        msgText.numberOfLines=3
        msgText.preferredMaxLayoutWidth=475
        msgText.fontColor=NSColor.white
        msgText.zPosition=1
        
        frame.addChild(msgText)
        
        prevGameState=scene!.gameState
        scene!.gameState=GAMESTATE.POPUP
        
        if (type==POPTYPE.INFO)
        {
            let okButton=SKSpriteNode(imageNamed: "okButton")
            okButton.name="puOKButton"
            okButton.position.y = -frame.size.height*0.35
            okButton.zPosition=1
            frame.addChild(okButton)
        } // if it's an info pop
        else if (type==POPTYPE.YESNO)
        {
            let noButton=SKSpriteNode(imageNamed: "noButton")
            noButton.name="puNoButton"
            noButton.position.y = -frame.size.height*0.35
            noButton.position.x = -frame.size.width*0.3
            noButton.zPosition=1
            frame.addChild(noButton)
            
            let yesButton=SKSpriteNode(imageNamed: "yesButton")
            yesButton.name="puYesButton"
            yesButton.position.y = -frame.size.height*0.35
            yesButton.position.x = frame.size.width*0.3
            yesButton.zPosition=1
            frame.addChild(yesButton)
        } // if it's a yes/no pop
        
        
        
        
    } // init
    
    init()
    {
        
    }
    
    func checkClick(pos:CGPoint) -> Int
    {
        var retValue:Int = PUBUTTONS.ERROR
        
        for node in frame.nodes(at: pos)
        {
            if (node.name != nil)
            {
                if (node.name! == "puYesButton")
                {
                    retValue=PUBUTTONS.YES
                }
                else if (node.name! == "puNoButton")
                {
                    retValue=PUBUTTONS.NO
                }
                else if (node.name! == "puOKButton")
                {
                    retValue=PUBUTTONS.OK
                }
                
            } // if node name is not nil
            
        } // for each node in the frame
        
        
        
        return retValue
        
    } // checkClick()
    
    func destroy()
    {
        frame.removeAllChildren()
        frame.removeFromParent()
        scene!.gameState=prevGameState
        scene!.currentPopUp=nil
        
    } // destroy()
    
} // Class PopUpClass
