//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructuresLibrary
{
	func placeholder() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 3
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius,radius,0), nodeB: SCNVector3(0,radius,radius), color: grey))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,radius,radius), nodeB: SCNVector3(radius,radius,0), color: grey))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,radius,0), nodeB: SCNVector3(0,radius,-radius), color: grey))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,radius,-radius), nodeB: SCNVector3(-radius,radius,0), color: grey))
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius,-radius,0), nodeB: SCNVector3(0,-radius,radius), color: grey))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,-radius,radius), nodeB: SCNVector3(radius,-radius,0), color: grey))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,-radius,0), nodeB: SCNVector3(0,-radius,-radius), color: grey))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,-radius,-radius), nodeB: SCNVector3(-radius,-radius,0), color: grey))
		
		return mesh
	}
	
	func cargo() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 1
		let color:UIColor = white
		
		let root = SCNNode()
		
		root.addChildNode(SCNLine(nodeA: SCNVector3(-radius,radius,0), nodeB: SCNVector3(0,radius,radius), color: color))
		root.addChildNode(SCNLine(nodeA: SCNVector3(0,radius,radius), nodeB: SCNVector3(radius,radius,0), color: color))
		root.addChildNode(SCNLine(nodeA: SCNVector3(radius,radius,0), nodeB: SCNVector3(0,radius,-radius), color: color))
		root.addChildNode(SCNLine(nodeA: SCNVector3(0,radius,-radius), nodeB: SCNVector3(-radius,radius,0), color: color))
		
		root.addChildNode(SCNLine(nodeA: SCNVector3(-radius,-radius,0), nodeB: SCNVector3(0,-radius,radius), color: color))
		root.addChildNode(SCNLine(nodeA: SCNVector3(0,-radius,radius), nodeB: SCNVector3(radius,-radius,0), color: color))
		root.addChildNode(SCNLine(nodeA: SCNVector3(radius,-radius,0), nodeB: SCNVector3(0,-radius,-radius), color: color))
		root.addChildNode(SCNLine(nodeA: SCNVector3(0,-radius,-radius), nodeB: SCNVector3(-radius,-radius,0), color: color))
		
		root.addChildNode(SCNLine(nodeA: SCNVector3(radius,radius,0), nodeB: SCNVector3(radius,-radius,0), color: color))
		root.addChildNode(SCNLine(nodeA: SCNVector3(-radius,radius,0), nodeB: SCNVector3(-radius,-radius,0), color: color))
		root.addChildNode(SCNLine(nodeA: SCNVector3(0,radius,radius), nodeB: SCNVector3(0,-radius,radius), color: color))
		root.addChildNode(SCNLine(nodeA: SCNVector3(0,radius,-radius), nodeB: SCNVector3(0,-radius,-radius), color: color))
		
		root.addChildNode(SCNLine(nodeA: SCNVector3(-radius/2,radius,-radius/2), nodeB: SCNVector3(radius/2,radius,radius/2), color: grey))
		root.addChildNode(SCNLine(nodeA: SCNVector3(radius/2,-radius,-radius/2), nodeB: SCNVector3(-radius/2,-radius,radius/2), color: grey))
		
		root.position = SCNVector3(0,4,0)
		mesh.addChildNode(root)
		
		return mesh
	}
	
	func cyanine() -> SCNNode!
	{
		let mesh = SCNNode()
		let color:UIColor = cyan
		let sides:Int = 90
		let verticalOffset:Float = 4
		
		var i = 0
		while i < sides {
			let line = SCNLine(nodeA: SCNVector3(-0.75,-0.25,2.25), nodeB: SCNVector3(1,0.25,-2), color: color)
			line.position = SCNVector3(0,verticalOffset,2.25)
			let root = SCNNode()
			root.eulerAngles.y = Float(degToRad(CGFloat(i * (360/sides))))
			root.addChildNode(line)
			mesh.addChildNode(root)
			i += 1
		}
		
		let aim = SCNNode()
		i = 0
		while i < 3
		{
			let test = SCNLine(nodeA: SCNVector3(0,verticalOffset * 2,0.75), nodeB: SCNVector3(0,verticalOffset * 2,0.85), color: white)
			test.eulerAngles.y = Float(degToRad(CGFloat(120 * i)))
			aim.addChildNode(test)
			i += 1
		}
		mesh.addChildNode(aim)
		
		return mesh
	}
	
	func star() -> SCNNode
	{
		let mesh = SCNNode()
		var radius:Float = 2.75
		let distance:Float = 0
		
		var i = 0
		while i < 20 {
			radius -= 0.125
			
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius * 1.5,distance,0), nodeB: SCNVector3(radius,distance,-radius * 1.5), color: red))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius * 1.5,distance,0), nodeB: SCNVector3(radius,distance,radius * 1.5), color: red))
			
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius * 1.5,distance,0), nodeB: SCNVector3(-radius,distance,-radius * 1.5), color: red))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius * 1.5,distance,0), nodeB: SCNVector3(-radius,distance,radius * 1.5), color: red))
			
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,-radius * 1.5), nodeB: SCNVector3(-radius,distance,-radius * 1.5), color: red))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,radius * 1.5), nodeB: SCNVector3(-radius,distance,radius * 1.5), color: red))
			
			i++
		}
		
		return mesh
	}
	
	func portal(radius:Float = 5, sides:Int = 72, depth:Float = 0.5, color:UIColor = red) -> SCNNode
	{
		let mesh = SCNNode()
		let verticalOffset:Float = 8
		
		var i = 0
		while i < sides {
			let root = SCNNode()
			root.addChildNode(SCNLine(nodeA: SCNVector3(-radius,verticalOffset * 3,0), nodeB: SCNVector3(0,verticalOffset/2,radius), color: color))
			mesh.addChildNode(root)
			root.eulerAngles.y = Float(degToRad(CGFloat(i * (360/sides))))
			i += 1
		}
		
		return mesh
	}
	
	func trade(radius:Float = 2.5, tunnels:Int = 30, depth:Float = 0.5) -> SCNNode
	{
		let mesh = SCNNode()
		
		let offset = SCNNode()
		offset.position = SCNVector3(0,2.75,0)
		mesh.addChildNode(offset)
		
		var i = 0
		while i < tunnels {
			let root = SCNNode()
			
			root.addChildNode(SCNLine(nodeA: SCNVector3(-radius,depth * Float(i),0), nodeB: SCNVector3(0,depth * Float(i),radius), color: white))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,depth * Float(i),radius), nodeB: SCNVector3(radius,depth * Float(i),0), color: white))
			root.addChildNode(SCNLine(nodeA: SCNVector3(radius,depth * Float(i),0), nodeB: SCNVector3(0,depth * Float(i),-radius), color: white))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,depth * Float(i),-radius), nodeB: SCNVector3(-radius,depth * Float(i),0), color: white))
			
			offset.addChildNode(root)
			i += 1
		}
		
		return mesh
	}
	
	func horadric(radius:Float = 2.5, tunnels:Int = 45, depth:Float = 0.5) -> SCNNode
	{
		let mesh = SCNNode()
		
		let offset = SCNNode()
		offset.position = SCNVector3(0,2.75,0)
		mesh.addChildNode(offset)
		
		var i = 0
		while i < tunnels {
			let root = SCNNode()
			let line = SCNLine(nodeA: SCNVector3(radius,0,0), nodeB: SCNVector3(radius + 1,0,0), color: white)
			line.eulerAngles.y = Float(degToRad(CGFloat(i * (360/tunnels))))
			root.addChildNode(line)
			
			let line2 = SCNLine(nodeA: SCNVector3(radius,0,0), nodeB: SCNVector3(radius - 0.5,radius,0), color: grey)
			line.addChildNode(line2)
			
			let line3 = SCNLine(nodeA: SCNVector3(radius - 0.5,radius,0), nodeB: SCNVector3(radius - 0.7,radius,0), color: white)
			line.addChildNode(line3)
			
			offset.addChildNode(root)
			i += 1
		}
		
		return mesh
	}
	
	func beacon() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 4
		let color:UIColor = red
		let sides:Int = 8
		let verticalOffset:Float = 5
		
		var i = 0
		while i < sides {
			let root = SCNNode()
			
			let counter:Float = 0
			root.addChildNode(SCNLine(nodeA: SCNVector3(-radius,verticalOffset + counter,0), nodeB: SCNVector3(0,verticalOffset + counter,radius), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,verticalOffset + counter,radius), nodeB: SCNVector3(radius,verticalOffset + counter,0), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(radius,verticalOffset + counter,0), nodeB: SCNVector3(0,verticalOffset + counter,-radius), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,verticalOffset + counter,-radius), nodeB: SCNVector3(-radius,verticalOffset + counter,0), color: color))
			
			let test = CGFloat(i * (360/sides/3))
			
			mesh.addChildNode(root)
			
			root.eulerAngles.y = Float(degToRad(test))
			i += 1
		}
		
		let aim = SCNNode()
		i = 0
		while i < 3
		{
			let test = SCNLine(nodeA: SCNVector3(0,verticalOffset/3,0.75), nodeB: SCNVector3(0,verticalOffset/3,0.85), color: white)
			test.eulerAngles.y = Float(degToRad(CGFloat(120 * i)))
			aim.addChildNode(test)
			i += 1
		}
		mesh.addChildNode(aim)
		
		return mesh
	}
	
	func station() -> SCNNode
	{
		let mesh = SCNNode()
		return mesh
	}
}