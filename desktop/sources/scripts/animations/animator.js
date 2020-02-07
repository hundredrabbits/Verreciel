//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Animator {
  constructor () {
    // assertArgs(arguments, 0, true);
    this.begun = false
    this.properties = []
    this.delay = 0
    this.ease = Penner.easeOutQuart
    this.animationID = 1
    this.animations = []
    this.animationsByName = {}
  }

  begin (name = null) {
    // assertArgs(arguments, 0);
    if (this.begun) {
      console.warn('Animator has already begun.')
      return
    }
    this.name = name
    if (this.name == null) {
      this.name = 'animation' + this.animationID
    }
    this.animationID++
    this.begun = true
    this.properties.splice(0, this.properties.length)
  }

  registerProperty (property) {
    // assertArgs(arguments, 1, true);
    if (!property.registered) {
      property.registered = true
      this.properties.push(property)
    }
  }

  commit () {
    // assertArgs(arguments, 0, true);
    if (!this.begun) {
      console.warn('Animator has not yet begun.')
      return
    }

    this.completeAnimation(this.name)

    let animation = new Animation(
      this.name,
      this.animationDuration,
      this.delay,
      this.ease,
      this.properties.slice(),
      this.completionBlock
    )
    this.animations.push(animation)
    this.name = null
    this.properties.splice(0, this.properties.length)
    this.begun = false
    this.animationDuration = 0
    this.completionBlock = null
    this.delay = 0
    this.animationsByName[animation.name] = animation
    this.ease = Penner.easeOutQuart
    return animation.name
  }

  completeAnimation (name) {
    let animation = this.animationsByName[name]
    if (animation == null) {
      return
    }
    delete this.animationsByName[name]
    const index = this.animations.indexOf(animation)
    this.animations.splice( index, 1 )
    animation.complete()
  }

  updateAnimations( delta ) {
    for( let i = 0; i < this.animations.length; i++ ) {
      this.animations[i].tick( delta )
    }
  }
}
