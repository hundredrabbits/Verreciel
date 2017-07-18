//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Enigma extends Widget {
  constructor() {
    // assertArgs(arguments, 0);
    super();

    this.name = "enigma";
    this.details = "extra";
    this.requirement = ItemTypes.cypher;
    this.isPowered = function() {
      return verreciel.battery.isEnigmaPowered();
    };
    this.label.updateText(this.name);
  }

  onInstallationBegin() {
    // assertArgs(arguments, 0);
    super.onInstallationBegin();
  }

  onInstallationComplete() {
    // assertArgs(arguments, 0);
    super.onInstallationComplete();
    verreciel.battery.installEnigma();
  }
}
