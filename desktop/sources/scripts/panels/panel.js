//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Panel extends Empty {
  constructor (name) {
    // assertArgs(arguments, 0);
    super()
    this.name = name
    this.isEnabled = false
    this.root = new Empty()
    this.add(this.root)
    this.isInstalled = false
    this.installPercentage = 0
  }

  refresh () {
    // assertArgs(arguments, 0);
  }

  enable () {
    // assertArgs(arguments, 0);
    this.isEnabled = true
  }

  disable () {
    // assertArgs(arguments, 0);
    this.isEnabled = false
  }

  // MARK: Installation -

  install () {
    // assertArgs(arguments, 0);
    if (this.isInstalled == true) {
      return
    }

    this.onInstallationBegin()
    this.installProgress()
  }

  installProgress () {
    // assertArgs(arguments, 0);
    this.installPercentage += (Math.random() * 6 + 1) * verreciel.game.gameSpeed

    if (this.installPercentage > 100) {
      this.onInstallationComplete()
    } else {
      delay(0.05, this.installProgress.bind(this))
    }
  }

  onInstallationBegin () {
    // assertArgs(arguments, 0);
    verreciel.music.playEffect('beep1')
  }

  onInstallationComplete () {
    // assertArgs(arguments, 0);
    this.installPercentage = 0
    this.isInstalled = true
    verreciel.music.playEffect('beep2')
    verreciel.ghost.report(LogType.install, this.name)
  }

  payload () {
    // assertArgs(arguments, 0);
    return new ConsolePayload([
      new ConsoleData('Capsule', 'Panel'),
      new ConsoleData(this.details)
    ])
  }
}
