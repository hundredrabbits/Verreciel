//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension SCNNode
{
	func touch(id:Int = 0)
	{
		print("! This node has no touch action")
	}
	
	func _start()
	{
		start()
		for node in childNodes {
			node._start()
		}
	}
	
	func start()
	{
	}
	
	func fixedUpdate()
	{
		for node in childNodes {
			node.fixedUpdate()
		}
	}
	
	func absolutePosition() -> SCNVector3
	{
		return convertPosition(SCNVector3(0, 0, 0), fromNode: self)
	}
	
	func update()
	{
	}

	func bang()
	{
		print("! This node has no bang action")
	}
	
	func listen(event:Event)
	{
		print("! This node has no listen action")
	}
	
	func color(color:UIColor)
	{
		if geometry == nil { return }
		self.geometry!.firstMaterial?.diffuse.contents = color
	}
	
	func disconnect()
	{
		
	}
	
	func replace(node:SCNNode)
	{
		self.empty()
		self.add(node)
	}
	
	func empty()
	{
		for node in childNodes {
			node.removeFromParentNode()
		}
	}
	
	func add(node:SCNNode)
	{
		for child in node.childNodes {
			self.addChildNode(child)
		}
	}
	
	func blink()
	{
		if time.elapsed % 2 == 0 { opacity = 1 }
		else { opacity = 0 }
	}
	
	func show()
	{
		opacity = 1
	}
	
	func hide()
	{
		opacity = 0
	}
	
	func updateChildrenColors(color:UIColor)
	{
		for node in self.childNodes {
			node.color(color)
			for subnode in node.childNodes {
				subnode.color(color)
			}
		}
	}
	
	// MARK: Triggers -
	
	func onConnect()
	{
		update()
	}
	
	func onDisconnect()
	{
		update()
	}
	
	func onUploadComplete()
	{
		
	}
}