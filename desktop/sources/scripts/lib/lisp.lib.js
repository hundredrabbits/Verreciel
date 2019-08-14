'use strict'

function LispLibrary () {
  // logic

  this.gt = (a, b) => {
    return a > b
  }

  this.lt = (a, b) => {
    return a < b
  }

  this.eq = (a, b) => {
    return a === b
  }

  this.neq = (a, b) => {
    return a !== b
  }

  this.and = (...args) => {
    for (const arg of args) {
      if (!arg) { return arg }
    }
    return args[args.length - 1]
  }

  this.or = (...args) => {
    for (const arg of args) {
      if (arg) { return arg }
    }
    return args[args.length - 1]
  }

  // Math

  this.add = (...args) => { // Adds values.
    return args.reduce((sum, val) => sum + val)
  }

  this.sub = (...args) => { // Subtracts values.
    return args.reduce((sum, val) => sum - val)
  }

  this.mul = (...args) => { // Multiplies values.
    return args.reduce((sum, val) => sum * val)
  }

  this.div = (...args) => { // Divides values.
    return args.reduce((sum, val) => sum / val)
  }

  this.mod = (a, b) => { // Returns the modulo of a and b.
    return a % b
  }

  this.clamp = (val, min, max) => { // Clamps a value between min and max.
    return Math.min(max, Math.max(min, val))
  }

  this.floor = (item) => {
    return Math.floor(item)
  }

  this.ceil = (item) => {
    return Math.ceil(item)
  }

  this.help = () => {
    return `${Object.keys(this).join(' ')}`
  }
}
