//  Created by Devine Lu Linvega on 2015-10-18.
//  Copyright © 2015 XXIIVV. All rights reserved.


import UIKit
import QuartzCore
import SceneKit
import Foundation

class SceneDelegate: SCNView, SCNSceneRendererDelegate
{	
	func renderer(renderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval)
	{
		if settings.applicationIsReady == false { return }
		
		capsule._fixedUpdate()
		player._fixedUpdate()
		ui._fixedUpdate()
		
		// TODO: Missing the real fixedUpdate
		space.fixedUpdate()
		quests.update()
	}
	
	func renderer(renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: NSTimeInterval)
	{
//		capsule._lateUpdate()
	}
}