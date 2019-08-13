//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Game {
  constructor () {
    // assertArgs(arguments, 0);
    console.info('^ Game | Init')
    this.time = 0
    this.gameSpeed = 1
    if (DEBUG_LOG_GHOST) {
      this.gameSpeed = 5
    }
  }

  whenStart (jump_mission) {
    // assertArgs(arguments, 0);
    console.info('+ Game | Start')
    setTimeout(this.onTic.bind(this), 50)
    setTimeout(this.whenSecond.bind(this), 1000 / this.gameSpeed)
    if (JUMP_MISSION) {
      this.load(jump_mission)
    } else if (DEBUG_LOG_GHOST) {
      this.save(0)
    }
    this.load(this.state)
  }

  save (id) {
    // assertArgs(arguments, 1);
    if (DEBUG_DONT_SAVE) {
      return
    }
    console.info('@ GAME     | Saved State to ' + id)
    for (let c of document.cookie.split(';')) {
      document.cookie = c
        .replace(/^ +/, '')
        .replace(/=.*/, '=;expires=' + new Date().toUTCString() + ';path=/')
    }
    localStorage.state = id
    localStorage.version = verreciel.version
    verreciel.completion.refresh()
  }

  load (id) {
    // assertArgs(arguments, 1);
    id = id == 20 ? 0 : id

    console.info('@ GAME     | Loaded State to ' + id)

    for (let mission of verreciel.missions.story) {
      if (mission.id < id) {
        mission.complete()
      }
    }
    verreciel.missions.story[id].state()
  }

  get state () {
    // assertArgs(arguments, 0);
    if ('state' in localStorage) {
      return parseInt(localStorage.state)
    }
    return 0
  }

  erase () {
    // assertArgs(arguments, 0);
    console.info('$ GAME     | Erase')
    localStorage.clear()
  }

  reset () {
    console.info('$ GAME     | Erase')
    this.erase()
    this.load(0)
  }

  whenSecond () {
    // assertArgs(arguments, 0);
    setTimeout(this.whenSecond.bind(this), 1000 / this.gameSpeed)
    verreciel.capsule.whenSecond()
    verreciel.missions.refresh()
  }

  onTic () {
    // assertArgs(arguments, 0);
    setTimeout(this.onTic.bind(this), 50)
    this.time += this.gameSpeed
  }
}
