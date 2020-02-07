//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Animation {
  constructor (name, duration, animDelay, ease, properties, completionBlock) {
    this.name = name
    this.duration = duration
    this.delay = animDelay
    this.ease = ease
    this.properties = properties
    this.completionBlock = completionBlock
    this.percent = 0
    this.completed = false
    this.started = false
    this.tick = this.tick.bind( this )

    for (let property of this.properties) {
      if (property.registered) {
        property.commit(this.name)
      }
    }

    if( this.delay ) {
      delay(this.delay, () => {
        this.started = true
      })
    } else {
      this.started = true
    }
  }

  tick ( delta ) {
    if (this.completed || !this.started) {
      return
    }

    var percentElapsed = delta / this.duration * verreciel.game.gameSpeed
    this.percent += percentElapsed

    if (this.percent > 1) {
      this.percent = 1
    }

    let easedPercent = this.ease(this.percent, 0, 1, 1)

    for (let property of this.properties) {
      if (property.registered) {
        property.interpolate(easedPercent)
        if (this.percent >= 1) {
          property.animation = null
          property.registered = false
        }
      }
    }

    if (this.started == true && this.percent >= 1) {
      verreciel.animator.completeAnimation(this.name)
    }
  }

  complete () {
    if (this.completed) {
      return
    }
    this.completed = true
    if (this.completionBlock != null) {
      this.completionBlock()
    }
  }
}
