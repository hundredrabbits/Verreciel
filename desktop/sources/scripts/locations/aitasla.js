//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class LocationAitasla extends Location {
  constructor (name, system, at, mapRequirement = null) {
    // assertArgs(arguments, 3);
    super(name, system, at, new IconStar(), new StructureStar())

    this.isComplete = false
    this.mapRequirement = mapRequirement
    this.icon.color = verreciel.black
  }

  // MARK: Panel -

  makePanel () {
    // assertArgs(arguments, 0);
    let newPanel = new Panel()

    return newPanel
  }

  sightUpdate () {
    // assertArgs(arguments, 0);

    this.color = verreciel.black
    this.structure.updateChildrenColors(this.color)
    this.icon.label.color = verreciel.clear
  }

  onDock () {
    // assertArgs(arguments, 0);
    verreciel.player.eject()
  }

  onUpdate () {
    // assertArgs(arguments, 0);

  }
}
