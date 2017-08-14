//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Octogon extends SceneLine {
  constructor(size, color = verreciel.white) {
    // assertArgs(arguments, 1);
    let angle = 1.5;

    super(
      [
        new THREE.Vector3(0, 0, -size),
        new THREE.Vector3(size / angle, 0, -size / angle),
        new THREE.Vector3(size / angle, 0, -size / angle),
        new THREE.Vector3(size, 0, 0),
        new THREE.Vector3(size, 0, 0),
        new THREE.Vector3(size / angle, 0, size / angle),
        new THREE.Vector3(size / angle, 0, size / angle),
        new THREE.Vector3(0, 0, size),
        new THREE.Vector3(0, 0, size),
        new THREE.Vector3(-size / angle, 0, size / angle),
        new THREE.Vector3(-size / angle, 0, size / angle),
        new THREE.Vector3(-size, 0, 0),
        new THREE.Vector3(-size, 0, 0),
        new THREE.Vector3(-size / angle, 0, -size / angle),
        new THREE.Vector3(-size / angle, 0, -size / angle),
        new THREE.Vector3(0, 0, -size)
      ],
      color
    );
  }
}
