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

var heading = Double(0.0)
var attitude = Double(0.0)
var bank = 0.0
let scaleValue : Float = 0.01

var eventTime = 0

var white:UIColor = UIColor.whiteColor()
var red:UIColor = UIColor.redColor()
var cyan:UIColor = UIColor(red: 0.44, green: 0.87, blue: 0.76, alpha: 1)
var clear:UIColor = UIColor(white: 0, alpha: 0)
var grey:UIColor = UIColor(white: 0.4, alpha: 1)

var ceilingNode:Array<SCNVector3>!
var highMidNode:Array<SCNVector3>!
var highNode:Array<SCNVector3>!
var lowNode:Array<SCNVector3>!
var lowMidNode:Array<SCNVector3>!
var floorNode:Array<SCNVector3>!

var radar:PanelRadar!
var navigation:PanelNavigation!
var monitor:PanelMonitor!
var thruster:PanelThruster!
var breaker:PanelBreaker!
var beacon:PanelBeacon!
var radio:PanelRadio!
var console:PanelConsole!
var scanner:PanelScanner!

var time:CoreTime!
var universe:CoreUniverse!
var capsule:CoreCapsule!
var player:CorePlayer!

enum alignment {
	case left
	case center
	case right
}
enum cardinals {
	case n
	case ne
	case e
	case se
	case s
	case sw
	case w
	case nw
}
enum eventTypes {
	case unknown
	case station
	case star
	case sentry
	case warp
	case missle
}

class GameViewController: UIViewController
{
    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		capsule = CoreCapsule()
		scene.rootNode.addChildNode(capsule)
		
		player = CorePlayer()
		scene.rootNode.addChildNode(player)
		
		universe = CoreUniverse()
		time = CoreTime()
		
		sceneComplete()
	}
	
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
	{
		for touch: AnyObject in touches {
			touchOrigin = touch.locationInView(self.view)
		}
	}
	
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
	{
		var touchPosition = CGPoint()
		for touch: AnyObject in touches {
			touchPosition = touch.locationInView(self.view)
		}
		
		var dragX = Float(touchPosition.x - touchOrigin.x)
		var dragY = Float(touchPosition.y - touchOrigin.y)
		
		touchOrigin = touchPosition
		
		let xAngle = SCNMatrix4MakeRotation(degToRad(dragY/4), 1, 0, 0)
		let yAngle = SCNMatrix4MakeRotation(degToRad(dragX/5), 0, 1, 0)
		let zAngle = SCNMatrix4MakeRotation(degToRad(0), 0, 0, 1)
		
		var rotationMatrix = SCNMatrix4Mult(SCNMatrix4Mult(xAngle, yAngle), zAngle)
		var cameraNode = scene.rootNode.childNodeWithName("cameraNode", recursively: true)!
		cameraNode.transform = SCNMatrix4Mult(rotationMatrix, cameraNode.transform )
	}
	
	func handleTap(gestureRecognize: UIGestureRecognizer)
	{
		let scnView = self.view as! SCNView

		let p = gestureRecognize.locationInView(scnView)
		if let hitResults = scnView.hitTest(p, options: nil) {
			
			if hitResults.count < 1 { return }
			
			let result: AnyObject! = hitResults[0]
			
			if result.node.isKindOfClass(SCNKnob) { (result.node as! SCNKnob).touch() }
			else if result.node.isKindOfClass(SCNToggle) { (result.node as! SCNToggle).touch() }
			else if result.node.isKindOfClass(SCNArrow) { (result.node as! SCNArrow).touch() }
			else if result.node.isKindOfClass(SCNLink) { (result.node as! SCNLink).touch() }
			else{ println(result) }
		}
	}
	
	func sceneComplete()
	{
		let scnView = self.view as! SCNView
		scnView.scene = scene
		scnView.showsStatistics = false
		scnView.backgroundColor = UIColor.blackColor()
		scnView.antialiasingMode = SCNAntialiasingMode.None
		
		let gestureRecognizers = NSMutableArray()
		gestureRecognizers.addObject(UITapGestureRecognizer(target: self, action: "handleTap:"))
		if let existingGestureRecognizers = scnView.gestureRecognizers {
			gestureRecognizers.addObjectsFromArray(existingGestureRecognizers)
		}
		scnView.gestureRecognizers = gestureRecognizers as [AnyObject]
	}
	
	//
	
	override func shouldAutorotate() -> Bool {
		return true
	}
	
	override func supportedInterfaceOrientations() -> Int {
		if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
			return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
		} else {
			return Int(UIInterfaceOrientationMask.All.rawValue)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
}

func degToRad( degrees : Float ) -> Float
{
	return ( degrees / 180 * Float(M_PI) )
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
