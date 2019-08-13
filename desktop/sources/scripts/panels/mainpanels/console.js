//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Console extends MainPanel {
  constructor () {
    // assertArgs(arguments, 0);
    super('console')

    this.lines = [
      new ConsoleLine(1),
      new ConsoleLine(2),
      new ConsoleLine(3),
      new ConsoleLine(4),
      new ConsoleLine(5),
      new ConsoleLine(6)
    ]

    this.details = 'inspects events'

    this.text = ''

    this.receive = (key) => {
      if (key === 'Backspace' && this.text.length > 0) {
        this.text = this.text.substring(0, this.text.length - 1)
      } else if (key === 'Enter' && this.text.length > 0) {
        this.validate(this.text)
      } else if (key.length === 1 && this.text.length < 48) {
        this.text += key
      }
      this.inject(this.inputPayload())
    }

    this.lines[0].position.set(
      Templates.leftMargin,
      Templates.lineSpacing * 2.5,
      0
    )
    this.lines[1].position.set(
      Templates.leftMargin,
      Templates.lineSpacing * 1.5,
      0
    )
    this.lines[2].position.set(
      Templates.leftMargin,
      Templates.lineSpacing * 0.5,
      0
    )
    this.lines[3].position.set(
      Templates.leftMargin,
      -Templates.lineSpacing * 0.5,
      0
    )
    this.lines[4].position.set(
      Templates.leftMargin,
      -Templates.lineSpacing * 1.5,
      0
    )
    this.lines[5].position.set(
      Templates.leftMargin,
      -Templates.lineSpacing * 2.5,
      0
    )

    for (let line of this.lines) {
      this.mainNode.add(line)
    }

    this.footer.add(new SceneHandle(new THREE.Vector3(-1, 0, 0), this))
    this.drawDecals()
  }

  onConnect () {
    // assertArgs(arguments, 0);
    super.onDisconnect()

    this.nameLabel.updateText(
      this.port.origin.host.name + ' > Port',
      verreciel.cyan
    )

    if (this.port.origin.event != null) {
      this.inject(this.port.origin.event.payload())
    } else if (this.port.origin.host != null) {
      this.inject(this.port.origin.host.payload())
    }
  }

  onDisconnect () {
    // assertArgs(arguments, 0);
    super.onDisconnect()

    this.nameLabel.updateText('Console', verreciel.grey)
    this.inject(this.defaultPayload())
  }

  whenStart () {
    // assertArgs(arguments, 0);
    super.whenStart()

    this.nameLabel.color = verreciel.grey
    this.inject(this.defaultPayload())
  }

  clear () {
    // assertArgs(arguments, 0);
    for (let line of this.lines) {
      line.updateData(new ConsoleData())
    }

    ScenePort.stripAllPorts(this.mainNode)
  }

  inject (payload, animate = true) {
    // assertArgs(arguments, 1);
    this.clear()
    var id = 0
    for (let data of payload.data) {
      if (this.lines[id]) {
        this.lines[id].updateData(data)
      }
      id += 1
    }

    if (animate) {
      var count = 0
      for (let line of this.lines) {
        line.position.z = count * -0.1
        line.opacity = 0
        count += 1
      }

      verreciel.animator.begin()
      verreciel.animator.animationDuration = 0.5

      for (let line of this.lines) {
        line.position.z = 0
        line.opacity = 1
      }

      verreciel.animator.commit()
    }
  }

  inputPayload () {
    // assertArgs(arguments, 0);
    const segments = this.text.match(/.{1,16}/g)
    return new ConsolePayload([
      new ConsoleData(segments && segments[0] ? segments[0] : '', this.text.length, null, verreciel.white),
      new ConsoleData(segments && segments[1] ? segments[1] : '', '', null, verreciel.white),
      new ConsoleData(segments && segments[2] ? segments[2] : '', '', null, verreciel.white),
      new ConsoleData('!!', `${verreciel.capsule.at.x.toFixed(2)} ${verreciel.capsule.at.y.toFixed(2)}`, null, verreciel.grey),
      new ConsoleData('!', `${verreciel.capsule.radiation.toFixed(2)}`, null, verreciel.grey),
      new ConsoleData('', `${verreciel.capsule.system}`, null, verreciel.grey)
    ])
  }

  defaultPayload () {
    // assertArgs(arguments, 0);
    return new ConsolePayload([
      new ConsoleData('nataniev network', 'OK', null, verreciel.white),
      new ConsoleData('systems status', verreciel.capsule.systemsInstalledCount() + '/' + verreciel.capsule.systemsCount(), null, verreciel.grey),
      new ConsoleData('local time', `${new Arvelie()} ${new Neralie()}`, null, verreciel.grey),
      new ConsoleData('position', `${verreciel.capsule.at.x.toFixed(2)} ${verreciel.capsule.at.y.toFixed(2)}`, null, verreciel.grey),
      new ConsoleData('radiation', `${verreciel.capsule.radiation.toFixed(2)}`, null, verreciel.grey),
      new ConsoleData('sector', `${verreciel.capsule.system}`, null, verreciel.grey)
    ])
  }

  onInstallationBegin () {
    // assertArgs(arguments, 0);
    super.onInstallationBegin()

    verreciel.player.lookAt(-270)
  }

  onInstallationComplete () {
    // assertArgs(arguments, 0);
    super.onInstallationComplete()
    if (this.port.origin == null) {
      this.nameLabel.updateText('Console', verreciel.grey)
      this.inject(this.defaultPayload())
    } else {
      this.nameLabel.updateText(
        this.port.origin.host.name + ' > Port',
        verreciel.cyan
      )
    }
  }
}

class ConsoleLine extends Empty {
  constructor (index) {
    // assertArgs(arguments, 0);
    super()

    this.port = new ScenePortRedirect(this, 'console_line_' + index)
    this.port.position.set(0, 0, 0)
    this.port.hide()
    this.add(this.port)

    this.textLabel = new SceneLabel('', 0.0875, Alignment.left)
    this.textLabel.position.set(0.3, 0, 0)
    this.add(this.textLabel)

    this.detailsLabel = new SceneLabel(
      '',
      0.075,
      Alignment.right,
      verreciel.grey
    )
    this.detailsLabel.position.set(3.2, 0, 0)
    this.add(this.detailsLabel)
  }

  updateData (data) {
    // assertArgs(arguments, 1);
    this.detailsLabel.updateText(data.details)

    if (data.event != null) {
      this.textLabel.updateText(data.text, data.color)
      this.port.addEvent(data.event)
      this.port.enable()
      this.port.show()
      this.textLabel.position.set(0.3, 0, 0)
    } else {
      this.textLabel.updateText('> ' + data.text, data.color)
      this.port.disable()
      this.port.hide()
      this.textLabel.position.set(0, 0, 0)
    }
  }
}

class ConsoleData {
  constructor (text = '', details = '', event = null, color = verreciel.white) {
    // assertArgs(arguments, 0);
    this.text = text
    this.details = details
    this.event = event
    this.color = color
  }
}

class ConsolePayload {
  constructor (data) {
    // assertArgs(arguments, 1);
    this.data = data
  }
}
