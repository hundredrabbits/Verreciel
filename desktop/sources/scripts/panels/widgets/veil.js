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

  setVeil (veil) {
    // assertArgs(arguments, 1);
    if (!this.hasVeil(veil)) {
      this.port.addEvent(veil)
    }
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
    verreciel.player.lookAt(180, -30)
  }

  onInstallationComplete () {
    // assertArgs(arguments, 0);
    super.onInstallationComplete()
    verreciel.battery.installVeil()
  }
}
