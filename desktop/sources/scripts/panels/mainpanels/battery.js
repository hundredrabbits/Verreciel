//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Battery extends MainPanel {
  constructor () {
    // assertArgs(arguments, 0);
    super('battery')

    this.details = 'powers systems'

    // Cells

    let distance = 0.3

    this.cellPort1 = new ScenePortSlot(
      this,
      'battery_slot_cell1',
      Alignment.right
    )
    this.cellPort1.position.set(-distance, Templates.lineSpacing, 0)
    this.cellPort1.enable()
    this.mainNode.add(this.cellPort1)

    this.cellPort2 = new ScenePortSlot(
      this,
      'battery_slot_cell2',
      Alignment.right
    )
    this.cellPort2.position.set(-distance, 0, 0)
    this.cellPort2.enable()
    this.mainNode.add(this.cellPort2)

    this.cellPort3 = new ScenePortSlot(
      this,
      'battery_slot_cell3',
      Alignment.right
    )
    this.cellPort3.position.set(-distance, -Templates.lineSpacing, 0)
    this.cellPort3.enable()
    this.mainNode.add(this.cellPort3)

    // Systems

    this.veilPort = new ScenePort(this, 'battery_slot_shield')
    this.veilPort.position.set(distance, 2 * Templates.lineSpacing, 0)
    this.veilLabel = new SceneLabel('shield', 0.1, Alignment.left)
    this.veilLabel.position.set(0.3, 0, 0)
    this.veilPort.add(this.veilLabel)
    this.mainNode.add(this.veilPort)

    this.thrusterPort = new ScenePort(this, 'battery_slot_thruster')
    this.thrusterPort.position.set(distance, Templates.lineSpacing, 0)
    this.thrusterLabel = new SceneLabel('thruster', 0.1, Alignment.left)
    this.thrusterLabel.position.set(0.3, 0, 0)
    this.thrusterPort.add(this.thrusterLabel)
    this.mainNode.add(this.thrusterPort)

    this.radioPort = new ScenePort(this, 'battery_slot_radio')
    this.radioPort.position.set(distance, 0, 0)
    this.radioLabel = new SceneLabel('radio', 0.1, Alignment.left)
    this.radioLabel.position.set(0.3, 0, 0)
    this.radioPort.add(this.radioLabel)
    this.mainNode.add(this.radioPort)

    this.navPort = new ScenePort(this, 'battery_slot_cloak')
    this.navPort.position.set(distance, -Templates.lineSpacing, 0)
    this.navLabel = new SceneLabel('cloak', 0.1, Alignment.left)
    this.navLabel.position.set(0.3, 0, 0)
    this.navPort.add(this.navLabel)
    this.mainNode.add(this.navPort)

    this.shieldPort = new ScenePort(this, 'battery_slot_oxygen')
    this.shieldPort.position.set(distance, 2 * -Templates.lineSpacing, 0)
    this.shieldLabel = new SceneLabel('oxygen', 0.1, Alignment.left)
    this.shieldLabel.position.set(0.3, 0, 0)
    this.shieldPort.add(this.shieldLabel)
    this.mainNode.add(this.shieldPort)

    this.veilLabel.updateText('--', verreciel.grey)
    this.thrusterLabel.updateText('--', verreciel.grey)
    this.radioLabel.updateText('--', verreciel.grey)
    this.navLabel.updateText('--', verreciel.grey)
    this.shieldLabel.updateText('--', verreciel.grey)

    this.cellPort2.disable()
    this.cellPort2.show('--', verreciel.grey)
    this.cellPort3.disable()
    this.cellPort3.show('--', verreciel.grey)

    this.footer.add(new SceneHandle(new THREE.Vector3(0, 0, -1), this))
    this.drawDecals()
  }

  whenStart () {
    // assertArgs(arguments, 0);
    this.installThruster()
  }

  contains (item) {
    // assertArgs(arguments, 1);
    if (this.cellPort1.event != null && this.cellPort1.event == item) {
      return true
    }
    if (this.cellPort2.event != null && this.cellPort2.event == item) {
      return true
    }
    if (this.cellPort3.event != null && this.cellPort3.event == item) {
      return true
    }
    return false
  }

  // MARK: Modules -

  installVeil () {
    // assertArgs(arguments, 0);
    this.veilPort.enable()
    this.veilLabel.updateText('veil', verreciel.white)
  }

  installThruster () {
    // assertArgs(arguments, 0);
    this.thrusterPort.enable()
    this.thrusterLabel.updateText('thruster', verreciel.white)
    verreciel.player.lookAt(0)
  }

  installRadio () {
    // assertArgs(arguments, 0);
    this.radioPort.enable()
    this.radioLabel.updateText('radio', verreciel.white)
  }

  installNav () {
    // assertArgs(arguments, 0);
    this.navPort.enable()
    this.navLabel.updateText('map', verreciel.white)
  }

  installShield () {
    // assertArgs(arguments, 0);
    this.shieldPort.enable()
    this.shieldLabel.updateText('shield', verreciel.white)
    if (verreciel.player != null) {
      verreciel.player.lookAt(0)
    }
  }

  isVeilPowered () {
    // assertArgs(arguments, 0);
    if (this.veilPort.isReceivingItemOfType(ItemTypes.battery)) {
      return true
    }
    return false
  }

  isThrusterPowered () {
    // assertArgs(arguments, 0);
    if (this.thrusterPort.isReceivingItemOfType(ItemTypes.battery)) {
      return true
    }
    return false
  }

  isRadioPowered () {
    // assertArgs(arguments, 0);
    if (this.radioPort.isReceivingItemOfType(ItemTypes.battery)) {
      return true
    }
    return false
  }

  isNavPowered () {
    // assertArgs(arguments, 0);
    if (this.navPort.isReceivingItemOfType(ItemTypes.battery)) {
      return true
    }
    return false
  }

  isShieldPowered () {
    // assertArgs(arguments, 0);
    if (this.shieldPort.isReceivingItemOfType(ItemTypes.battery)) {
      return true
    }
    return false
  }

  // MARK: Flags -

  onConnect () {
    // assertArgs(arguments, 0);
    this.refresh()
  }

  onDisconnect () {
    // assertArgs(arguments, 0);
    this.refresh()
  }

  refresh () {
    // assertArgs(arguments, 0);
    if (this.thrusterPort.isReceivingItemOfType(ItemTypes.battery) == true) {
      verreciel.thruster.onPowered()
    } else {
      verreciel.thruster.onUnpowered()
    }
    if (this.shieldPort.isReceivingItemOfType(ItemTypes.battery) == true) {
      verreciel.shield.onPowered()
    } else {
      verreciel.shield.onUnpowered()
    }
    if (this.veilPort.isReceivingItemOfType(ItemTypes.battery) == true) {
      verreciel.veil.onPowered()
    } else {
      verreciel.veil.onUnpowered()
    }
    if (this.navPort.isReceivingItemOfType(ItemTypes.battery) == true) {
      verreciel.nav.onPowered()
    } else {
      verreciel.nav.onUnpowered()
    }
    if (this.radioPort.isReceivingItemOfType(ItemTypes.battery) == true) {
      verreciel.radio.onPowered()
    } else {
      verreciel.radio.onUnpowered()
    }
  }

  hasCell (target) {
    // assertArgs(arguments, 1);
    if (this.cellPort1.event != null && this.cellPort1.event == target) {
      return true
    }
    if (this.cellPort2.event != null && this.cellPort2.event == target) {
      return true
    }
    if (this.cellPort3.event != null && this.cellPort3.event == target) {
      return true
    }
    return false
  }

  cellCount () {
    // assertArgs(arguments, 0);
    var count = 0

    if (this.cellPort1.hasItemOfType(ItemTypes.battery) == true) {
      count += 1
    }
    if (this.cellPort2.hasItemOfType(ItemTypes.battery) == true) {
      count += 1
    }
    if (this.cellPort3.hasItemOfType(ItemTypes.battery) == true) {
      count += 1
    }

    return count
  }

  onInstallationBegin () {
    // assertArgs(arguments, 0);
    super.onInstallationBegin()
    verreciel.player.lookAt(0)
  }

  onInstallationComplete () {
    // assertArgs(arguments, 0);
    super.onInstallationComplete()
    this.port.disable()
  }
}
