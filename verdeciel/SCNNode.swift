
//  Created by Devine Lu Linvega on 2016-04-22.
//  Copyright © 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension SCNNode
{
	func whenStart()
	{
        let childNodes = self.childNodes
		for node in childNodes {
			node.whenStart()
		}
	}
	
	func whenTime()
	{
        let childNodes = self.childNodes
		for node in childNodes {
			node.whenTime()
		}
	}
	
	func whenSecond()
	{
        let childNodes = self.childNodes
		for node in childNodes {
			node.whenSecond()
		}
	}
	
	func whenRenderer()
	{
        let childNodes = self.childNodes
		for node in childNodes {
			node.whenRenderer()
		}
	}
}