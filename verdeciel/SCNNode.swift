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

extension SCNNode
{
	func touch(id:Int = 0)
	{
		print("! This node has no touch action")
		print(self)
	}
	
	func _start()
	{
		start()
		for node in childNodes {
			node._start()
		}
	}
	
	func _fixedUpdate()
	{
		fixedUpdate()
		for node in childNodes {
			node._fixedUpdate()
		}
	}
	
	func start()
	{
	}
	
	func update()
	{
	}
	
	func fixedUpdate()
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
		self.geometry!.firstMaterial?.diffuse.contents = color
	}
	
	func disconnect()
	{
		
	}
	
	func empty()
	{
		for node in self.childNodes {
			node.removeFromParentNode()
		}
	}
	
	func add(object:SCNNode)
	{
		for node in object.childNodes {
			self.addChildNode(node)
		}
	}
	
	func updateChildrenColors(color:UIColor)
	{
		for node in self.childNodes {
			node.color(color)
		}
	}
}