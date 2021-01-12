//
//  random.swift
//  sktextures
//
//  Created by Tom Shiflet on 12/4/17.
//  Copyright © 2017 Tom Shiflet. All rights reserved.
//

import Foundation

func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}
