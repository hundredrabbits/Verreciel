//
//  GameSceneDelegate.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-18.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SceneDelegate: SCNView, SCNSceneRendererDelegate
{	
	func renderer(renderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval)
	{
		capsule._fixedUpdate()
		player._fixedUpdate()
		ui._fixedUpdate()
		
		// TODO: Missing the real fixedUpdate
		space.fixedUpdate()
		quests.update()
	}
}