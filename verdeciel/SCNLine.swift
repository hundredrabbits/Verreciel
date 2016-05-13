//  Created by Devine Lu Linvega on 2015-07-13.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNLine : Empty
{
	var vertices:Array<SCNVector3>
	var color:UIColor
	
	init(vertices:Array<SCNVector3>, color:UIColor = white)
	{
		self.vertices = vertices
		self.color = color
		
		super.init()
		
		update(vertices, color: self.color)
	}
	
	func update(vertices:Array<SCNVector3>, color:UIColor)
	{
		if vertices.count < 2 { return }
		if vertices.count % 2 == 1 { return }
	
		self.vertices = vertices
		self.color = color
		
		let geoSrc = SCNGeometrySource(vertices: UnsafePointer<SCNVector3>(vertices), count: vertices.count)
		
		var i:Int32 = 0
        var indexes = [Int32]()
		while i < Int32(vertices.count) {
            indexes += [i, i+1]
			i += 2
		}
        
        // PrimitiveCount should be the number of lines, not the number of vertices.
        let geoElement = SCNGeometryElement(data: NSData(bytes: indexes, length: (sizeof(Int32) * indexes.count)), primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indexes.count / 2, bytesPerIndex: sizeof(Int32))
		
		self.geometry = SCNGeometry(sources: [geoSrc], elements: [geoElement])
		self.geometry!.firstMaterial?.lightingModelName = SCNLightingModelConstant
		self.geometry!.firstMaterial?.diffuse.contents = color
		opacity = 1
	}
	
	func reset()
	{
		geometry = nil
		opacity = 0
	}
	
	func update(color:UIColor)
	{
		if color == self.color { return }
		self.color = color
		update(vertices, color: color)
	}
	
	func update(vertices:Array<SCNVector3>)
	{
		self.vertices = vertices
		update(vertices, color: color)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}