//
//  Definitions.swift
//  OffroadRacer
//
//  Created by Tom on 1/11/21.
//

import Foundation

struct GAMESTATE
{
    
    static let STARTUP:Int = -1
    static let MAINMENU:Int=0       // mm
    static let INRACE:Int=2         // ir
    static let PAUSED:Int=4         // pa
    static let UPGRADE:Int=6        // up
    static let RACEPREVIEW:Int=8    // rp
    static let STARTRACE:Int=10     // sr
    static let ENDRACE:Int=12       // er
    static let CHOOSERACE:Int=14    // cr
    static let BUYUPGRADES:Int=16   // bu
    static let POPUP:Int=100        // pu
    
} // GAMESTATE

struct PUBUTTONS
{
    static let ERROR:Int = -1
    static let NO:Int=0
    static let YES:Int=1
    static let OK:Int=5
} // PUBUTTONS

struct POPTYPE
{
    static let DISABLED:Int = -1
    static let INFO:Int=0
    static let YESNO:Int=2
    
}
