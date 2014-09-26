//
//  settings.swift
//  verdeciel
//
//  Created by Devine Lu Linvega on 2014-09-25.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension GameViewController {

	override func shouldAutorotate() -> Bool {
		return true
	}
	
	override func supportedInterfaceOrientations() -> Int {
		if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
			return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
		} else {
			return Int(UIInterfaceOrientationMask.All.toRaw())
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
}
