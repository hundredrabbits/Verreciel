//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Veil extends Widget {
  constructor () {
    // assertArgs(arguments, 0);
    super('veil')

    this.details = 'extra'
    this.requirement = ItemTypes.cypher
    this.isPowered = function () {
      return verreciel.battery.isVeilPowered()
    }
    this.label.updateText(this.name)
  }

  onInstallationBegin () {
    // assertArgs(arguments, 0);
    super.onInstallationBegin()
  }

  onInstallationComplete () {
    // assertArgs(arguments, 0);
    super.onInstallationComplete()
    verreciel.battery.installVeil()
  }
}
