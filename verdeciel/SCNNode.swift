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
	func touch()
	{
		print("! This node has no touch action")
	}
	
	func update()
	{
//		print("! This node has no update action")
	}
	
	func bang(param:Bool)
	{
		print("! This node has no bang action")
	}
	
	func listen(event:Event)
	{
		print("! This node has no listen action")
	}
	
	func tic()
	{
		
	}
	
	func disconnect()
	{
		
	}
	
	func updateChildrenColors(color:UIColor)
	{
		for newLine in self.childNodes {
			let line = newLine as! SCNLine
			line.color(white)
		}
	}
}