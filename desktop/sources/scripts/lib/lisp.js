'use strict'

function Lisp (lib = {}) {
  const TYPES = { identifier: 0, number: 1, string: 2, bool: 3, symbol: 4 }

  const Context = function (scope, parent) {
    this.scope = scope
    this.parent = parent
    this.get = function (identifier) {
      if (identifier in this.scope) {
        return this.scope[identifier]
      } else if (this.parent !== undefined) {
        return this.parent.get(identifier)
      }
    }
  }

  const special = {
    if: function (input, context) {
      if (interpret(input[1], context)) {
        return interpret(input[2], context)
      }
      return input[3] ? interpret(input[3], context) : []
    },
    lambda: function (input, context) {
      return function () {
        const lambdaArguments = arguments
        const lambdaScope = input[1].reduce(function (acc, x, i) {
          acc[x.value] = lambdaArguments[i]
          return acc
        }, {})
        return interpret(input[2], new Context(lambdaScope, context))
      }
    }
  }

  const interpretList = function (input, context) {
    if (input.length > 0 && input[0].value in special) {
      return special[input[0].value](input, context)
    }
    const list = []
    for (let i = 0; i < input.length; i++) {
      if (input[i].type === TYPES.symbol) {
        if (input[i].host) {
          const host = context.get(input[i].host)
          if (host) {
            list.push(host[input[i].value])
          }
        } else {
          list.push(obj => obj[input[i].value])
        }
      } else {
        list.push(interpret(input[i], context))
      }
    }
    return list[0] instanceof Function ? list[0].apply(undefined, list.slice(1)) : list
  }

  const interpret = function (input, context) {
    if (!input) { console.warn('Lisp', 'error', context.scope); return null }
    if (context === undefined) {
      return interpret(input, new Context(lib))
    } else if (input instanceof Array) {
      return interpretList(input, context)
    } else if (input.type === TYPES.identifier) {
      return context.get(input.value)
    } else if (input.type === TYPES.number || input.type === TYPES.symbol || input.type === TYPES.string || input.type === TYPES.bool) {
      return input.value
    }
  }

  const categorize = function (input) {
    if (!isNaN(parseFloat(input))) {
      return { type: TYPES.number, value: parseFloat(input) }
    } else if (input[0] === '"' && input.slice(-1) === '"') {
      return { type: TYPES.string, value: input.slice(1, -1) }
    } else if (input[0] === ':') {
      return { type: TYPES.symbol, value: input.slice(1) }
    } else if (input.indexOf(':') > 0) {
      return { type: TYPES.symbol, host: input.split(':')[0], value: input.split(':')[1] }
    } else if (input === 'true' || input === 'false') {
      return { type: TYPES.bool, value: input === 'true' }
    } else {
      return { type: TYPES.identifier, value: input }
    }
  }

  const parenthesize = function (input, list) {
    if (list === undefined) { return parenthesize(input, []) }
    const token = input.shift()
    if (token === undefined) {
      return list.pop()
    } else if (token === '(') {
      list.push(parenthesize(input, []))
      return parenthesize(input, list)
    } else if (token === ')') {
      return list
    } else {
      return parenthesize(input, list.concat(categorize(token)))
    }
  }

  const tokenize = function (input) {
    const i = input.replace(/^\;.*\n?/gm, '').split('"')
    return i.map(function (x, i) {
      return i % 2 === 0 ? x.replace(/\(/g, ' ( ').replace(/\)/g, ' ) ') : x.replace(/ /g, '!ws!')
    }).join('"').trim().split(/\s+/).map(function (x) { return x.replace(/!ws!/g, ' ') })
  }

  this.parse = function (input) {
    return parenthesize(tokenize(input))
  }

  this.run = (input) => {
    return interpret(this.parse(`${input}`))
  }
}
