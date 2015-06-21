//
//  tools.swift
//  verdeciel
//
//  Created by Devine Lu Linvega on 2014-09-25.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import Foundation
import SceneKit

func degToRad( degrees : Float ) -> Float
{
	return ( degrees / 180 * Float(M_PI) )
}

func line(nodeA: SCNVector3, nodeB: SCNVector3) -> SCNNode {
	
	let positions: [Float32] = [nodeA.x, nodeA.y, nodeA.z, nodeB.x, nodeB.y, nodeB.z]
	let positionData = NSData(bytes: positions, length: sizeof(Float32)*positions.count)
	let indices: [Int32] = [0, 1]
	let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
	let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
	let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
	let line = SCNGeometry(sources: [source], elements: [element])
	line.firstMaterial?.lightingModelName = SCNLightingModelConstant
	line.firstMaterial?.diffuse.contents = UIColor.whiteColor()
	return SCNNode(geometry: line)
}

func redLine(nodeA: SCNVector3, nodeB: SCNVector3) -> SCNNode {
	
	let positions: [Float32] = [nodeA.x, nodeA.y, nodeA.z, nodeB.x, nodeB.y, nodeB.z]
	let positionData = NSData(bytes: positions, length: sizeof(Float32)*positions.count)
	let indices: [Int32] = [0, 1]
	let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
	let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
	let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
	let line = SCNGeometry(sources: [source], elements: [element])
	line.firstMaterial?.lightingModelName = SCNLightingModelConstant
	line.firstMaterial?.diffuse.contents = UIColor.redColor()
	return SCNNode(geometry: line)
}

func cyanLine(nodeA: SCNVector3, nodeB: SCNVector3) -> SCNNode {
	
	let positions: [Float32] = [nodeA.x, nodeA.y, nodeA.z, nodeB.x, nodeB.y, nodeB.z]
	let positionData = NSData(bytes: positions, length: sizeof(Float32)*positions.count)
	let indices: [Int32] = [0, 1]
	let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
	let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
	let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
	let line = SCNGeometry(sources: [source], elements: [element])
	line.firstMaterial?.lightingModelName = SCNLightingModelConstant
	line.firstMaterial?.diffuse.contents = UIColor(red: 0.44, green: 0.87, blue: 0.76, alpha: 1)
	return SCNNode(geometry: line)
}