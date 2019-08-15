//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Veil extends Widget {
  constructor () {
    // assertArgs(arguments, 0);
    super('veil')

    this.details = 'extra'
    this.requirement = ItemTypes.veil
    this.isPowered = function () {
      return verreciel.battery.isVeilPowered()
    }
    this.label.updateText(this.name)
  }

  hasVeil (veil) {
    // assertArgs(arguments, 1);
    if (this.port.hasEvent() == false) {
      return false
    }
    if (this.port.event == veil) {
      return true
    }
    return false
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
