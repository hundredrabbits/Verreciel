
//  Created by Devine Lu Linvega on 2016-04-22.
//  Copyright © 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Empty : SCNNode
{
	override init()
	{
		super.init()
	}
	
	func touch(id:Int = 0)
	{
		print("! This node has no touch action")
	}
	
	func update()
	{
	}
	
	func empty()
	{
		for node in childNodes {
			node.removeFromParentNode()
		}
	}
	
	func blink()
	{
		if game.time % 3 == 0 { opacity = 1 }
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
		for node in self.childNodes as! [Empty] {
			node.color(color)
			node.updateChildrenColors(color)
		}
	}
	
	func color(color:UIColor)
	{
		if geometry == nil { return }
		if (self is SCNLine) == false { return }
		
		(self as! SCNLine).update(color)
	}
	
	// MARK: Events -
	
	func whenStart()
	{
		for node in childNodes as! [Empty] {
			node.whenStart()
		}
	}
	
	func whenTime()
	{
		for node in childNodes as! [Empty] {
			node.whenTime()
		}
	}
	
	func whenRenderer()
	{
		for node in childNodes as! [Empty] {
			node.whenRenderer()
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
	
	func onMissionComplete()
	{
		
	}
	
	// MARK: Extras -
	
	func payload() -> ConsolePayload
	{
		return ConsolePayload(data:[ConsoleData(text: "[missing]", details: "[missing]")])
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}