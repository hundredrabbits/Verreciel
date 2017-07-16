//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class LocationHarvest extends Location {
  constructor(name, system, at, grows, mapRequirement = null) {
    // assertArgs(arguments, 4);
    super(name, system, at, new IconHarvest(), new StructureHarvest());

    this.mapRequirement = mapRequirement;

    this.grows = grows;

    this.details = this.grows.name;

    this.generationCountdown = 0;
    this.generationRate = 200;

    this.port = new ScenePortSlot(
      this,
      this.code + "_" + this.grows.name,
      Alignment.center,
      false
    );
    this.port.enable();

    this.generate();
  }

  whenStart() {
    // assertArgs(arguments, 0);
    super.whenStart();
    this.port.addEvent(this.grows);
  }

  generate() {
    // assertArgs(arguments, 0);
    delay(1, this.generate.bind(this));

    if (this.port == null) {
      return;
    }
    if (this.timeLeftLabel == null) {
      return;
    }

    this.progressRadial.updatePercent(
      this.generationCountdown / this.generationRate * 100
    );

    if (
      this.generationCountdown < this.generationRate &&
      this.port.hasEvent(this.grows) == false
    ) {
      this.generationCountdown += 1;
    } else {
      this.refresh();
      this.generationCountdown = 0;
      this.port.addEvent(this.grows);
      this.structure.update();
    }

    if (this.port.hasEvent(this.grows) == true) {
      this.timeLeftLabel.updateText("");
    } else {
      this.timeLeftLabel.updateText(
        (this.generationRate - this.generationCountdown).toFixed(0)
      );
    }
  }

  makePanel() {
    // assertArgs(arguments, 0);
    let newPanel = new Panel();

    this.timeLeftLabel = new SceneLabel("", 0.15, Alignment.center);
    this.timeLeftLabel.position.set(0, 0.5, 0);
    newPanel.add(this.timeLeftLabel);

    this.progressRadial = new SceneProgressRadial(1.2, 52, verreciel.cyan);
    newPanel.add(this.progressRadial);

    newPanel.add(this.port);

    return newPanel;
  }

  onUploadComplete() {
    // assertArgs(arguments, 0);
    super.onUploadComplete();

    this.refresh();
    this.structure.update();
  }

  refresh() {
    // assertArgs(arguments, 0);
    if (this.port.hasEvent(this.grows) != true) {
      this.icon.mesh.updateChildrenColors(verreciel.grey);
    } else {
      this.icon.mesh.updateChildrenColors(verreciel.white);
    }
  }
}

class IconHarvest extends Icon {
  constructor() {
    // assertArgs(arguments, 0);
    super();
    this.mesh.add(
      new SceneLine(
        [
          new THREE.Vector3(0, this.size, 0),
          new THREE.Vector3(this.size, 0, 0),
          new THREE.Vector3(-this.size, 0, 0),
          new THREE.Vector3(0, -this.size, 0),
          new THREE.Vector3(0, this.size, 0),
          new THREE.Vector3(-this.size, 0, 0),
          new THREE.Vector3(this.size, 0, 0),
          new THREE.Vector3(0, -this.size, 0),
          new THREE.Vector3(this.size, 0, 0),
          new THREE.Vector3(-this.size, 0, 0)
        ],
        this.color
      )
    );
  }
}

class StructureHarvest extends Structure {
  constructor() {
    // assertArgs(arguments, 0);
    super();

    this.root.position.set(0, 5, 0);

    let color = verreciel.cyan;
    let value1 = 7;
    let nodes = 45;
    var i = 0;
    while (i < nodes) {
      let node = new Empty();
      node.rotation.y = degToRad(i * (360 / nodes));
      node.add(
        new SceneLine(
          [
            new THREE.Vector3(0, 0, value1),
            new THREE.Vector3(0, 5, value1),
            new THREE.Vector3(0, 5, value1),
            new THREE.Vector3(0.5, 5.5, value1),
            new THREE.Vector3(0, 5, value1),
            new THREE.Vector3(-0.5, 5.5, value1)
          ],
          color
        )
      );
      this.root.add(node);
      i += 1;
    }
  }

  update() {
    // assertArgs(arguments, 0);
    super.update();

    if (this.host.port.hasEvent() != true) {
      this.root.updateChildrenColors(verreciel.grey);
    } else {
      this.root.updateChildrenColors(verreciel.cyan);
    }
  }

  sightUpdate() {
    // assertArgs(arguments, 0);
    super.sightUpdate();

    this.root.rotation.y += degToRad(0.1);
  }
}
