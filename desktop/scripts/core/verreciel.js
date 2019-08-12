//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Verreciel {
  constructor () {
    // assertArgs(arguments, 0);
  }

  install () {
    // assertArgs(arguments, 0);
    this.version = 'r1'

    this.phase = Phase.install

    this.element = document.createElement('verreciel')
    document.body.appendChild(this.element)

    this.theme = new Theme()

    this.colorPalette = [
      new THREE.Color(1, 0, 0), // red
      new THREE.Color(0.44, 0.87, 0.76), // cyan
      new THREE.Color(1, 1, 1) // white
    ]

    // Colors
    this.clear = new THREE.Vector4(0, 0, 0, 0)
    this.black = new THREE.Vector4(0, 0, 0, 1)
    this.grey = new THREE.Vector4(0, 0, 0.5, 1)
    this.white = new THREE.Vector4(0, 0, 1, 1)
    this.red = new THREE.Vector4(1, 0, 0, 1)
    this.cyan = new THREE.Vector4(0, 1, 0, 1)

    this.controller = new Controller()
    this.fps = 40
    this.camera = new THREE.PerspectiveCamera(105, 1, 0.0001, 10000)
    this.raycaster = new THREE.Raycaster()
    this.numClicks = 0
    this.scene = new THREE.Scene()
    this.scene.background = new THREE.Color(0, 0, 0)
    this.renderer = new THREE.WebGLRenderer({ antialias: true })
    // this.renderer.sortObjects = false;
    this.renderer.setPixelRatio(window.devicePixelRatio)
    this.renderer.setSize(0, 0)

    this.element.appendChild(this.renderer.domElement)
    this.lastMousePosition = new THREE.Vector2()
    this.mouseMoved = false
    this.music = new Music()

    this.animator = new Animator()
    this.ghost = new Ghost()

    // Collections
    this.items = new Items()
    this.locations = new Locations()
    this.recipes = new Recipes()

    // Panels
    this.battery = new Battery()
    this.pilot = new Pilot()
    this.hatch = new Hatch()
    this.intercom = new Intercom()
    this.cargo = new Cargo()
    this.thruster = new Thruster()
    this.console = new Console()
    this.radar = new Radar()
    this.above = new Above()
    this.below = new Below()

    // Monitors
    this.journey = new Journey()
    this.exploration = new Exploration()
    this.progress = new Progress()
    this.completion = new Complete()

    this.radio = new Radio()
    this.nav = new Nav()
    this.shield = new Shield()
    this.enigma = new Enigma()

    // Core
    this.game = new Game()
    this.universe = new Universe()
    this.capsule = new Capsule()
    this.player = new Player()
    this.space = new Space()
    this.helmet = new Helmet()

    this.missions = new Missions()
  }

  start () {
    this.phase = Phase.start

    // assertArgs(arguments, 0);
    console.info('Starting Verreciel')

    this.mouseIsDown = false
    document.addEventListener('mousemove', this.mouseMove.bind(this), false)
    document.addEventListener('mousedown', this.mouseDown.bind(this), false)
    document.addEventListener('mouseup', this.mouseUp.bind(this), false)
    document.addEventListener('wheel', this.mouseWheel.bind(this), false)
    window.addEventListener('resize', this.windowResize.bind(this), false)

    this.windowResize()

    this.controller.add('default', '*', 'About', () => { require('electron').shell.openExternal('http://hundredrabbits.itch.io/Verreciel') }, 'CmdOrCtrl+,')
    this.controller.add('default', '*', 'Fullscreen', () => { app.toggle_fullscreen() }, 'CmdOrCtrl+Enter')
    this.controller.add('default', '*', 'Hide', () => { app.toggle_visible() }, 'CmdOrCtrl+H')
    this.controller.add('default', '*', 'Inspect', () => { app.inspect() }, 'CmdOrCtrl+.')
    this.controller.add('default', '*', 'Documentation', () => { verreciel.controller.docs() }, 'CmdOrCtrl+Esc')
    this.controller.add('default', '*', 'Reset', () => { this.game.reset() }, 'CmdOrCtrl+Backspace')
    this.controller.add('default', '*', 'Quit', () => { app.exit() }, 'CmdOrCtrl+Q')

    this.controller.add('default', 'Look', 'Battery', () => { verreciel.player.lookAt(0) }, '1')
    this.controller.add('default', 'Look', 'Radar', () => { verreciel.player.lookAt(180) }, '2')
    this.controller.add('default', 'Look', 'Monitor', () => { verreciel.player.lookAt(90) }, '3')
    this.controller.add('default', 'Look', 'East', () => { verreciel.player.lookAt(-90) }, '4')

    this.controller.add('default', 'Look', 'Right', () => { verreciel.player.lookAtMod(90) }, 'D')
    this.controller.add('default', 'Look', 'Left', () => { verreciel.player.lookAtMod(-90) }, 'A')

    this.controller.add('default', 'Theme', 'Open Theme', () => { this.theme.open() }, 'CmdOrCtrl+Shift+O')
    this.controller.add('default', 'Theme', 'Reset Theme', () => { this.theme.reset() }, 'CmdOrCtrl+Shift+Backspace')
    this.controller.addSpacer('default', 'Theme', 'Download')
    this.controller.add('default', 'Theme', 'Download Themes..', () => { require('electron').shell.openExternal('https://github.com/hundredrabbits/Themes') })

    this.controller.commit()

    this.root = new Empty()
    this.scene.add(this.root.element)

    this.root.add(this.player)
    this.root.add(this.helmet)
    this.root.add(this.capsule)
    this.root.add(this.space)
    this.root.add(this.ghost)

    this.ghost.whenStart()
    this.universe.whenStart()
    this.player.whenStart()
    this.helmet.whenStart()
    this.capsule.whenStart()
    this.space.whenStart()
    this.game.whenStart()
    this.items.whenStart()

    if (DEBUG_SHOW_STATS) {
      this.stats = new Stats()
      this.stats.showPanel(1)
      document.body.appendChild(this.stats.dom)
    }

    this.root.whenResize()
    this.lastFrameTime = Date.now()
    this.render()
  }

  render () {
    this.phase = Phase.render
    // assertArgs(arguments, 0);
    requestAnimationFrame(this.render.bind(this))

    if (DEBUG_SHOW_STATS) {
      this.stats.begin()
    }
    let frameTime = Date.now()

    let framesElapsed = Math.min(
      100,
      (frameTime - this.lastFrameTime) / 1000 * this.fps * this.game.gameSpeed
    )
    if (framesElapsed > 1) {
      this.lastFrameTime = frameTime
      for (let i = 0; i < framesElapsed; i++) {
        this.root.whenRenderer()
      }
      this.helmet.updatePortWires()
      this.renderer.render(this.scene, this.camera)
    }
    this.phase = Phase.idle
    if (DEBUG_SHOW_STATS) {
      this.stats.end()
    }
  }

  mouseDown (e) {
    e.preventDefault()
    // assertArgs(arguments, 1);
    if (this.player.isLocked) {
      return
    }

    this.mouseIsDown = true
    this.mouseMoved = false

    this.lastMousePosition.x = e.clientX / this.width
    this.lastMousePosition.y = e.clientY / this.height

    this.player.canAlign = false
    this.helmet.canAlign = false
  }

  mouseMove (e) {
    e.preventDefault()
    // assertArgs(arguments, 1);
    if (!this.mouseIsDown) {
      return
    }
    if (this.player.isLocked) {
      return
    }

    this.mouseMoved = true

    let mouseX = e.clientX / this.width
    let mouseY = e.clientY / this.height

    let dragX = mouseX - this.lastMousePosition.x
    let dragY = mouseY - this.lastMousePosition.y

    this.lastMousePosition.x = mouseX
    this.lastMousePosition.y = mouseY

    this.player.accelY += dragX
    this.player.accelX += dragY
  }

  mouseUp (e) {
    e.preventDefault()
    // assertArgs(arguments, 1);
    this.mouseIsDown = false
    if (this.player.isLocked) {
      return
    }

    this.player.canAlign = true
    this.helmet.canAlign = true

    if (!this.mouseMoved) {
      event.preventDefault()
      let hits = this.getHits().filter(this.isEnabledTrigger)
      if (hits.length > 0 && this.ghost.isReplaying) {
        this.ghost.disappear()
      } else {
        this.numClicks++
        hits.sort(this.hasShortestDistance)
        for (let hit of hits) {
          if (hit.object.node.tap()) {
            break
          }
        }
      }
    }
  }

  mouseWheel (e) {
    e.preventDefault()
    if (this.mouseIsDown || this.player.isLocked) {
      return
    }
    this.player.accelY += e.deltaX * -0.001
    this.player.accelX += e.deltaY * -0.001
  }

  isEnabledTrigger (hit) {
    let node = hit.object.node
    return (
      node instanceof SceneTrigger &&
      node.isEnabled == true &&
      node.opacityFromTop > 0
    )
  }

  hasShortestDistance (hit1, hit2) {
    if (hit1.distSquared == null) {
      hit1.distSquared = hit1.object.node.getDistSquared(hit1.point)
    }
    if (hit2.distSquared == null) {
      hit2.distSquared = hit2.object.node.getDistSquared(hit2.point)
    }
    return hit1.distSquared - hit2.distSquared
  }

  getHits () {
    let mouse = new THREE.Vector2()
    mouse.x = this.lastMousePosition.x * 2 - 1
    mouse.y = -this.lastMousePosition.y * 2 + 1

    this.raycaster.setFromCamera(mouse, this.camera)
    return this.raycaster.intersectObjects(this.scene.children, true)
  }

  windowResize () {
    // assertArgs(arguments, 0);
    this.width = window.innerWidth
    this.height = window.innerHeight
    this.camera.aspect = this.width / this.height
    this.camera.updateProjectionMatrix()
    this.renderer.setSize(this.width, this.height)
    if (this.root != null) {
      this.root.whenResize()
    }
  }

  scramblePalette () {
    this.colorPalette[0].setRGB(Math.random(), Math.random(), Math.random())
    this.colorPalette[1].setRGB(Math.random(), Math.random(), Math.random())
    this.colorPalette[2].setRGB(Math.random(), Math.random(), Math.random())
    this.root.updateColorPalette()
  }
}

