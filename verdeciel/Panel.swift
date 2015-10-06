//
//  SCNNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Panel : SCNNode
{
	func updateInterface(interface:Panel)
	{
		// Empty node
		for node in self.childNodes {
			node.removeFromParentNode()
		}
		
		// Add
		for node in interface.childNodes {
			self.addChildNode(node)
		}
	}
}