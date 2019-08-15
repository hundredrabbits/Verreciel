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

    let radiation = this.isComplete == true ? 0 : (1 - this.distance / 0.7) / 0.6
    if (radiation > 1 && verreciel.capsule.isFleeing == false) {
      verreciel.capsule.flee()
    }
    verreciel.capsule.radiation = radiation
  }

  onDock () {
    // assertArgs(arguments, 0);
  }

  onUpdate () {
    // assertArgs(arguments, 0);

    this.color = verreciel.black
    this.mesh.updateChildrenColors(this.color)
  }
}
