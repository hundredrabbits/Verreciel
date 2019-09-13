//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Player extends Empty {
  constructor () {
    // assertArgs(arguments, 0);
    super()

    console.info('^ Player | Init')

    this.canAlign = true
    this.isLocked = false
    this.isEjected = false
    this.name = 'helmet'
    this.position.set(0, 0, 0)
    this.accelX = 0
    this.accelY = 0
    this.isPanoptic = false

    this.port = new ScenePort(this, 'player')
    this.port.enable()

    this.element.add(verreciel.camera)
  }

  whenStart () {
    // assertArgs(arguments, 0);
    super.whenStart()
    console.info('+ Player | Start')
  }

  whenRenderer () {
    // assertArgs(arguments, 0);
    super.whenRenderer()

    if (!this.isLocked) {
      if (!this.isPanoptic) {
        this.rotation.x += this.accelX
      }
      this.rotation.y += this.accelY

      this.rotation.x = Math.max(
        -Math.PI / 2,
        Math.min(Math.PI * 2 / 3, this.rotation.x)
      )

      // dampening
      // closer to 1 for more 'momentum'
      this.accelX *= 0.75
      this.accelY *= 0.75
      if (Math.abs(this.accelX) < 0.005) {
        this.accelX = 0 // if it gets too small just drop to zero
      }
      if (Math.abs(this.accelY) < 0.005) {
        this.accelY = 0 // if it gets too small just drop to zero
      }
    }
  }

  lookAt (yDeg = 0, xDeg = 0) {
    // assertArgs(arguments, 1);
    let normalizedYDeg = radToDeg(this.rotation.y) % 360
    this.rotation.y = degToRad(normalizedYDeg)
    verreciel.helmet.rotation.y = degToRad(normalizedYDeg)

    this.isLocked = true

    verreciel.animator.begin('look at')
    verreciel.animator.animationDuration = 2.5

    this.rotation.y = degToRad(yDeg)
    this.rotation.x = degToRad(xDeg)
    if (!this.isPanoptic) {
      this.position.set(0, 0, 0) // ?
      verreciel.helmet.position.set(0, 0, 0) // ?
      verreciel.helmet.rotation.y = degToRad(yDeg)
    }

    verreciel.animator.completionBlock = function () {
      this.isLocked = false
      if (!this.isPanoptic) {
        verreciel.helmet.rotation.setNow(
          verreciel.helmet.rotation.x,
          this.rotation.y,
          verreciel.helmet.rotation.z
        )
      }
      verreciel.ghost.report(LogType.playerUnlock, yDeg)
    }.bind(this)
    verreciel.animator.commit()

    this.releaseHandle()
  }

  lookAtMod(yDeg = 0, xDeg = 0) {
    this.lookAt(radToDeg(this.rotation.y) + yDeg, xDeg)
  }

  setIsPanoptic (value) {
    if (this.isPanoptic == value) {
      return
    }
    this.isPanoptic = value

    verreciel.animator.begin()
    verreciel.animator.animationDuration = 2
    verreciel.animator.ease = Penner.easeInOutQuart
    this.isLocked = true
    if (this.isPanoptic) {
      this.position.y = -5
      this.rotation.x = degToRad(90)
      verreciel.space.structuresRoot.position.y = 5
      verreciel.space.structuresRoot.opacity = 0.2
      verreciel.helmet.position.y = -3
      verreciel.above.opacity = 0
      verreciel.below.opacity = 0
    } else {
      this.position.y = 0
      this.rotation.x = degToRad(0)
      verreciel.space.structuresRoot.position.y = 0
      verreciel.space.structuresRoot.opacity = 1
      verreciel.helmet.position.y = 0
      verreciel.above.opacity = 1
      verreciel.below.opacity = 1
    }

    verreciel.animator.completionBlock = function () {
      this.isLocked = false
      verreciel.helmet.resizeText(this.isPanoptic == true ? 0.04 : 0.025)
    }.bind(this)
    verreciel.animator.commit()
  }

  eject () {
    this.isLocked = true
    // assertArgs(arguments, 0);
    verreciel.animator.begin()
    verreciel.animator.animationDuration = 60
    verreciel.capsule.opacity = 0
    this.rotation.y = 0
    this.rotation.x = degToRad(90)
    this.rotation.z = 0
    this.position.set(0, 5, 0)
    verreciel.helmet.addWarning('the system is closing', verreciel.black, 3)
    verreciel.animator.completionBlock = function () {
      verreciel.animator.begin()
      verreciel.animator.animationDuration = 10
      verreciel.space.targetSpaceColor.setRGB(0, 0, 0)
      verreciel.helmet.opacity = 0
      verreciel.animator.completionBlock = function () {
        this.isEjected = true
        verreciel.game.save(0)
        if (!DEBUG_LOG_GHOST) {
          const remote = require('electron').remote
          const { dialog, app } = remote
          app.exit()
        }
      }.bind(this)
      verreciel.animator.commit()
    }.bind(this)
    verreciel.animator.commit()
  }

  ejectViaHatch () {
    this.isLocked = true
    verreciel.animator.begin()
    verreciel.animator.animationDuration = 2

    this.position.set(0, 0, 0)
    this.rotation.set(0, verreciel.hatch.rotation.y, 0)
    verreciel.helmet.opacity = 0
    verreciel.space.opacity = 0
    verreciel.above.opacity = 0
    verreciel.below.opacity = 0

    verreciel.animator.completionBlock = function () {
      verreciel.animator.begin()
      verreciel.animator.ease = Penner.easeInOutQuart
      verreciel.animator.animationDuration = 3
      verreciel.animator.delay = 3
      this.rotation.y = Math.PI + verreciel.hatch.rotation.y
      verreciel.animator.completionBlock = function () {
        verreciel.animator.begin()
        verreciel.animator.ease = Penner.easeInQuart
        verreciel.animator.animationDuration = 20
        verreciel.capsule.opacity = 0
        verreciel.animator.commit()

        let rotCapsuleY = verreciel.capsule.rotation.y
        var rotCapsuleVelY = 0
        function spiralCapsule () {
          verreciel.capsule.rotation.y -= rotCapsuleVelY * 0.18
          rotCapsuleVelY += 0.0002
          requestAnimationFrame(spiralCapsule)
        }
        spiralCapsule()
      }
      verreciel.animator.commit()

      let rotPlayerZ = verreciel.player.rotation.z
      var rotPlayerVelZ = 0
      function spiralCapsule () {
        verreciel.player.rotation.z += rotPlayerVelZ * 0.5
        rotPlayerVelZ += 0.000002
        requestAnimationFrame(spiralCapsule)
      }
      spiralCapsule()

      verreciel.animator.begin()
      verreciel.animator.animationDuration = 10
      verreciel.animator.ease = Penner.easeInOutCubic

      let destination = new THREE.Vector3(0, 0, 1)
      destination.applyAxisAngle(
        new THREE.Vector3(0, 1, 0),
        verreciel.hatch.rotation.y
      )
      destination.multiplyScalar(-10)
      this.position.set(destination.x, destination.y, destination.z)

      verreciel.animator.completionBlock = function () {
        this.isEjected = true
        verreciel.game.save(0)
      }.bind(this)
      verreciel.animator.commit()
    }.bind(this)
    verreciel.animator.commit()
  }

  // MARK: Left Hand -

  holdPort (port) {
    // assertArgs(arguments, 1);
    if (port.host != null && port.host.name != null) {
      verreciel.helmet.leftHandLabel.updateText(
        port.host.name,
        verreciel.white
      )
    }

    this.activePort = port
    verreciel.music.playEffect('click1')
  }

  connectPorts (from, to) {
    // assertArgs(arguments, 2);
    verreciel.helmet.leftHandLabel.updateText('--', verreciel.grey)

    this.activePort = null
    from.connect(to)
    from.update()
    to.update()
    verreciel.music.playEffect('click3')
  }

  releasePort () {
    // assertArgs(arguments, 0);
    if (!this.activePort) { return }
    verreciel.helmet.leftHandLabel.updateText('--', verreciel.grey)

    this.activePort.disconnect()
    this.activePort = null
    verreciel.music.playEffect('click2')
  }

  // MARK: Right Hand -

  holdHandle (handle) {
    // assertArgs(arguments, 1);
    this.releaseHandle()

    verreciel.helmet.rightHandLabel.updateText(
      handle.host.name,
      verreciel.white
    )

    this.activeHandle = handle
    this.activeHandle.disable()

    verreciel.animator.begin('grip')
    verreciel.animator.animationDuration = 2.5
    this.position.copy(this.activeHandle.destination)
    verreciel.helmet.position.copy(this.activeHandle.destination)
    verreciel.animator.commit()

    if (this.lastDelay != null) {
      cancelDelay(this.lastDelay)
      this.lastDelay = null
    }
    this.lastDelay = delay(5, this.releaseHandle.bind(this))
  }

  releaseHandle () {
    verreciel.animator.completeAnimation('grip')
    if (this.lastDelay != null) {
      cancelDelay(this.lastDelay)
      this.lastDelay = null
    }
    // assertArgs(arguments, 0);
    if (this.activeHandle == null) {
      return
    }

    verreciel.helmet.rightHandLabel.updateText('--', verreciel.grey)

    verreciel.animator.begin()
    verreciel.animator.ease = Penner.easeInOutQuad
    verreciel.animator.animationDuration = 2.5
    this.position.set(0, 0, 0)
    verreciel.helmet.position.set(0, 0, 0)
    verreciel.animator.commit()

    this.activeHandle.enable()
    this.activeHandle = null
  }

  onConnect () {
    // assertArgs(arguments, 0);
    super.onConnect()
    if (this.port.isReceivingFromPanel(verreciel.nav) == true) {
      verreciel.radar.modeOverview()
    }
    if (this.port.isReceivingEvent(verreciel.items.teapot) == true) {
      verreciel.helmet.drinkTea()
    }
  }

  onDisconnect () {
    // assertArgs(arguments, 0);
    super.onDisconnect()
    if (this.port.isReceivingFromPanel(verreciel.nav) != true) {
      verreciel.radar.modeNormal()
    }
  }

  send (key) {
    if (!this.port.connection.host.receive) { console.warn('host cannot receive'); return }
    this.port.connection.host.receive(key)
  }

  payload () {
    // assertArgs(arguments, 0);
    return new ConsolePayload([
      new ConsoleData('Ronin repl', `${Object.keys(verreciel.console.lisplib).length} fns`),
      new ConsoleData('', '--'),
      new ConsoleData('input query press enter'),
      new ConsoleData('input (help) see manual', '', null, verreciel.grey),
      new ConsoleData('ready.', '', null, verreciel.grey),
      new ConsoleData('', '', null, verreciel.grey)
    ])
  }
}
