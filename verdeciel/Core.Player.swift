//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CorePlayer : SCNNode
{
	var canAlign:Bool = true
	
	var displayHealth:SCNLabel!
	var displayMagic:SCNLabel!
	
	var messageLabel:SCNLabel!
	var messageTimer:NSTimer!
	
	var alertLabel:SCNLabel!
	var alertTimer:NSTimer!
	var alertIsActive:Bool = false
	
	var health:Int
	var magic:Int
	
	var port:SCNPort!
	var event:Event!
	
	var trigger:SCNTrigger!
	var triggerLabel:SCNLabel!
	
	var isLocked:Bool = false
	
	override init()
	{
		health = 99
		magic = 99
		
		super.init()
		
		self.camera = SCNCamera()
		self.camera?.xFov = 75
		self.name = "helmet"
		self.position = SCNVector3(x: 0, y: 0, z: 0)
		self.camera?.aperture = 100
		self.camera?.automaticallyAdjustsZRange = true
		
		port = SCNPort(host: self, input: Event.self, output: Event.self)
		port.enable()
		
		addInterface()
	}
	
	func addInterface()
	{
		trigger = SCNTrigger(host: self, size: CGSize(width: 2,height: 0.75))
		trigger.position = SCNVector3(x: 0, y: 0.9, z: -1.01)
		trigger.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0))
		trigger.opacity = 0
		addChildNode(trigger)
		
		triggerLabel = SCNLabel(text: "return to capsule", scale: 0.03, align: alignment.center, color: red)
		triggerLabel.position = SCNVector3(0,0,0)
		trigger.addChildNode(triggerLabel)
		
		alertLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		alertLabel.position = SCNVector3(x: 0, y: 1, z: -1.01)
		alertLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(alertLabel)
		
		messageLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		messageLabel.position = SCNVector3(x: 0, y: 1.1, z: -1.01)
		messageLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(messageLabel)
	}
	
	func activateEvent(event:Event)
	{
		self.event = event
	}
	
	func message(text:String)
	{
		messageLabel.update(text)
		messageTimer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(self.clearMessage), userInfo: nil, repeats: false)
	}
	
	func clearMessage()
	{
		messageLabel.update("")
	}
	
	func alert(text:String)
	{
		alertIsActive = true
		alertLabel.update(text)
		alertTimer = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: #selector(self.clearAlert), userInfo: nil, repeats: false)
	}
	
	func clearAlert()
	{
		alertIsActive = false
		alertTimer.invalidate()
		alertLabel.update("")
		alertLabel.opacity = 0
	}
	
	var accelX:Float = 0
	var accelY:Float = 0
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		flickerAlert()
        
        if !isLocked {
            player.eulerAngles.x += accelX
            player.eulerAngles.y += accelY

            //should keep the values within 2pi rads
            player.eulerAngles.x = Float(Double(player.eulerAngles.x))
            player.eulerAngles.y = Float(Double(player.eulerAngles.y))

            //dampening
            // closer to 1 for more 'momentum'
            accelX *= 0.75
            accelY *= 0.75
            if abs(accelX) < 0.005 {
                accelX = 0; //if it gets too small just drop to zero
            }
            if abs(accelY) < 0.005 {
                accelY = 0; //if it gets too small just drop to zero
            }
        }
	}
	
	func flickerAlert()
	{
		if alertIsActive == false { return }
		if alertLabel.opacity == 0 { alertLabel.opacity = 1}
		else{ alertLabel.opacity = 0 }
	}
	
	func lookAt(position:SCNVector3 = SCNVector3(0,0,0),deg:CGFloat)
	{
		let normalizedDeg = radToDeg(CGFloat(player.eulerAngles.y)) % 360
		player.eulerAngles.y = Float(degToRad(normalizedDeg))
		helmet.eulerAngles.y = Float(degToRad(normalizedDeg))
		
		print("+ PLAYER   | LookAt(from:\(radToDeg(CGFloat(player.eulerAngles.y))),to:\(deg))")
		
		player.isLocked = true
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		
		player.position = position
		player.eulerAngles.y = Float(degToRad(deg))
		helmet.position = position
		helmet.eulerAngles.y = Float(degToRad(deg))
		
		SCNTransaction.setCompletionBlock({ player.isLocked = false })
		SCNTransaction.commit()
		
		releaseHandle()
	}
	
	// MARK: Left Hand -
	
	var activePort:SCNPort!
	
	func holdPort(port:SCNPort)
	{
		if port.host != nil && port.host.name != nil { helmet.leftHandLabel.update("\(port.host!.name!)", color: white) }
		
		activePort = port
		port.activate()
	}
	
	func connectPorts(from:SCNPort,to:SCNPort)
	{
		helmet.leftHandLabel.update("--", color: grey)
		
		activePort = nil
		from.connect(to)
		from.desactivate()
		to.desactivate()
		from.update()
		to.update()
	}
	
	func releasePort()
	{
		helmet.leftHandLabel.update("--", color: grey)
		
		activePort.desactivate()
		activePort.disconnect()
		activePort = nil
	}
	
	// MARK: Right Hand -

	var activeHandle:SCNHandle!
	var handleTimer:NSTimer!
	
	func holdHandle(handle:SCNHandle)
	{
		releaseHandle()
		
		helmet.rightHandLabel.update(handle.host.name!, color: white)
		
		activeHandle = handle
		activeHandle.disable()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		player.position = activeHandle.destination
		helmet.position = activeHandle.destination
		SCNTransaction.commit()
		
		player.handleTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.releaseHandleAuto), userInfo: nil, repeats: false)
	}
	
	func releaseHandle()
	{
		helmet.rightHandLabel.update("--", color: grey)
		
		if activeHandle == nil { return }
		activeHandle.enable()
		activeHandle = nil
		
		if player.handleTimer != nil { player.handleTimer.invalidate() }
	}
	
	func releaseHandleAuto()
	{
		helmet.rightHandLabel.update("--", color: grey)
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		player.position = SCNVector3(0,0,0)
		helmet.position = SCNVector3(0,0,0)
		SCNTransaction.commit()
		
		activeHandle.enable()
		activeHandle = nil
	}
	
	override func onConnect()
	{
		if port.isReceivingFromPanel(map) == true { radar.modeOverview() }
	}
	
	override func onDisconnect()
	{
		if port.isReceivingFromPanel(map) != true { radar.modeNormal() }
	}
	
	// MARK: Default -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}