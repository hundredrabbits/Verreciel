//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructuresLibrary
{
	func none() -> SCNNode
	{
		let mesh = SCNNode()
		return mesh
	}
	
	func placeholder() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 3
		
		print("! Missing structure")
		
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
	
	func satellite(radius:Float = 1.5, color:UIColor = red) -> SCNNode
	{
		let mesh = SCNNode()
		let color:UIColor = cyan
		let sides:Int = 8
		let verticalOffset:Float = 5
		let radius:Float = 4
		
		let rand1 = 0.1 + (Float(arc4random_uniform(90))/100)
		let rand2 = 0.1 + (Float(arc4random_uniform(90))/100)
		
		var i = 0
		while i < sides {
			
			var e = 0
			while e < sides {
				let root = SCNNode()
				root.eulerAngles.y = Float(degToRad(CGFloat(Float(e) * Float(360/sides))))
				mesh.addChildNode(root)
				let branch1 = SCNLine(nodeA: SCNVector3(0,verticalOffset * rand1,radius * rand1 + 1), nodeB: SCNVector3((radius) * rand2,verticalOffset,radius * rand2 - 1), color: color)
				let branch2 = SCNLine(nodeA: SCNVector3(0,verticalOffset * rand1,radius * rand1 + 1), nodeB: SCNVector3((-radius) * rand2,verticalOffset,radius * rand2 - 1), color: color)
				root.addChildNode(branch1)
				root.addChildNode(branch2)
				branch1.addChildNode(SCNLine(nodeA: branch1.nodeB, nodeB: SCNVector3(radius * rand1 * rand2,verticalOffset,1 * rand2), color: grey))
				branch1.addChildNode(SCNLine(nodeA: branch1.nodeB, nodeB: SCNVector3(-radius * rand1 * rand2,verticalOffset,1 * rand2), color: grey))
				branch2.addChildNode(SCNLine(nodeA: branch2.nodeB, nodeB: SCNVector3(radius * rand1 * rand2,verticalOffset,1 * rand2), color: grey))
				branch2.addChildNode(SCNLine(nodeA: branch2.nodeB, nodeB: SCNVector3(-radius * rand1 * rand2,verticalOffset,1 * rand2), color: grey))
				e += 1
			}
			i += 1
		}
		
		return mesh
	}
	
	func harvest() -> SCNNode!
	{
		let mesh = SCNNode()
		let color:UIColor = cyan
		let sides:Int = 45
		let verticalOffset:Float = 12
		let radius:Float = 9
		
		var i = 0
		while i < sides {
			let root = SCNNode()
			root.eulerAngles.y = Float(degToRad(CGFloat(i * (360/sides))))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0.5,verticalOffset,radius), nodeB: SCNVector3(-0.5,verticalOffset,radius), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,verticalOffset,radius), nodeB: SCNVector3(0,verticalOffset + 5,radius), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0.5,verticalOffset + 5,radius), nodeB: SCNVector3(-0.5,verticalOffset + 5,radius), color: color))
			mesh.addChildNode(root)
			i += 1
		}
		
		let aim = SCNNode()
		i = 0
		while i < 3
		{
			let test = SCNLine(nodeA: SCNVector3(0,verticalOffset,0.75), nodeB: SCNVector3(0,verticalOffset,0.95), color: white)
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
		
		mesh.position = SCNVector3(0,4,0)
		
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
	
	func trade(radius:Float = 1.5, tunnels:Int = (Int(arc4random_uniform(3)) * 6), depth:Float = 0, color:UIColor = red) -> SCNNode
	{
		let mesh = SCNNode()
		
		let offset = SCNNode()
		offset.position = SCNVector3(0,2.75,0)
		mesh.addChildNode(offset)
		
		var i = 0
		while i < tunnels {
			let root = SCNNode()
			
			root.addChildNode(SCNLine(nodeA: SCNVector3(-radius,depth * Float(i),0), nodeB: SCNVector3(0,depth * Float(i),radius), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,depth * Float(i),radius), nodeB: SCNVector3(radius,depth * Float(i),0), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(radius,depth * Float(i),0), nodeB: SCNVector3(0,depth * Float(i) + 2,-radius), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,depth * Float(i) + 2,-radius), nodeB: SCNVector3(-radius,depth * Float(i),0), color: color))
			
			root.eulerAngles.y = Float(degToRad(CGFloat(i * (360/tunnels))))
			
			offset.addChildNode(root)
			i += 1
		}
		
		return mesh
	}
	
	func horadric(radius:Float = 2.5, tunnels:Int = 36, depth:Float = 0.5) -> SCNNode
	{
		let dome:Float = 3
		let strand:Float = 0.5
		
		let mesh = SCNNode()
		
		let offset = SCNNode()
		offset.position = SCNVector3(0,4,0)
		mesh.addChildNode(offset)
		
		var i = 0
		while i < tunnels {
			let root = SCNNode()
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,dome,-strand), nodeB: SCNVector3(0,dome,strand), color: white))
			root.eulerAngles.y = Float(degToRad(CGFloat(i * (360/tunnels))))
			root.eulerAngles.x = Float(degToRad(15))
			offset.addChildNode(root)
			
			let root2 = SCNNode()
			root2.addChildNode(SCNLine(nodeA: SCNVector3(0,dome,-strand), nodeB: SCNVector3(0,dome,strand), color: white))
			root2.eulerAngles.y = Float(degToRad(CGFloat(i * (360/tunnels))))
			root2.eulerAngles.x = Float(degToRad(35))
			offset.addChildNode(root2)
			
			let root3 = SCNNode()
			root3.addChildNode(SCNLine(nodeA: SCNVector3(0,dome,-strand), nodeB: SCNVector3(0,dome,strand), color: white))
			root3.eulerAngles.y = Float(degToRad(CGFloat(i * (360/tunnels))))
			root3.eulerAngles.x = Float(degToRad(55))
			offset.addChildNode(root3)
			
			let root4 = SCNNode()
			root4.addChildNode(SCNLine(nodeA: SCNVector3(0,dome,-strand), nodeB: SCNVector3(0,dome,strand), color: white))
			root4.eulerAngles.y = Float(degToRad(CGFloat(i * (360/tunnels))))
			root4.eulerAngles.x = Float(degToRad(75))
			offset.addChildNode(root4)
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
	
	// MARK: Constellations -

	func c_fog(color:UIColor = grey) -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 3
		
		print("! Missing structure")
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,0,0), nodeB: SCNVector3(-radius,0,0), color: color))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,radius,0), nodeB: SCNVector3(0,-radius,0), color: color))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,0,radius), nodeB: SCNVector3(0,0,-radius), color: color))
		
		return mesh
	}
	
	
	func c_tunnel(radius:Float = 1.5, color:UIColor = grey) -> SCNNode
	{
		let mesh = SCNNode()
		let color:UIColor = cyan
		let sides:Int = 6
		let verticalOffset:Float = 18
		let radius:Float = 10
		
		var i = 0
		while i < sides {
			
			var e = 0
			while e < sides {
				let root = SCNNode()
				let vert = (verticalOffset * Float(i) * 0.1)+verticalOffset
				root.eulerAngles.y = Float(degToRad(CGFloat(Float(e) * Float(360/sides))))
				root.addChildNode(SCNLine(nodeA: SCNVector3(radius/1.75,vert,radius), nodeB: SCNVector3(-radius/1.75,vert,radius), color: color))
				mesh.addChildNode(root)
				e += 1
			}
			i += 1
		}
		
		return mesh
	}
}