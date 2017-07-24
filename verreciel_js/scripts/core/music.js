//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Music {
  constructor() {
    // assertArgs(arguments, 0);
    this.track = null;
    this.trackCatalog = {};
    this.ambience = null;
    this.record = null;
    this.context = new AudioContext();
    this.analyser = this.context.createAnalyser();
    this.analyser.connect(this.context.destination);
    this.data = new Uint8Array(this.analyser.frequencyBinCount);
    requestAnimationFrame(this.updateData.bind(this));
  }

  updateData() {
    requestAnimationFrame(this.updateData.bind(this));
    this.analyser.getByteFrequencyData(this.data);
    const length = this.data.length;
    let count = 0;
    const total = length * 0xff;
    for (let i = 0; i < length; i++) {
      count += this.data[i];
    }
    this.magnitude = count / total;
  }

  playEffect(name) {
    // assertArgs(arguments, 1);
    // console.info("Effect: ",name);
    let track = this.fetchTrack(
      name,
      "effect",
      "media/audio/effect/" + name + ".ogg",
      false,
      false
    );
    if (verreciel.game.time - track.lastTimePlayed > 5) {
      track.play();
    }
  }

  setAmbience(name) {
    if (this.ambience == name) {
      return;
    }
    this.ambience = name;
    if (
      this.track == null ||
      (this.track.role == "ambience" && this.track.name != name)
    ) {
      this.playAmbience();
    }
  }

  setRecord(name) {
    if (this.record == name) {
      return;
    }
    this.record = name;
    if (
      this.track == null ||
      (this.track.role == "record" && this.track.name != name)
    ) {
      this.playRecord();
    }
  }

  playRecord() {
    this.switchAudio("record", this.record);
  }

  playAmbience() {
    this.switchAudio("ambience", this.ambience);
  }

  isPlayingRecord() {
    return this.track != null && this.track.role == "record";
  }

  switchAudio(role, name) {
    if (this.track != null) {
      if (this.track.name == name) {
        return;
      }
      this.track.pause();
    }

    if (name != null) {
      this.track = this.fetchTrack(
        name,
        role,
        "media/audio/" + role + "/" + name + ".mp3",
        true,
        true
      );
      if (DEBUG_NO_MUSIC) {
        console.info(role, ":", name, "(off by debug)");
      } else {
        console.info(role, ":", name);
        this.track.play();
      }
    }
  }

  fetchTrack(name, role, src, loop, analyze) {
    // assertArgs(arguments, 3);
    let audioId = role + "_" + name;
    if (!(audioId in this.trackCatalog)) {
      this.trackCatalog[audioId] = new Track(name, role, src, loop, analyze);
    }
    return this.trackCatalog[audioId];
  }
}

class Track {
  constructor(name, role, src, loop, analyze) {
    this.audio = new Audio();
    this.name = name;
    this.role = role;
    this.audio.src = src;
    this.audio.loop = loop;
    this.lastTimePlayed = 0;
    if (analyze) {
      this.node = verreciel.music.context.createMediaElementSource(this.audio);
    }
  }

  get src() {
    return this.audio.src;
  }

  get loop() {
    return this.audio.loop;
  }

  play() {
    this.lastTimePlayed = verreciel.game.time;
    if (this.node != null) {
      this.node.connect(verreciel.music.analyser);
    }
    this.audio.currentTime = 0;
    this.audio.play();
  }

  pause() {
    if (this.node != null) {
      this.node.disconnect();
    }
    this.audio.pause();
  }
}
