//
//  GameViewController.swift
//  verdeciel
//
//  Created by Devine Lu Linvega on 2014-09-21.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

var scene = SCNScene()
var touchOrigin = CGPoint()

let scaleValue : Float = 0.01

var black:UIColor = UIColor(white: 0, alpha: 1)
var grey:UIColor = UIColor(white: 0.4, alpha: 1)
var greyTone:UIColor = UIColor(white: 0.2, alpha: 1)
var white:UIColor = UIColor.whiteColor()
var whiteTone:UIColor = UIColor(white: 0.8, alpha: 1)
var red:UIColor = UIColor.redColor()
var redTone:UIColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
var cyan:UIColor = UIColor(red: 0.44, green: 0.87, blue: 0.76, alpha: 1)
var cyanTone:UIColor = UIColor(red: 0.24, green: 0.67, blue: 0.56, alpha: 1)
var clear:UIColor = UIColor(white: 0, alpha: 0)

var ceilingNode:Array<SCNVector3>!
var highMidNode:Array<SCNVector3>!
var highGapNode:Array<SCNVector3>!
var highNode:Array<SCNVector3>!
var lowNode:Array<SCNVector3>!
var lowGapNode:Array<SCNVector3>!
var lowMidNode:Array<SCNVector3>!
var floorNode:Array<SCNVector3>!

var radar:PanelRadar!
var battery:PanelBattery!
var console:PanelConsole!
var custom:PanelCustom!

var pilot:PanelPilot!
var thruster:PanelThruster!
var beacon:PanelHatch!
var cargo:PanelCargo!

var monitor:PanelMonitor!
var window:PanelWindow!

var radio:PanelRadio!
var translator:PanelTranslator!

var time:CoreTime!
var universe:CoreUniverse!
var capsule:CoreCapsule!
var player:CorePlayer!
var space:CoreSpace!

var cameraNode:SCNNode!

var itemLibrary = ItemLibrary()
var locationLibrary = LocationLibrary()

enum alignment {
	case left
	case center
	case right
}

enum sectors {
	case opal
	case cyanine
	case vermiles
	case normal
	case void
}

enum eventTypes {
	case unknown
	
	case portal
	case cargo
	case station
	case beacon
	case city
	case star
	case cell
	
	case stack
	case location
	case item
	case npc
	case battery
	case waypoint
	case ammo
	case cypher
	case map
	case warp
}

enum eventDetails {
	case unknown
	case battery
	case card
}

enum services
{
	case none
	case electricity
	case hull
}

class GameViewController: UIViewController
{
    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		universe = CoreUniverse()
		
		capsule = CoreCapsule()
		scene.rootNode.addChildNode(capsule)
		
		player = CorePlayer()
		scene.rootNode.addChildNode(player)
		
		space = CoreSpace()
		scene.rootNode.addChildNode(space)
		
		time = CoreTime()
		
		let scnView = self.view as! SCNView
		scnView.scene = scene
		scnView.showsStatistics = false
		scnView.backgroundColor = UIColor.blackColor()
		scnView.antialiasingMode = SCNAntialiasingMode.None
		scnView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
		
		cameraNode = scene.rootNode.childNodeWithName("cameraNode", recursively: true)!
		
		time.start()
		capsule.start()
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		for touch: AnyObject in touches {
			touchOrigin = touch.locationInView(self.view)
		}
	}
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		var touchPosition = CGPoint()
		for touch: AnyObject in touches {
			touchPosition = touch.locationInView(self.view)
		}
		
		let dragX = CGFloat(touchPosition.x - touchOrigin.x)
		let dragY = CGFloat(touchPosition.y - touchOrigin.y)
		
		touchOrigin = touchPosition

		cameraNode.eulerAngles.x += Float(degToRad(dragY/4))
		cameraNode.eulerAngles.y += Float(degToRad(dragX/4))
	}
	
	func handleTap(gestureRecognize: UIGestureRecognizer)
	{
		let scnView = self.view as! SCNView
		let p = gestureRecognize.locationInView(scnView)
		
		let hitResults = scnView.hitTest(p, options: nil)
		
		if hitResults.count > 0
		{
			let result: AnyObject! = hitResults[0]
			result.node.touch()
		}
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
}

func degToRad(degrees:CGFloat) -> CGFloat
{
	return degrees / 180 * CGFloat(M_PI)
}

func radToDeg(value:CGFloat) -> CGFloat
{
	return CGFloat(Double(value) * 180.0 / M_PI)
}

func distanceBetweenTwoPoints(point1:CGPoint,point2:CGPoint) -> CGFloat
{
	let xDist:CGFloat = (point2.x - point1.x)
	let yDist:CGFloat = (point2.y - point1.y)
	return sqrt((xDist * xDist) + (yDist * yDist))
}

func angleBetweenTwoPoints(point1:CGPoint,point2:CGPoint,center:CGPoint) -> CGFloat
{
	let v1 = CGVector(dx: point1.x - center.x, dy: point1.y - center.y)
	let v2 = CGVector(dx: point2.x - center.x, dy: point2.y - center.y)
	let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
	var deg = angle * CGFloat(180.0 / M_PI)
	if deg < 0 { deg += 360.0 }
	return deg
}

/*
SCNTransaction.begin()
SCNTransaction.setAnimationDuration(1.5)
cameraNode.orientation = self.orientation
SCNTransaction.setCompletionBlock({ })
SCNTransaction.commit()

SCNTransaction.begin()
SCNTransaction.setAnimationDuration(3)
cameraNode.position = self.destination
SCNTransaction.setCompletionBlock({ })
SCNTransaction.commit()
*/
