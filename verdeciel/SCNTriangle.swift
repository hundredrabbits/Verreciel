
//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNTriangle : SCNNode
{
	init(vertices:Array<SCNVector3>, color:UIColor)
	{
		super.init()
		
		let src = SCNGeometrySource(vertices: vertices, count: 3)
		let indexes: [CInt] = [0, 1, 2] // Changed to CInt
		
		let dat  = NSData(
			bytes: indexes,
			length: sizeof(CInt) * indexes.count // Changed to size of CInt * count
		)
		let ele = SCNGeometryElement(
			data: dat,
			primitiveType: .Triangles,
			primitiveCount: 1,
			bytesPerIndex: sizeof(CInt) // Changed to CInt
		)
		
		self.geometry = SCNGeometry(sources: [src], elements: [ele])
		self.geometry?.firstMaterial?.doubleSided = true
		self.geometry?.firstMaterial?.diffuse.contents = UIColor.blackColor()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}