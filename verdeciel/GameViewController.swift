//  Created by Devine Lu Linvega on 2014-09-21.
//  Copyright (c) 2014 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit

var sceneView:SCNView!
var scene = SCNScene()
var touchOrigin = CGPoint()
var touchPosition = CGPoint()

var sceneDelegate:SceneDelegate!

class GameViewController: UIViewController, SCNSceneRendererDelegate
{
    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		create()
		initialize()
		start()
	}
	
	func create()
	{
		sceneView = self.view as! SCNView
		sceneView.scene = scene
		sceneView.showsStatistics = false
		sceneView.backgroundColor = UIColor.blackColor()
		sceneView.antialiasingMode = SCNAntialiasingMode.None
		sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
		sceneView.preferredFramesPerSecond = 25
		sceneView.playing = true
		
		sceneDelegate = SceneDelegate()
		sceneView.delegate = sceneDelegate
	}
	
	func initialize()
	{
		universe = CoreUniverse()
		
		capsule = CoreCapsule()
		scene.rootNode.addChildNode(capsule)
		
		player = CorePlayer()
		scene.rootNode.addChildNode(player)
		
		space = CoreSpace()
		scene.rootNode.addChildNode(space)
		
		ui = CoreUI()
		scene.rootNode.addChildNode(ui)
		
		time = CoreTime()
		quests = QuestLibrary()
	}
	
	func start()
	{
		universe._start()
		capsule._start()
		player._start()
		space._start()
		ui._start()
		
		time.start()
		
		settings.applicationIsReady = true

		debugState()
	}
	
	func startingState()
	{
	}
	
	func debugState()
	{
		capsule.at = universe.loiqe_landing.at
		radar.install()
		pilot.install()
		
		cargo.install()
		console.install()
		mission.install()
		thruster.install()
		
		cargo.port.event.content.append(items.valenPortalKey)
		universe.valen_portal.isUnlocked = true
		
		battery.cellPort1.connect(battery.thrusterPort)
		
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		for touch: AnyObject in touches {
			touchOrigin = touch.locationInView(self.view)
		}
		
		player.canAlign = false
		ui.canAlign = false
	}
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		for touch: AnyObject in touches {
			touchPosition = touch.locationInView(self.view)
		}
		
		let dragX = CGFloat(touchPosition.x - touchOrigin.x)
		let dragY = CGFloat(touchPosition.y - touchOrigin.y)
		
		touchOrigin = touchPosition

		player.eulerAngles.x += Float(degToRad(dragY/4))
		player.eulerAngles.y += Float(degToRad(dragX/4))
		
		ui.eulerAngles.x += Float(degToRad(dragY/4)) * 0.975
		ui.eulerAngles.y += Float(degToRad(dragX/4)) * 0.95
		
		ui.updatePort()
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		player.canAlign = true
		ui.canAlign = true
		ui.updatePort()
	}
	
	func handleTap(gestureRecognize: UIGestureRecognizer)
	{
		let p = gestureRecognize.locationInView(sceneView)
		
		let hitResults = sceneView.hitTest(p, options: nil)
		
		if hitResults.count > 0
		{
			let result: AnyObject! = hitResults[0]
			result.node.touch()
		}
	}
	
	override func prefersStatusBarHidden() -> Bool
	{
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