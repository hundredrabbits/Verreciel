//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class LocationBank extends Location {
  constructor(name, system, at) {
    // assertArgs(arguments, 3);
    super(name, system, at, new IconBank(), new StructureBank());

    this.details = "storage";

    this.port1 = new ScenePortSlot(this);
    this.port2 = new ScenePortSlot(this);
    this.port3 = new ScenePortSlot(this);
    this.port4 = new ScenePortSlot(this);
    this.port5 = new ScenePortSlot(this);
    this.port6 = new ScenePortSlot(this);

    this.port1.enable();
    this.port2.enable();
    this.port3.enable();
    this.port4.enable();
    this.port5.enable();
    this.port6.enable();
  }

  makePanel() {
    // assertArgs(arguments, 0);
    let newPanel = new Panel();

    this.port1.position.set(
      Templates.leftMargin,
      Templates.lineSpacing * 2.5,
      0
    );
    newPanel.add(this.port1);

    this.port2.position.set(
      Templates.leftMargin,
      Templates.lineSpacing * 1.5,
      0
    );
    newPanel.add(this.port2);

    this.port3.position.set(
      Templates.leftMargin,
      Templates.lineSpacing * 0.5,
      0
    );
    newPanel.add(this.port3);

    this.port4.position.set(
      Templates.leftMargin,
      -Templates.lineSpacing * 0.5,
      0
    );
    newPanel.add(this.port4);

    this.port5.position.set(
      Templates.leftMargin,
      -Templates.lineSpacing * 1.5,
      0
    );
    newPanel.add(this.port5);

    this.port6.position.set(
      Templates.leftMargin,
      -Templates.lineSpacing * 2.5,
      0
    );
    newPanel.add(this.port6);

    return newPanel;
  }

  addItems(items) {
    // assertArgs(arguments, 1);
    for (let item of items) {
      if (this.port1.hasItem() == false) {
        this.port1.addEvent(item);
      } else if (this.port2.hasItem() == false) {
        this.port2.addEvent(item);
      } else if (this.port3.hasItem() == false) {
        this.port3.addEvent(item);
      } else if (this.port4.hasItem() == false) {
        this.port4.addEvent(item);
      } else if (this.port5.hasItem() == false) {
        this.port5.addEvent(item);
      } else if (this.port6.hasItem() == false) {
        this.port6.addEvent(item);
      }
    }
  }

  contains(item) {
    // assertArgs(arguments, 1);
    if (this.port1.event != null && this.port1.event == item) {
      return true;
    }
    if (this.port2.event != null && this.port2.event == item) {
      return true;
    }
    if (this.port3.event != null && this.port3.event == item) {
      return true;
    }
    if (this.port4.event != null && this.port4.event == item) {
      return true;
    }
    if (this.port5.event != null && this.port5.event == item) {
      return true;
    }
    if (this.port6.event != null && this.port6.event == item) {
      return true;
    }
    return false;
  }
}

class IconBank extends Icon {
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
          new THREE.Vector3(-this.size, 0, 0),
          new THREE.Vector3(this.size, 0, 0)
        ],
        this.color
      )
    );
  }
}

class StructureBank extends Structure {
  constructor() {
    // assertArgs(arguments, 0);
    super();

    var i = 0;
    while (i < 7) {
      let rect = new Rect(new THREE.Vector2(6, 6), verreciel.white);
      rect.position.y = i - 3.5;
      this.root.add(rect);
      i += 1;
    }
  }

  onDock() {
    super.onDock();

    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;

    this.hide();

    var i = 0;
    for (let mesh of this.root.children) {
      mesh.rotation.y = degToRad(i * 0.1);
      // mesh.rotation.y = degToRad((i - 3) * 10); // TODO: I think this would be more interesting
      i += 1;
    }

    verreciel.animator.commit();
  }

  onUndock() {
    super.onUndock();

    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;

    this.show();

    var i = 0;
    for (let mesh of this.root.children) {
      mesh.rotation.y = 0;
      i += 1;
    }

    verreciel.animator.commit();
  }
}
