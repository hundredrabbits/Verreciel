//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class LocationBeacon extends Location {
  constructor(name, system, at, message, mapRequirement = null) {
    // assertArgs(arguments, 5);
    super(name, system, at, new IconBeacon(), new Structure());

    this.mapRequirement = mapRequirement;
    this.message = message;
  }

  makePanel() {
    // assertArgs(arguments, 0);
    let newPanel = new Panel();

    let text1 = this.message.substr(0, 19);
    let text2 = this.message.substr(19, 19);
    let text3 = this.message.substr(38, 19);
    let text4 = this.message.substr(57, 19);

    let line1 = new SceneLabel(text1);
    line1.position.set(-1.5 + 0.3, 0.6, 0);
    newPanel.add(line1);

    let line2 = new SceneLabel(text2);
    line2.position.set(-1.5 + 0.3, 0.2, 0);
    newPanel.add(line2);

    let line3 = new SceneLabel(text3);
    line3.position.set(-1.5 + 0.3, -0.2, 0);
    newPanel.add(line3);

    let line4 = new SceneLabel(text4);
    line4.position.set(-1.5 + 0.3, -0.6, 0);
    newPanel.add(line4);

    return newPanel;
  }
}

class IconBeacon extends Icon {
  constructor() {
    // assertArgs(arguments, 0);
    super();

    this.mesh.add(
      new SceneLine(
        [
          new THREE.Vector3(this.size, 0, 0),
          new THREE.Vector3(this.size, 0, 0),
          new THREE.Vector3(0, -this.size, 0),
          new THREE.Vector3(0, this.size, 0)
        ],
        this.color
      )
    );
  }
}
