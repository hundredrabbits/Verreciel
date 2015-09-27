//
//  CameraNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//
import UIKit
import QuartzCore
import SceneKit
import Foundation

class CorePlayer : SCNNode
{
	var displayHealth:SCNLabel!
	var displayMagic:SCNLabel!
	
	var alertLabel:SCNLabel!
	var alertTimer:NSTimer!
	
	var health:Int
	var magic:Int
	
	var port:SCNPort!
	
	override init()
	{
		health = 99
		magic = 99
		
		super.init()
	
		// Camera
		self.camera = SCNCamera()
		self.camera?.xFov = 75
		self.name = "cameraNode"
		self.position = SCNVector3(x: 0, y: 0, z: 0)
		self.camera?.aperture = 100
		self.camera?.automaticallyAdjustsZRange = true
		
		addInterface()
		addHelmet()
	}
	
	override func update()
	{
		displayHealth.update("\(health)hp")
		displayMagic.update("\(magic)mp")
		
		if health < 0 {
			displayHealth.updateWithColor("dead",color: red)
		}
	}
	
	func addHelmet()
	{
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: -0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: 0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: 0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: -0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
	}
	
	func addInterface()
	{
		displayHealth = SCNLabel(text: "99hp", scale: 0.05, align: alignment.left)
		displayHealth.position = SCNVector3(x: -0.7, y: -1, z: -1.01)
		displayHealth.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(displayHealth)
		
		displayMagic = SCNLabel(text: "34mp", scale: 0.05, align: alignment.right)
		displayMagic.position = SCNVector3(x: 0.7, y: -1, z: -1.01)
		displayMagic.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(displayMagic)
		
		alertLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		alertLabel.position = SCNVector3(x: 0, y: 1, z: -1.01)
		alertLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(alertLabel)
	}
	
	func activatePort(port:SCNPort)
	{
		if self.port != nil {
			// Disconnect
			if self.port == port {
				self.port = nil
				port.disconnect()
				port.desactivate()
			}
			// New Connection
			else if self.port.polarity == true && port.polarity == false {
				self.port.connect(port)
				port.desactivate()
				self.port.desactivate()
				self.port = nil
				return
			}
		}
		else if port.polarity == true {
			// Select
			self.port = port
			self.port.activate()
		}
	}
	
	func desactivatePort()
	{
		self.port.desactivate()
	}
	
	func alert(text:String)
	{
		alertLabel.update(text)
		alertTimer = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: Selector("clearAlert"), userInfo: nil, repeats: false)
	}
	
	func clearAlert()
	{
		alertLabel.update("")
		alertTimer.invalidate()
	}
	
	override func tic()
	{
		if alertLabel.opacity == 0 { alertLabel.opacity = 1}
		else{ alertLabel.opacity = 0 }
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}