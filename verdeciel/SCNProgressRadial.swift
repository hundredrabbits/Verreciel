//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNProgressRadial : Empty
{
	var progress:Float = 0
	var linesCount:Float!
	
	init(size:CGFloat = 1.2,linesCount:Float = 52,color:UIColor = cyan)
	{
		super.init()
		
		self.linesCount = linesCount
		
		var i:Float = 0
		
		while i < linesCount {
			let line = SCNLine(vertices: [SCNVector3(0,size - 0.2,0), SCNVector3(0,size,0)], color: color)
			line.eulerAngles.z = degToRad(i * (360/linesCount))
			addChildNode(line)
			i += 1
		}
	}
	
	func update(percentage:Float)
	{
		let reach = (percentage/100) * linesCount
		
		var i:Float = 0
		for line in childNodes as! [SCNLine] {
			
			if reach == 0 { line.update(cyan) }
			else if i > reach { line.update(grey) }
			else{ line.update(cyan) }
			
			i += 1
		}
		print(reach)
		
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}