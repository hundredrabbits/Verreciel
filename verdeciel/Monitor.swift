//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Monitor : Panel
{
	let nameLabel = SCNLabel(text: "", scale: 0.08, align: alignment.center)
	let detailsLabel = SCNLabel(text: "", scale: 0.04, align: alignment.center, color: grey)
	
	override init()
	{
		super.init()
		
		name = ""
		
		root.position = SCNVector3(0,0,templates.radius)
		
		nameLabel.position = SCNVector3(0,0,0)
		root.addChildNode(nameLabel)
		
		detailsLabel.position = SCNVector3(0,0.2,0)
		root.addChildNode(detailsLabel)
		
		nameLabel.hide()
		detailsLabel.hide()
		
		detailsLabel.update("")
		nameLabel.update("--")
	}
	
	// MARK: Installation -
	
	var installNode:Empty = Empty()
	var installProgressBar = SCNProgressBar(width: 1)
	
	override func onInstallationBegin()
	{
		installNode = Empty()
		installNode.position = SCNVector3(0,0,0)
		installProgressBar = SCNProgressBar(width: 0.5)
		installProgressBar.position = SCNVector3(-0.25,-0.2,0)
		installProgressBar.hide()
		installNode.addChildNode(installProgressBar)
		root.addChildNode(installNode)
	}
	
	override func installProgress()
	{
		super.installProgress()
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		nameLabel.show()
		detailsLabel.show()
		SCNTransaction.setCompletionBlock({ self.refresh() })
		SCNTransaction.commit()
		
		installNode.removeFromParentNode()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}