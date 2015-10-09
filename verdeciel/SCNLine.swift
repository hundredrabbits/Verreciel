//
//  SCNLine.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-13.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNLine : SCNNode
{
	var nodeA = SCNVector3()
	var nodeB = SCNVector3()
	var color = UIColor()
	
	init(nodeA: SCNVector3 = SCNVector3(), nodeB: SCNVector3 = SCNVector3(), color:UIColor = white)
	{
		self.nodeA = nodeA
		self.nodeB = nodeB
		self.color = color
		
		super.init()
		
		draw(self.nodeA, nodeB: self.nodeB, color: self.color)
	}
	
	func draw(nodeA: SCNVector3, nodeB: SCNVector3, color:UIColor)
	{
		let positions: [Float32] = [nodeA.x, nodeA.y, nodeA.z, nodeB.x, nodeB.y, nodeB.z]
		let positionData = NSData(bytes: positions, length: sizeof(Float32)*positions.count)
		let indices: [Int32] = [0, 1]
		let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
		let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
		let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
		let line = SCNGeometry(sources: [source], elements: [element])
		line.firstMaterial?.lightingModelName = SCNLightingModelConstant
		line.firstMaterial?.diffuse.contents = color
		self.geometry = line
	}
	
	func updateHeight(height:Float)
	{
		draw(self.nodeA, nodeB: SCNVector3(nodeB.x,height,nodeB.z), color: self.color)
	}
	
	func updateColor(color:UIColor)
	{
		draw(nodeA, nodeB: nodeB, color: color)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}