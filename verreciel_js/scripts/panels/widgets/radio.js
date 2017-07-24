//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Radio extends Widget {
  constructor() {
    // assertArgs(arguments, 0);
    super("radio");

    this.seek = 0;
    this.details = "format reader";
    this.requirement = ItemTypes.record;
    this.isPowered = function() {
      return verreciel.battery.isRadioPowered();
    };

    this.label.updateText(this.name);
  }

  // This is used when the missions system is assigning values to things
  setRecord(record) {
    this.port.addEvent(record);
    this.onUploadComplete();
  }

  update() {
    // assertArgs(arguments, 0);
    super.update();
    this.refresh();
  }

  onPowered() {
    // assertArgs(arguments, 0);
    super.onPowered();
    if (this.hasRecord()) {
      this.play();
    } else {
      this.stop();
    }
  }

  onUnpowered() {
    // assertArgs(arguments, 0);
    super.onUnpowered();
    this.stop();
  }

  play() {
    // assertArgs(arguments, 0);
    verreciel.music.setRecord(Records[this.port.event.code]);
    verreciel.music.playRecord();
  }

  hasRecord() {
    // assertArgs(arguments, 0);
    let event = this.port.event;
    return (
      event != null && event instanceof Item && event.type == ItemTypes.record
    );
  }

  stop() {
    // assertArgs(arguments, 0);
    verreciel.music.playAmbience();
  }

  whenRenderer() {
    super.whenRenderer();

    if (verreciel.music.isPlayingRecord()) {
      let scale = 1 + verreciel.music.magnitude * 10;
      this.port.sprite_output.element.scale.x = scale;
      this.port.sprite_output.element.scale.y = scale;
    } else {
      this.port.sprite_output.element.scale.x = 1;
      this.port.sprite_output.element.scale.y = 1;
    }
  }

  onUploadComplete() {
    // assertArgs(arguments, 0);
    super.onUploadComplete();

    if (verreciel.battery.isRadioPowered() == true) {
      if (this.hasRecord()) {
        this.play();
      } else {
        this.stop();
      }
    }
  }

  onInstallationBegin() {
    // assertArgs(arguments, 0);
    super.onInstallationBegin();
    verreciel.player.lookAt(0);
  }

  onInstallationComplete() {
    // assertArgs(arguments, 0);
    super.onInstallationComplete();
    verreciel.battery.installRadio();
  }
}
