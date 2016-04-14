//  Created by Devine Lu Linvega on 2015-07-13.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNLine : SCNNode
{
	var positions:Array<SCNVector3>!
	var nodeB:SCNVector3! = nil
	var color:UIColor! = nil
	
	init(positions:Array<SCNVector3>, color:UIColor = white)
	{
		self.positions = positions
		self.color = color
		
		super.init()
		
		draw(positions, color: self.color)
	}
	
	func draw(vertices:Array<SCNVector3>, color:UIColor)
	{
		if vertices.count < 2 { return }
	
		var positionsList: [Float32] = []
		
		for vertex in vertices {
			positionsList.appendContentsOf([vertex.x,vertex.y,vertex.z])
		}
		
		if vertices.count == 3 { print(positionsList) }
		
		let positionData = NSData(bytes: positionsList, length: sizeof(Float32)*positionsList.count)
		let indices: [Int32] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
		let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
		let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
		let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
		let line = SCNGeometry(sources: [source], elements: [element])
		line.firstMaterial?.lightingModelName = SCNLightingModelConstant
		line.firstMaterial?.diffuse.contents = color
		self.geometry = line
		opacity = 1
	}
	
	func updateHeight(height:Float)
	{
		self.nodeB = SCNVector3(nodeB.x,height,nodeB.z)
		draw(positions, color: color)
	}
	
	func reset()
	{
		geometry = nil
		opacity = 0
	}
	
	func updateColor(color:UIColor)
	{
		if color == self.color { return }
		self.color = color
		draw(positions, color: color)
	}
	
	func update(color:UIColor)
	{
		if color == self.color { return }
		self.color = color
		draw(positions, color: color)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}