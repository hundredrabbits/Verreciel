//  Created by Devine Lu Linvega on 2014-09-21.
//  Copyright (c) 2014 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit

var sceneView:SCNView!
var scene = SCNScene()
var touchOrigin = CGPoint()
var touchPosition = CGPoint()

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

		sceneView.delegate = self
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

		startingState()
	}
	
	func startingState()
	{
		mission.install()
	}
	
	func debugState()
	{
		capsule.at = universe.loiqe_spawn.at
//		universe.loiqe_portal.isKnown = true
		
		radar.install()
		pilot.install()
		
		cargo.install()
		console.install()
		mission.install()
		thruster.install()
		
		quests.tutorial[0].complete()
		quests.tutorial[1].complete()
		quests.tutorial[2].complete()
		quests.tutorial[3].complete()
		quests.tutorial[4].complete()
		quests.tutorial[5].complete()
		quests.tutorial[6].complete()
		quests.tutorial[7].complete()
		quests.tutorial[8].complete()
		quests.tutorial[9].complete()
		quests.tutorial[10].complete()
		quests.tutorial[11].complete()
		quests.tutorial[12].complete()
		quests.tutorial[13].complete()
		quests.tutorial[14].complete()
		
		cargo.port.event.content.append(items.valenPortalFragment1)
		cargo.port.event.content.append(items.valenPortalFragment2)
		cargo.port.event.content.append(items.waste)
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

        player.accelY += Float(degToRad(dragX/6))
        player.accelX += Float(degToRad(dragY/6))
		
		ui.accelX += Float(degToRad(dragY/6)) * 0.975
        ui.accelY += Float(degToRad(dragX/6)) * 0.95
        
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
	
	func renderer(renderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval)
	{
		capsule._fixedUpdate()
		player._fixedUpdate()
		ui._fixedUpdate()
		
		space.fixedUpdate()
		quests.update()
		ui.updatePort()
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