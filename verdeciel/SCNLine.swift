//  Created by Devine Lu Linvega on 2015-07-13.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNLine : Empty
{
	var vertices:Array<SCNVector3>!
	var color:UIColor! = nil
	
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
		if vertices.count % 2 == 1 { print("ERROR: Line vertices count is odd") ; return }
	
		self.vertices = vertices
		self.color = color
		
		var positionsList: [Float32] = []
		
		for vertex in vertices {
			positionsList.appendContentsOf([vertex.x,vertex.y,vertex.z])
		}
		
		if vertices.count == 3 { print(positionsList) }
		
		let positionData = NSData(bytes: positionsList, length: sizeof(Float32)*positionsList.count)
		
		var indices: [Int32]!
		
		if vertices.count == 2 { indices = [0, 1] }
		else if vertices.count == 4 { indices = [0, 1, 2, 3] }
		else if vertices.count == 6 { indices = [0, 1, 2, 3, 4, 5] }
		else if vertices.count == 8 { indices = [0, 1, 2, 3, 4, 5, 6, 7] }
		else if vertices.count == 10 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] }
		else if vertices.count == 12 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] }
		else if vertices.count == 14 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] }
		else if vertices.count == 16 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] }
		else if vertices.count == 18 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] }
		else if vertices.count == 20 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] }
		else if vertices.count == 22 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21] }
		else if vertices.count == 24 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23] }
		else if vertices.count == 26 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25] }
		else if vertices.count == 28 { indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27] }
		else { print("ERROR: Line has too many vertices") ; indices = [] }

		let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
		let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
		let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
		let line = SCNGeometry(sources: [source], elements: [element])
		line.firstMaterial?.lightingModelName = SCNLightingModelConstant
		line.firstMaterial?.diffuse.contents = color
		self.geometry = line
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