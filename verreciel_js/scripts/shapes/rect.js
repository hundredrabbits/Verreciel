//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Rect extends SceneLine
{
  constructor(size, color = verreciel.white)
  {
    // assertArgs(arguments, 1);
    super([
      new THREE.Vector3(-size.width/2,0,size.height/2), 
      new THREE.Vector3(size.width/2,0,size.height/2), 
      new THREE.Vector3(size.width/2,0,size.height/2), 
      new THREE.Vector3(size.width/2,0,-size.height/2), 
      new THREE.Vector3(size.width/2,0,-size.height/2), 
      new THREE.Vector3(-size.width/2,0,-size.height/2), 
      new THREE.Vector3(-size.width/2,0,-size.height/2), 
      new THREE.Vector3(-size.width/2,0,size.height/2),
    ], color);
  }
}
