//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Cross extends SceneLine {
  constructor (size, color = verreciel.white, offset = { x: 0, y: 0, z: 0 }) {
    // assertArgs(arguments, 1);
    super(
      [
        new THREE.Vector3(-size + offset.x, 0 + offset.y, 0 + offset.z),
        new THREE.Vector3(size + offset.x, 0 + offset.y, 0 + offset.z),
        new THREE.Vector3(0 + offset.x, 0 + offset.y, -size + offset.z),
        new THREE.Vector3(0 + offset.x, 0 + offset.y, size + offset.z),
        new THREE.Vector3(0 + offset.x, -size + offset.y, 0 + offset.z),
        new THREE.Vector3(0 + offset.x, size + offset.y, 0 + offset.z)
      ],
      color
    )
  }
}