class Phase {}
setEnumValues(Phase, ['init', 'start', 'render', 'idle'])
class Alignment {}
setEnumValues(Alignment, ['left', 'center', 'right'])
class Systems {}
setEnumValues(Systems, ['loiqe', 'valen', 'senni', 'usul', 'close', 'unknown'])
class ItemTypes {}
setEnumValues(ItemTypes, [
  'generic',
  'fragment',
  'battery',
  'star',
  'quest',
  'waste',
  'panel',
  'key',
  'currency',
  'drive',
  'cargo',
  'shield',
  'map',
  'record',
  'cypher',
  'unknown'
])

const Records = {
  record1: 'loiqe',
  record2: 'valen',
  record3: 'senni',
  record4: 'usul',
  record5: 'pillar'
}

const Ambience = {
  ambience1: 'fog',
  ambience2: 'ghost',
  ambience3: 'silent',
  ambience4: 'kelp',
  ambience5: 'close'
}

const Templates = (function () {
  let templates = {
    titlesAngle: 22,
    monitorsAngle: 47,
    warningsAngle: 44,

    lineSpacing: 0.42
  }

  let scale = 1
  let height = 1.5

  let highNode = [
    new THREE.Vector3(2 * scale, height, -4 * scale),
    new THREE.Vector3(4 * scale, height, -2 * scale),
    new THREE.Vector3(4 * scale, height, 2 * scale),
    new THREE.Vector3(2 * scale, height, 4 * scale),
    new THREE.Vector3(-2 * scale, height, 4 * scale),
    new THREE.Vector3(-4 * scale, height, 2 * scale),
    new THREE.Vector3(-4 * scale, height, -2 * scale),
    new THREE.Vector3(-2 * scale, height, -4 * scale)
  ]

  templates.left = highNode[7].x
  templates.right = highNode[0].x
  templates.top = highNode[0].y
  templates.bottom = -highNode[0].y
  templates.leftMargin = highNode[7].x * 0.8
  templates.rightMargin = highNode[0].x * 0.8
  templates.topMargin = highNode[0].y * 0.8
  templates.bottomMargin = -highNode[0].y * 0.8
  templates.radius = highNode[0].z
  templates.margin = Math.abs(templates.left - templates.leftMargin)

  return templates
})()

const Settings = {
  sight: 2.0,
  approach: 0.5,
  collision: 0.5
}
