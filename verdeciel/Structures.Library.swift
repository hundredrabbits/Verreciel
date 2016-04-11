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
	
	func star(color:UIColor = red) -> SCNNode
	{
		let mesh = SCNNode()
		var radius:Float = 2.75
		let distance:Float = 0
		
		var i = 0
		while i < 20 {
			radius -= 0.125
			
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius * 1.5,distance,0), nodeB: SCNVector3(radius,distance,-radius * 1.5), color: color))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius * 1.5,distance,0), nodeB: SCNVector3(radius,distance,radius * 1.5), color: color))
			
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius * 1.5,distance,0), nodeB: SCNVector3(-radius,distance,-radius * 1.5), color: color))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius * 1.5,distance,0), nodeB: SCNVector3(-radius,distance,radius * 1.5), color: color))
			
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,-radius * 1.5), nodeB: SCNVector3(-radius,distance,-radius * 1.5), color: color))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,radius * 1.5), nodeB: SCNVector3(-radius,distance,radius * 1.5), color: color))
			
			i += 1
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
	
	func gateway(radius:Float = 5, sides:Int = 16, depth:Float = 0.5, color:UIColor = red) -> SCNNode
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
	
	// MARK: Constellations -

	func c_fog(color:UIColor = grey) -> SCNNode
	{
		let mesh = SCNNode()
		
		let hex1 = SCNHexa(size: 6, color: grey)
		hex1.position = SCNVector3(0,0,2)
		mesh.addChildNode(hex1)
		let hex2 = SCNHexa(size: 6, color: grey)
		hex2.position = SCNVector3(0,0,0)
		mesh.addChildNode(hex2)
		let hex3 = SCNHexa(size: 6, color: grey)
		hex3.position = SCNVector3(0,0,-2)
		mesh.addChildNode(hex3)
		let hex4 = SCNHexa(size: 6, color: grey)
		hex4.position = SCNVector3(0,0,4)
		mesh.addChildNode(hex4)
		let hex5 = SCNHexa(size: 6, color: grey)
		hex5.position = SCNVector3(0,0,-4)
		mesh.addChildNode(hex5)
		
		mesh.eulerAngles.x = Float(degToRad(90))
		
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
	
	func c_door(color:UIColor = grey) -> SCNNode
	{
		let mesh = SCNNode()
		
		let hex1 = SCNHexa(size: 6, color: grey)
		hex1.position = SCNVector3(0,0,0)
		mesh.addChildNode(hex1)
		let hex2 = SCNHexa(size: 6, color: grey)
		hex2.position = SCNVector3(0,0,0)
		mesh.addChildNode(hex2)
		hex2.eulerAngles.z = Float(degToRad(45))
		let hex3 = SCNHexa(size: 6, color: grey)
		hex3.position = SCNVector3(0,0,0)
		mesh.addChildNode(hex3)
		hex3.eulerAngles.z = Float(degToRad(-45))
		
		mesh.eulerAngles.x = Float(degToRad(90))
		
		return mesh
	}
	
	func c_portal(radius:Float = 5, sides:Int = 32, depth:Float = 0.5, color:UIColor = red) -> SCNNode
	{
		let mesh = SCNNode()
		
		var i = 0
		while i <= sides {
			let root = SCNNode()
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,0,radius), nodeB: SCNVector3(0,500,radius + 20), color: color))
			mesh.addChildNode(root)
			root.eulerAngles.y = Float(degToRad(CGFloat(i * (360/sides))))
			i += 1
		}
		
		return mesh
	}
}