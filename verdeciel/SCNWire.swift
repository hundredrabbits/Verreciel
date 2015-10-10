//
//  SCNToggle.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNWire : SCNNode
{
	var nodeA:SCNVector3!
	var nodeB:SCNVector3!
	var color:UIColor!
	
	init(nodeA: SCNVector3 = SCNVector3(), nodeB: SCNVector3 = SCNVector3())
	{
		super.init()
		color = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
		draw(nodeA, nodeB: nodeB, color: color)
	}
	
	func update(nodeA: SCNVector3 = SCNVector3(), nodeB: SCNVector3 = SCNVector3())
	{
		draw(nodeA, nodeB: nodeB, color: self.color)
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
	
	func reset()
	{
		self.geometry = nil
	}
	
	override func color(color: UIColor)
	{
		
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}