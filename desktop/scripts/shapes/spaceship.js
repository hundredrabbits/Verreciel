//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Spaceship extends SceneLine {
  // Adapted from manual for Supergraphics Three-Dimensional Display System, P . Lutus, Kerby, Oregon 1980

  constructor (size, color = verreciel.white) {
    // assertArgs(arguments, 1);

    const nose = [0, 0, -8]
    const topBack = [1, 1, 9]
    const bottomBack = [1, -1, 9]
    const finBack = [6, -1, 8]
    const finFront = [6, -1, 6]
    const bottomFront = [1, -1, 6]

    const point = (arr, reflect) => {
      const p = new THREE.Vector3(...arr.map(x => size / 20 * x))
      if (reflect) p.x = -p.x
      return p
    }

    super(
      [
        point(topBack),
        point(bottomBack),
        point(bottomBack),
        point(finBack),
        point(finBack),
        point(finFront),
        point(finFront),
        point(bottomFront),
        point(bottomFront),
        point(nose),
        point(nose),
        point(topBack),

        point(topBack),
        point(topBack, true),

        point(topBack, true),
        point(bottomBack, true),
        point(bottomBack, true),
        point(finBack, true),
        point(finBack, true),
        point(finFront, true),
        point(finFront, true),
        point(bottomFront, true),
        point(bottomFront, true),
        point(nose, true),
        point(nose, true),
        point(topBack, true)
      ],
      color
    )

    this.add(new Axes(size))
  }
}

class RezSpaceship extends SceneLine {
  // Modified version of above

  constructor (size, color = verreciel.white) {
    // assertArgs(arguments, 1);

    const nose = [1, 0, -8]
    const topBack = [1, 1, 10]
    const bottomBack = [2, -1, 9]
    const finBack = [6, -2, 8]
    const finFront = [5.5, -2, 6]
    const topFront = [1, 1, 3]
    const bottomFront = [1, -1, 4]

    const point = (arr, reflect) => {
      const p = new THREE.Vector3(...arr.map(x => size / 20 * x))
      if (reflect) p.x = -p.x
      return p
    }

    super(
      [
        point(nose),
        point(nose, true),

        point(topBack),
        point(bottomBack),
        point(bottomBack),
        point(finBack),
        point(finBack),
        point(finFront),
        point(finFront),
        point(bottomFront),
        point(bottomFront),
        point(nose),
        point(nose),
        point(topFront),
        point(topFront),
        point(topBack),

        point(topBack),
        point(topBack, true),

        point(topBack, true),
        point(bottomBack, true),
        point(bottomBack, true),
        point(finBack, true),
        point(finBack, true),
        point(finFront, true),
        point(finFront, true),
        point(bottomFront, true),
        point(bottomFront, true),
        point(nose, true),
        point(nose, true),
        point(topFront, true),
        point(topFront, true),
        point(topBack, true)
      ],
      color
    )

    this.add(new Axes(size))
  }
}

class Axes extends SceneLine {
  constructor (size, color = verreciel.white) {
    // assertArgs(arguments, 1);
    super(
      [
        new THREE.Vector3(0, 0, -size * 0.5),
        new THREE.Vector3(0, 0, size * 0.5),
        new THREE.Vector3(0, -size * 0.5, 0),
        new THREE.Vector3(0, size * 0.5, 0),
        new THREE.Vector3(-size * 0.5, 0, 0),
        new THREE.Vector3(size * 0.5, 0, 0)
      ],
      color
    )
    this.opacity = 0.1
  }
}
