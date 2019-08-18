//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class ScenePort extends Empty {
  constructor (host, name) {
    assertArgs(arguments, 2)
    super()

    this.host = host
    this.name = name
    this.isEnabled = true
    this.isPersistent = false
    verreciel.ghost.portsByName[name] = this
    let numberlessName = name.replace(/\d/g, '#')
    if (name != numberlessName) {
      this.numberlessName = numberlessName
      if (verreciel.ghost.portsByName[numberlessName] == null) {
        verreciel.ghost.portsByName[numberlessName] = []
      }
      verreciel.ghost.portsByName[numberlessName].push(this)
    }

    this.trigger = new SceneTrigger(this, 'port_' + name, 2, 2, 0)
    this.trigger.position.set(0, 0, -0.1)
    this.add(this.trigger)

    let radius = 0.125
    this.sprite_input = new SceneLine(
      [
        new THREE.Vector3(0, radius / 2, 0),
        new THREE.Vector3(radius / 2, 0, 0),
        new THREE.Vector3(radius / 2, 0, 0),
        new THREE.Vector3(0, -radius / 2, 0),
        new THREE.Vector3(0, -radius / 2, 0),
        new THREE.Vector3(-radius / 2, 0, 0),
        new THREE.Vector3(-radius / 2, 0, 0),
        new THREE.Vector3(0, radius / 2, 0)
      ],
      verreciel.grey
    )
    this.add(this.sprite_input)

    this.sprite_output = new SceneLine(
      [
        new THREE.Vector3(0, radius, 0),
        new THREE.Vector3(radius, 0, 0),
        new THREE.Vector3(radius, 0, 0),
        new THREE.Vector3(0, -radius, 0),
        new THREE.Vector3(0, -radius, 0),
        new THREE.Vector3(-radius, 0, 0),
        new THREE.Vector3(-radius, 0, 0),
        new THREE.Vector3(0, radius, 0)
      ],
      verreciel.grey
    )
    this.add(this.sprite_output)

    this.wire = new SceneWire(
      this,
      new THREE.Vector3(0, 0, 0),
      new THREE.Vector3(0, 0, 0)
    )
    this.add(this.wire)

    this.disable()
  }

  // MARK: Touch -

  touch (id = 0) {
    // assertArgs(arguments, 1);
    if (this.isEnabled == false) {
      return false
    }

    if (verreciel.player.activePort == null) {
      verreciel.player.holdPort(this)
    } else if (verreciel.player.activePort == this) {
      verreciel.player.releasePort()
    } else if (verreciel.player.activePort != this) {
      verreciel.player.connectPorts(verreciel.player.activePort, this)
    }

    return true
  }

  whenRenderer () {
    // assertArgs(arguments, 0);
    super.whenRenderer()

    this.sprite_input.color = this.inputColor()
    this.sprite_output.color = this.outputColor()

    // Blink
    if (
      verreciel.player.activePort != null &&
      verreciel.player.activePort == this
    ) {
      this.sprite_output.updateChildrenColors(verreciel.cyan)
      this.sprite_output.blink()
    } else {
      this.sprite_output.show()
    }
  }

  inputColor () {
    if (this.isEnabled == false) {
      return verreciel.clear
    } else if (this.origin == null) {
      return verreciel.grey
    }

    return verreciel.red
  }

  outputColor () {
    if (this.event == null || this.isEnabled == false) {
      return verreciel.grey
    }

    return verreciel.cyan
  }

  enable () {
    // assertArgs(arguments, 0);
    this.isEnabled = true
    this.trigger.enable()
  }

  disable () {
    // assertArgs(arguments, 0);
    this.isEnabled = false
    this.disconnect()
    this.trigger.disable()
  }

  addEvent (event) {
    // assertArgs(arguments, 1);
    this.event = event
    this.update()
  }

  addRequirement (event) {
    // assertArgs(arguments, 1);
    this.requirement = event
  }

  removeEvent () {
    // assertArgs(arguments, 0);
    this.event = null
  }

  connect (port) {
    // assertArgs(arguments, 1);
    if (port.isEnabled == false) {
      return
    }
    if (port.origin != null) {
      port.origin.disconnect()
    }
    if (port.connection != null && port.connection == this) {
      port.disconnect()
    }

    this.disconnect()
    this.connection = port
    this.connection.origin = this

    this.wire.enable()
    this.updateWire(true)

    this.connection.host.onConnect()
    this.connection.onConnect()

    this.onConnect()
  }

  updateWire (reset = false) {
    this.wire.updateEnds(
      new THREE.Vector3(0, 0, 0),
      this.convertPositionFromNode(new THREE.Vector3(0, 0, 0), this.connection),
      reset
    )
  }

  disconnect () {
    // assertArgs(arguments, 0);
    if (this.connection == null) {
      return
    }

    let targetOrigin = this.connection.host

    this.connection.origin = null
    this.connection.update()
    this.connection.onDisconnect()
    this.connection = null

    if (targetOrigin != null) {
      targetOrigin.onDisconnect()
      targetOrigin.update()
    }

    this.onDisconnect()
    this.host.onDisconnect()

    this.wire.disable()
  }

  strip () {
    // assertArgs(arguments, 0);
    this.disconnect()
    if (this.origin != null) {
      this.origin.disconnect()
    }
  }

  syphon () {
    // assertArgs(arguments, 0);
    let stored_origin = this.origin
    let stored_event = this.origin.event

    if (stored_origin != null) {
      stored_origin.removeEvent()
      stored_origin.host.update()
      stored_origin.update()
      stored_origin.disconnect()
    }

    return stored_event
  }

  // MARK: Validation

  // MARK: Checks -

  hasEvent (target) {
    // assertArgs(arguments, 1);
    if (this.event === null) {
      return false
    }
    if (this.event.code === target.code) {
      return true
    }
    return false
  }

  hasEvent () {
    // assertArgs(arguments, 0);
    if (this.event != null) {
      return true
    }
    return false
  }

  hasItem () {
    // assertArgs(arguments, 0);
    if (this.event == null) {
      return false
    }
    if (this.event instanceof Item == true) {
      return true
    }
    return false
  }

  hasItemOfType (target) {
    // assertArgs(arguments, 1);
    if (this.event == null) {
      return false
    }
    if (this.event instanceof Item == false) {
      return false
    }
    if (this.event.type == target) {
      return true
    }
    return false
  }

  hasItemLike (target) {
    // assertArgs(arguments, 1);
    if (this.event == null) {
      return false
    }
    if (this.event instanceof Item == false) {
      return false
    }
    if (this.event.name == target.name) {
      return true
    }
    return false
  }

  isReceiving () {
    // assertArgs(arguments, 0);
    if (this.origin != null && this.origin.event != null) {
      return true
    }
    return false
  }

  isReceivingFromPanel (panel) {
    // assertArgs(arguments, 1);
    if (this.origin == null) {
      return false
    }
    if (this.origin.host instanceof Panel == false) {
      return false
    }
    if (this.origin.host == panel) {
      return true
    }
    return false
  }

  isReceivingEvent (event) {
    // assertArgs(arguments, 1);
    if (
      this.origin != null &&
      this.origin.event != null &&
      this.origin.event == event
    ) {
      return true
    }
    return false
  }

  isReceivingItemLike (target) {
    // assertArgs(arguments, 1);
    if (this.origin == null) {
      return false
    }
    if (this.origin.event == null) {
      return false
    }
    if (this.origin.event instanceof Item == false) {
      return false
    }
    if (this.origin.event.name == target.name) {
      return true
    }
    return false
  }

  isReceivingItemOfType (type) {
    // assertArgs(arguments, 1);
    if (this.origin == null) {
      return false
    }
    if (this.origin.event == null) {
      return false
    }
    if (this.origin.event instanceof Item == false) {
      return false
    }

    let source = this.origin.event

    if (source.type == type) {
      return true
    }

    return false
  }

  isReceivingLocation () {
    // assertArgs(arguments, 0);
    if (this.origin == null) {
      return false
    }
    if (this.origin.event == null) {
      return false
    }

    if (this.origin.event instanceof Location) {
      return true
    }

    return false
  }

  isReceivingLocationOfTypePortal () {
    // assertArgs(arguments, 0);
    if (this.isReceivingLocation() == false) {
      return false
    }
    if (this.origin.event instanceof LocationPortal) {
      return true
    }
    if (this.origin.event instanceof LocationAitasla) {
      return true
    }
    return false
  }

  isReceivingEventOfTypeLocation () {
    // assertArgs(arguments, 0);
    if (this.origin == null) {
      return false
    }
    if (this.origin.event == null) {
      return false
    }
    if (this.origin.event instanceof Location == false) {
      return false
    }
    return true
  }

  isReceivingEventOfTypeItem () {
    // assertArgs(arguments, 0);
    if (this.origin == null) {
      return false
    }
    if (this.origin.event == null) {
      return false
    }
    if (this.origin.event instanceof Item == false) {
      return false
    }
    return true
  }

  isConnectedToPanel (panel) {
    // assertArgs(arguments, 1);
    if (this.connection == null) {
      return false
    }
    if (
      this.connection.host instanceof Panel &&
      this.connection.host == panel
    ) {
      return true
    }
    return false
  }

  // MARK: Etc..

  onConnect () {
    // assertArgs(arguments, 0);
    super.onConnect()
  }

  onDisconnect () {
    // assertArgs(arguments, 0);
    super.onDisconnect()
    this.host.onDisconnect()
  }

  static stripAllPorts (root) {
    let ports = []

    function findPorts (node) {
      if (node instanceof ScenePort) {
        ports.push(node)
      }
      for (let child of node.children) {
        findPorts(child)
      }
    }

    findPorts(root)

    for (let port of ports) {
      if (port.isPersistent == false) {
        port.strip()
      }
    }
  }
}
