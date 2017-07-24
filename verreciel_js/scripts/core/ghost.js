//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Ghost extends Empty {
  constructor() {
    super();

    this.root = new Empty();
    this.add(this.root);
    this.makeFuzz();
    this.makeHead();
    this.returnDelay = null;
    this.flickerDelay = null;
    this.idling = true;
    this.danceAmplitude = 0;
    this.ready = false;
    this.replayIndex = 0;
    this.isTapping = false;

    this.lastPlayerRotation = null;

    this.goalPosition = new THREE.Vector3();
    this.headAngle = degToRad(-45);
    this.focus = new THREE.Vector3(1, 0, 1);

    this.hide();
    this.triggersByName = {};
    this.portsByName = {};
    this.salientEntries = [];
    this.entriesDuringTap = [];
    this.lastNonHit = null;

    this.openEyes.opacity = 1;
    this.closedEyes.opacity = 0;

    if (DEBUG_LOG_GHOST == true) {
      document.onkeyup = function(event) {
        if (event.keyCode == 88) {
          this.report(LogType.mistake);
        }
      }.bind(this);
    }
  }

  appear() {
    this.flicker();
    delay(0.7, this.stopFlickering.bind(this));
    delay(2, this.onAppear.bind(this));
  }

  onAppear() {
    this.hide();
    this.idle();
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.1;
    verreciel.animator.ease = Penner.easeInOutCubic;
    this.show();
    verreciel.capsule.show();
    verreciel.animator.commit();
  }

  disappear() {
    this.flicker();
    delay(0.7, this.stopFlickering.bind(this));
    delay(2, this.onDisappear.bind(this));
  }

  onDisappear() {
    this.hide();
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.1;
    verreciel.animator.ease = Penner.easeInOutCubic;
    verreciel.capsule.show();
    verreciel.animator.commit();
  }

  flicker() {
    this.flickerDelay = delay(0.05, this.flicker.bind(this));
    verreciel.capsule.opacity = Math.random();
    if (this.opacity != 0) {
      this.opacity = verreciel.capsule.opacity;
    }
  }

  stopFlickering() {
    cancelDelay(this.flickerDelay);
    verreciel.capsule.hide();
    this.hide();
  }

  wanderToTarget(target, callback = null) {
    this.goalPosition.copy(
      target.convertPositionToNode(new THREE.Vector3(), verreciel.root)
    );
    this.focus.copy(this.goalPosition);
    this.goalPosition.multiply(new THREE.Vector3(0.7, 1, 0.7));

    this.wanderToGoal(
      function() {
        this.returnDelay = delay(4, this.returnToCenter.bind(this));
        if (callback != null) {
          callback();
        }
      }.bind(this)
    );
  }

  wanderToGoal(callback) {
    if (this.idling == true) {
      this.idling = false;
      this.openEyes.opacity = 1;
      this.closedEyes.opacity = 0;
    }
    cancelDelay(this.returnDelay);
    verreciel.animator.completeAnimation("ghost");

    let distance = this.goalPosition.distanceTo(this.element.position);
    let duration = 0.7 + 0.2 * distance;
    verreciel.animator.begin("ghost");
    verreciel.animator.animationDuration = duration;
    verreciel.animator.ease = Penner.easeInOutCubic;
    this.position.set(
      this.goalPosition.x,
      this.goalPosition.y,
      this.goalPosition.z
    );
    this.root.position.set(0, 0, 0);
    verreciel.animator.completionBlock = callback;
    verreciel.animator.commit();
  }

  returnToCenter() {
    if (verreciel.music.isPlayingRecord()) {
      this.goalPosition.set(0, 0, 0);
    } else {
      this.goalPosition
        .set(this.position.x, this.position.y, this.position.z)
        .multiplyScalar(0.9);
    }
    this.focus.set(0, 0, 0);
    this.wanderToGoal(this.idle.bind(this));
  }

  idle() {
    this.idling = true;
    this.danceAmplitude = 0;
  }

  whenStart() {
    super.whenStart();
    delay(Math.random() * 4 + 6, this.blink.bind(this));
    delay(0.2, this.waver.bind(this));
    if (DEBUG_LOG_GHOST) {
      this.ready = true;
    } else {
      loadAsset(
        "media/walkthrough.json",
        function(data) {
          for (let record of JSON.parse(data)) {
            let entry = new LogEntry(record.type, record.data, record.skip);
            entry.index = record.index;
            this.salientEntries.push(entry);
          }
          this.ready = true;
          this.pollForSummon();
        }.bind(this),
        "application/json"
      );
    }
  }

  pollForSummon() {
    if (verreciel.game.state > 0) {
      return;
    }
    let playerRotation = new THREE.Vector3(
      verreciel.player.rotation.x,
      verreciel.player.rotation.y,
      verreciel.player.rotation.z
    );
    if (
      this.lastPlayerRotation != null &&
      playerRotation.equals(this.lastPlayerRotation) &&
      playerRotation.x > Math.PI / 4
    ) {
      verreciel.player.setIsPanoptic(true);
      delay(0.5, this.appear.bind(this));
      delay(5, this.replay.bind(this));
    } else {
      this.lastPlayerRotation = playerRotation;
      delay(5, this.pollForSummon.bind(this));
    }
  }

  replay() {
    this.isReplaying = true;
    while (this.salientEntries[this.replayIndex].skip == true) {
      console.log(
        "SKIP",
        this.replayIndex,
        this.salientEntries[this.replayIndex].toString()
      );
      this.replayIndex++;
    }
    this.currentEntry = this.salientEntries[this.replayIndex];
    if (this.currentEntry.type == LogType.hit) {
      console.log("HIT", this.replayIndex, this.currentEntry.toString());
      let target = this.resolveHitTarget(this.currentEntry.data);
      this.wanderToTarget(target, this.tap.bind(this));
    } else {
      console.log("WAIT", this.replayIndex, this.currentEntry.toString());
    }

    if (this.entriesDuringTap.length > 0) {
      for (let entry of this.entriesDuringTap) {
        this.report(entry.type, entry.data);
      }
      this.entriesDuringTap.splice(0, this.entriesDuringTap.length);
    }
  }

  tap() {
    let target = this.resolveHitTarget(this.currentEntry.data);
    let tapInPosition = this.element.position.clone().multiplyScalar(1.05);
    let tapOutPosition = this.element.position.clone();
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.1;
    verreciel.animator.ease = Penner.easeInCubic;
    this.position.set(tapInPosition.x, tapInPosition.y, tapInPosition.z);
    verreciel.animator.completionBlock = function() {
      this.replayIndex++;
      this.isTapping = true;
      target.tap();
      this.position.set(tapOutPosition.x, tapOutPosition.y, tapOutPosition.z);
      verreciel.animator.begin();
      verreciel.animator.ease = Penner.easeOutCubic;
      verreciel.animator.animationDuration = 0.1;
      verreciel.animator.completionBlock = function() {
        this.isTapping = false;
        this.replay();
      }.bind(this);
      verreciel.animator.commit();
    }.bind(this);
    verreciel.animator.commit();
  }

  waver() {
    delay(0.2, this.waver.bind(this));
    for (let i = 0; i < this.fuzzVertices.length; i++) {
      this.fuzzVertices[i].copy(this.fuzzBaseVertices[i]);
      this.fuzzVertices[i].x += (Math.random() - 0.5) * 0.015;
      this.fuzzVertices[i].z += (Math.random() - 0.5) * 0.015;
    }
    this.fuzz.updateVertices(this.fuzzVertices);
  }

  blink() {
    this.openEyes.opacity = 0;
    this.closedEyes.opacity = 1;
    delay(
      0.15,
      function() {
        if (this.danceAmplitude > 0) {
          return;
        }
        this.openEyes.opacity = 1;
        this.closedEyes.opacity = 0;

        let nextTime = Math.random() > 0.8 ? 0.2 : Math.random() * 4 + 6;
        delay(nextTime, this.blink.bind(this));
      }.bind(this)
    );
  }

  makeFuzz() {
    this.fuzzBaseVertices = [];
    this.fuzzVertices = [];
    let size1 = 0.84;
    let size2 = 0.76;
    let numLines = 80;
    for (let i = 0; i < numLines; i++) {
      let angle = degToRad(i * 360 / numLines);
      this.fuzzBaseVertices.push(
        new THREE.Vector3(Math.cos(angle) * size2, 0, Math.sin(angle) * size2)
      );
      this.fuzzBaseVertices.push(
        new THREE.Vector3(Math.cos(angle) * size1, 0, Math.sin(angle) * size1)
      );
      this.fuzzVertices.push(new THREE.Vector3());
      this.fuzzVertices.push(new THREE.Vector3());
    }
    this.fuzz = new SceneLine(this.fuzzVertices, verreciel.white);
    this.root.add(this.fuzz);
  }

  makeHead() {
    let center = new THREE.Vector3(0, 0, -0.14);
    let faceVertices = [];
    let openEyesVertices = [];
    let closedEyesVertices = [];

    faceVertices = faceVertices.concat(
      this.makeCircle(9, 0.008, new THREE.Vector3(0.21, 0, 0.3).add(center))
    );
    faceVertices = faceVertices.concat(
      this.makeCircle(9, 0.008, new THREE.Vector3(-0.21, 0, 0.3).add(center))
    );
    openEyesVertices = openEyesVertices.concat(
      this.makeCircle(9, 0.03, new THREE.Vector3(0.21, 0, 0.2).add(center))
    );
    openEyesVertices = openEyesVertices.concat(
      this.makeCircle(9, 0.03, new THREE.Vector3(-0.21, 0, 0.2).add(center))
    );
    closedEyesVertices.push(
      new THREE.Vector3(-0.21 - 0.04, 0, 0.208).add(center),
      new THREE.Vector3(-0.21 + 0.04, 0, 0.2).add(center)
    );
    closedEyesVertices.push(
      new THREE.Vector3(0.21 - 0.04, 0, 0.2).add(center),
      new THREE.Vector3(0.21 + 0.04, 0, 0.208).add(center)
    );

    let mouth1 = new THREE.Vector3(-1.0, 0.0, 0.0 * -0.6)
      .multiplyScalar(0.03)
      .add(center);
    let mouth2 = new THREE.Vector3(-0.7, 0.0, -0.7 * -0.6)
      .multiplyScalar(0.03)
      .add(center);
    let mouth3 = new THREE.Vector3(0.0, 0.0, -1.0 * -0.6)
      .multiplyScalar(0.03)
      .add(center);
    let mouth4 = new THREE.Vector3(0.7, 0.0, -0.7 * -0.6)
      .multiplyScalar(0.03)
      .add(center);
    let mouth5 = new THREE.Vector3(1.0, 0.0, 0.0 * -0.6)
      .multiplyScalar(0.03)
      .add(center);

    let mouth = [
      mouth1,
      mouth2,
      mouth2,
      mouth3,
      mouth3,
      mouth4,
      mouth4,
      mouth5
    ];
    faceVertices = faceVertices.concat(mouth);

    this.head = new Empty();
    this.root.add(this.head);
    this.face = new SceneLine(faceVertices, verreciel.white);
    this.face.position.x = 0.42;
    this.head.add(this.face);
    this.openEyes = new SceneLine(openEyesVertices, verreciel.white);
    this.face.add(this.openEyes);
    this.closedEyes = new SceneLine(closedEyesVertices, verreciel.white);
    this.face.add(this.closedEyes);
  }

  makeCircle(numLines, radius, offset) {
    let vertices = [];
    let rads = degToRad(360 / numLines);

    let angle = 0;
    let axis = new THREE.Vector3(0, 1, 0);
    let stylus = new THREE.Vector3(radius, 0, 0);
    for (let i = 0; i < numLines; i++) {
      vertices.push(stylus.clone().add(offset));
      stylus.applyAxisAngle(axis, rads);
      vertices.push(stylus.clone().add(offset));
    }
    return vertices;
  }

  whenRenderer() {
    // assertArgs(arguments, 0);
    super.whenRenderer();

    let scale =
      this.fuzz.element.scale.z * 0.5 +
      (1 + verreciel.music.magnitude * 4) * 0.5;
    this.fuzz.element.scale.x = scale;
    this.fuzz.element.scale.z = scale;

    if (this.idling == true) {
      if (verreciel.music.isPlayingRecord()) {
        this.openEyes.opacity = 0;
        this.closedEyes.opacity = 1;
        this.danceAmplitude = Math.min(1, this.danceAmplitude + 0.005);
        this.root.position.setNow(
          scale *
            scale *
            this.danceAmplitude *
            0.2 *
            Math.cos(verreciel.game.time / verreciel.game.gameSpeed / 4),
          0,
          scale *
            scale *
            this.danceAmplitude *
            0.2 *
            Math.sin(verreciel.game.time / verreciel.game.gameSpeed / 2)
        );
      } else {
        if (this.danceAmplitude > 0) {
          this.danceAmplitude = 0;
          this.openEyes.opacity = 1;
          this.closedEyes.opacity = 0;
          delay(Math.random() * 4 + 6, this.blink.bind(this));
        }
        this.root.position.setNow(
          this.root.position.x * 0.8,
          0,
          this.root.position.z * 0.8
        );
      }
    } else {

    }

    let headGoalAngle = -Math.atan2(this.focus.z - this.position.z, this.focus.x - this.position.x);
    let diffHeadRotY = sanitizeDiffAngle(headGoalAngle, this.headAngle);
    if (Math.abs(diffHeadRotY) > 0.001) {
      this.headAngle += diffHeadRotY * 0.05;
    }
    this.head.rotation.y = this.headAngle;

    let faceAngle = this.face.rotation.y + this.headAngle;
    let diffFaceRotY = sanitizeDiffAngle(verreciel.player.rotation.y, faceAngle);
    if (Math.abs(diffFaceRotY) > 0.001) {
      faceAngle += diffFaceRotY * 0.3;
    }
    this.face.rotation.setNow(this.face.rotation.x, faceAngle - this.headAngle, this.face.rotation.z);
  }

  report(type, data = null) {
    const entry = new LogEntry(type, data);
    if (this.isTapping) {
      this.entriesDuringTap.push(entry);
    } else if (this.isReplaying && entry.type != LogType.hit) {
      if (entry.toString() == this.currentEntry.toString()) {
        console.log("MATCH", this.replayIndex, entry.toString());
        this.replayIndex++;
        delay(0.5, this.replay.bind(this));
      }
    } else if (DEBUG_LOG_GHOST == true) {
      if (type == LogType.hit) {
        if (this.lastNonHit != null) {
          this.addEntry(this.lastNonHit);
          this.lastNonHit = null;
        }
        this.addEntry(entry);
      } else if (type == LogType.mistake) {
        this.addEntry(entry);
      } else {
        this.lastNonHit = entry;
      }
    }
  }

  addEntry(entry) {
    entry.index = this.salientEntries.length;
    this.salientEntries.push(entry);
    console.log(">\t" + entry.toString());
  }

  rewindToEntry(index) {
    if (index < this.salientEntries.length) {
      this.salientEntries.splice(index + 1);
    }
  }

  recordHitTarget(trigger) {
    let record = null;
    if (trigger.host instanceof ScenePort) {
      if (
        trigger.host.numberlessName != null &&
        verreciel.ghost.portsByName[trigger.host.numberlessName].length > 1
      ) {
        record = {
          from: "port",
          numberlessName: trigger.host.numberlessName,
          event: trigger.host.event == null ? null : trigger.host.event.code
        };
      } else {
        record = {
          from: "port",
          name: trigger.host.name
        };
      }
    } else {
      record = {
        from: "trigger",
        name: trigger.name
      };
    }
    return record;
  }

  resolveHitTarget(record) {
    let target = null;
    if (record.from == "trigger") {
      target = this.triggersByName[record.name];
    } else if (record.from == "port") {
      if (record.name != null) {
        target = this.portsByName[record.name].trigger;
      } else {
        for (let port of this.portsByName[record.numberlessName]) {
          let eventCode = port.event == null ? null : port.event.code;
          if (eventCode == record.event) {
            target = port.trigger;
            break;
          }
        }
      }
    }
    return target;
  }
}

class LogType {}
setEnumValues(LogType, [
  "combination",
  "docked",
  "harvest",
  "hit",
  "install",
  "mission",
  "mistake",
  "pilotAligned",
  "playerUnlock",
  "thrusterUnlock",
  "upload"
]);

class LogEntry {
  constructor(type, data, skip = false) {
    this.type = type;
    this.data = data;
    this.skip = skip;
  }

  toString() {
    let string = this.type + "\t";
    if (this.data != null) {
      if (typeof this.data == "object") {
        for (let prop in this.data) {
          string += "(" + prop + ":" + this.data[prop] + ") ";
        }
      } else {
        string += this.data.toString();
      }
    }
    return string;
  }
}
