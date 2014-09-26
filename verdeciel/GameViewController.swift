//
//  GameViewController.swift
//  verdeciel
//
//  Created by Devine Lu Linvega on 2014-09-21.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

var scene = SCNScene()
var touchOrigin = CGPoint()

var heading = Double(0.0)
var attitude = Double(0.0)
var bank = 0.0

class GameViewController: UIViewController
{
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		sceneSetup()
		capsuleSetup()
		objectSetup()
		sceneComplete()
    }
}
