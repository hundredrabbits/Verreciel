//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Event extends Empty {
  constructor (
    name = '',
    at = new THREE.Vector2(),
    details = '',
    color = verreciel.grey,
    isQuest = false
  ) {
    // assertArgs(arguments, 5);
    super()

    this.isQuest = isQuest

    this.name = name
    this.details = details

    this.at = at
    this.color = color
  }

  // MARK: Radar -

  update () {
    // assertArgs(arguments, 0);
    super.update()
  }

  remove () {
    // assertArgs(arguments, 0);
    this.removeFromParentNode()
  }

  clean () {
    // assertArgs(arguments, 0);
  }
}
