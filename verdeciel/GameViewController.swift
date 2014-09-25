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

func degToRad( degrees : Float ) -> Float
{
	return ( degrees / 180 * Float(M_PI) )
}


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		start()
    }
	
	func start()
	{
		scene = SCNScene(named: "art.scnassets/source.dae")
		
		// Camera
		var cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.name = "cameraNode"
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(cameraNode)
		
		let sphere = SCNSphere(radius: 0.2)
		let sphereNode = SCNNode(geometry: sphere)
		sphereNode.name = "sphere"
		sphereNode.position = SCNVector3(x: 0, y: 0, z: 10)
		scene.rootNode.addChildNode(sphereNode)
		
		
		let sphere2 = SCNSphere(radius: 0.2)
		let sphereNode2 = SCNNode(geometry: sphere2)
		sphereNode2.name = "sphere2"
		sphereNode2.position = SCNVector3(x: 0, y: 0, z: -10)
		scene.rootNode.addChildNode(sphereNode2)
		
		
		
		// SourceFile
		let meshLibrary = SCNScene(named: "art.scnassets/source.dae")
		
		// External
		
		let capsule = meshLibrary.rootNode.childNodeWithName("capsule1", recursively: true)!
		capsule.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
		capsule.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(capsule)
		
		let capsule2 = meshLibrary.rootNode.childNodeWithName("capsule2", recursively: true)!
		capsule2.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
		capsule2.position = SCNVector3(x: 0, y: 0, z: 10)
		scene.rootNode.addChildNode(capsule2)
		
		var capsule3 = meshLibrary.rootNode.childNodeWithName("capsule3", recursively: true)!
		capsule3.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
		capsule3.position = SCNVector3(x: 0, y: 0, z: -10)
		scene.rootNode.addChildNode(capsule3)
		
		// place the camera
		
		// create and add a light to the scene
		let lightNode = SCNNode()
		lightNode.light = SCNLight()
		lightNode.light!.type = SCNLightTypeOmni
		lightNode.position = SCNVector3(x: 0, y: 20, z: 0)
		scene.rootNode.addChildNode(lightNode)
		
		// create and add an ambient light to the scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light!.type = SCNLightTypeAmbient
		ambientLightNode.light!.color = UIColor.grayColor()
		scene.rootNode.addChildNode(ambientLightNode)
		
		// retrieve the SCNView
		let scnView = self.view as SCNView
		
		// set the scene to the view
		scnView.scene = scene
		
		// show statistics such as fps and timing information
		scnView.showsStatistics = false
		
		// configure the view
		scnView.backgroundColor = UIColor.yellowColor()
		
		// add a tap gesture recognizer
		let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
		let gestureRecognizers = NSMutableArray()
		gestureRecognizers.addObject(tapGesture)
		if let existingGestureRecognizers = scnView.gestureRecognizers {
			gestureRecognizers.addObjectsFromArray(existingGestureRecognizers)
		}
		scnView.gestureRecognizers = gestureRecognizers
		
	}
	
	
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
	{
		let touch = touches.anyObject() as UITouch
		var touchPosition = touch.locationInView(self.view)
		
		touchOrigin = touchPosition
		
	}
	
	override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
	{
		let touch = touches.anyObject() as UITouch
		var touchPosition = touch.locationInView(self.view)
		
		var dragX = Float(touchPosition.x - touchOrigin.x)
		var dragY = Float(touchPosition.y - touchOrigin.y)
		
		touchOrigin = touchPosition
		
		let xAngle = SCNMatrix4MakeRotation(degToRad(dragY/5), 1, 0, 0)
		let yAngle = SCNMatrix4MakeRotation(degToRad(dragX/5), 0, 1, 0)
		let zAngle = SCNMatrix4MakeRotation(degToRad(0), 0, 0, 1)
		
		var rotationMatrix = SCNMatrix4Mult(SCNMatrix4Mult(xAngle, yAngle), zAngle)
		
		var cameraNode = scene.rootNode.childNodeWithName("cameraNode", recursively: true)!
		
		cameraNode.transform = SCNMatrix4Mult(rotationMatrix, cameraNode.transform )
	}
	
	override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
	{
		NSLog("!")
	
	}
	
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(scnView)
        if let hitResults = scnView.hitTest(p, options: nil) {
            // check that we clicked on at least one object
            if hitResults.count > 0 {
                // retrieved the first clicked object
                let result: AnyObject! = hitResults[0]
				
				var meshName = ""
				
				if(( result.node.name ) != nil){
					NSLog("%@",result.node.name!)
					meshName = result.node.name!
				}
				else{
					NSLog("unnamed")
				}
				
				if( meshName == "sphere2" ){
					
					NSLog("%@",scnView.pointOfView!)
					
					// animate mesh multiple times
					
					// highlight it
					SCNTransaction.begin()
					SCNTransaction.setAnimationDuration(3)
					
					scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = SCNVector3(x: 0, y: 0, z: -10)
					
					SCNTransaction.commit()
					
				}
				else{
					SCNTransaction.begin()
					SCNTransaction.setAnimationDuration(3)
					
					scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = SCNVector3(x: 0, y: 0, z: 10)
					
					SCNTransaction.commit()
					
				}
				
				
                // get its material
                let material = result.node!.geometry!.firstMaterial!
				
                // highlight it
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(0.5)
                
                // on completion - unhighlight
                SCNTransaction.setCompletionBlock {
                    SCNTransaction.begin()
                    SCNTransaction.setAnimationDuration(0.5)
                    
                    material.emission.contents = UIColor.redColor()
                    
                    SCNTransaction.commit()
                }
                
                material.emission.contents = UIColor.blueColor()
                
                SCNTransaction.commit()
            }
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
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
