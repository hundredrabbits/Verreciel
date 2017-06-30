class Verreciel
{
  constructor()
  {

  }

  install()
  {
    this.version = "r1";

    this.element = document.createElement("verreciel");
    document.body.appendChild(this.element);

    // Colors
    this.black = new THREE.Vector4(0, 0, 0, 1);
    this.grey = new THREE.Vector4(0.5, 0.5, 0.5, 1);
    this.white = new THREE.Vector4(1, 1, 1, 1);
    this.red = new THREE.Vector4(1, 0, 0, 1);
    this.cyan = new THREE.Vector4(0.44, 0.87, 0.76, 1);
    this.clear = new THREE.Vector4(0, 0, 0, 0);

    this.camera = new THREE.PerspectiveCamera( 80, 1, 1, 3000 );
    this.scene = new THREE.Scene();
    this.scene.background = new THREE.Color(0, 0, 0);
    this.renderer = new THREE.WebGLRenderer( { antialias: true } );
    this.renderer.setPixelRatio( window.devicePixelRatio );
    this.renderer.setSize( 0, 0 );
    this.element.appendChild( this.renderer.domElement );
    this.lastMousePosition = new THREE.Vector2();
    this.music = new Music();

    // Collections
    this.items = new Items();
    this.locations = new Locations();
    this.recipes = new Recipes();
    
    // Panels
    this.battery = new Battery();
    this.pilot = new Pilot();
    this.hatch = new Hatch();
    this.intercom = new Intercom();
    this.cargo = new Cargo();
    this.thruster = new Thruster();
    this.console = new Console();
    this.radar = new Radar();
    this.above = new Above();
    this.below = new Below();

    // Monitors
    this.journey = new Journey();
    this.exploration = new Exploration();
    this.progress = new Progress();
    this.completion = new Complete();
    
    this.radio = new Radio();
    this.nav = new Nav();
    this.shield = new Shield();
    this.enigma = new Enigma();

    // Core
    this.game = new Game();
    this.universe = new Universe();
    this.capsule = new Capsule();
    this.player = new Player();
    this.space = new Space();
    this.helmet = new Helmet();
    
    this.missions = new Missions();

    this.demo = new Demo();
  }

  start()
  {
    console.info("Starting Verreciel");

    document.addEventListener( "mousemove", this.mouseMove.bind(this), false );
    document.addEventListener( "mousedown", this.mouseDown.bind(this), false );
    document.addEventListener( "mouseup", this.mouseUp.bind(this), false );
    window.addEventListener( "resize", this.windowResize.bind(this), false );

    this.windowResize();

    this.scene.add(this.player);
    this.scene.add(this.helmet);
    this.scene.add(this.capsule);
    this.scene.add(this.space);

    this.scene.add(this.demo);

    this.universe.whenStart();
    this.player.whenStart();
    this.helmet.whenStart();
    this.capsule.whenStart();
    this.space.whenStart();
    this.game.whenStart();
    this.items.whenStart();
    
    this.demo.whenStart();

    this.update();
    this.render();
  }

  update()
  {
    this.demo.update();
    setTimeout(this.update.bind(this), 20);
  }

  render()
  {
    requestAnimationFrame( this.render.bind(this) );
    this.renderer.render( this.scene, this.camera );
  }

  mouseDown(e)
  {
    if (this.player.isLocked)
    {
      return;
    }
    
    this.lastMousePosition.x = e.screenX;
    this.lastMousePosition.y = e.screenY;
    
    this.player.canAlign = false;
    this.helmet.canAlign = false;
  }

  mouseMove(e)
  {
    if (this.player.isLocked)
    {
      return;
    }
    
    let dragX = e.screenX - this.lastMousePosition.x;
    let dragY = e.screenY - this.lastMousePosition.y;
    
    this.lastMousePosition.x = e.screenX;
    this.lastMousePosition.y = e.screenY;

    this.player.accelY += degToRad(dragX/6);
    this.player.accelX += degToRad(dragY/6);
        
    this.helmet.updatePort();
  }

  mouseUp(e)
  {
    if (this.player.isLocked)
    {
      return;
    }
    
    this.player.canAlign = true;
    this.helmet.canAlign = true;
    this.helmet.updatePort();
  }

  windowResize()
  {
    this.width = window.innerWidth;
    this.height = window.innerHeight;
    this.camera.aspect = this.width / this.height;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize( this.width, this.height );
  }
}

class Alignment extends Enum{} setEnumValues(Alignment, ['left', 'center', 'right',]);
class Systems extends Enum{} setEnumValues(Systems, ['loiqe', 'valen', 'senni', 'usul', 'close', 'unknown',]);
class ItemTypes extends Enum{} setEnumValues(ItemTypes, ['generic', 'fragment', 'battery', 'star', 'quest', 'waste', 'panel', 'key', 'currency', 'drive', 'cargo', 'shield', 'map', 'record', 'cypher', 'unknown',]);

const Records =
{
  record1:"loique",
  record2:"valen",
  record3:"senni",
  record4:"usul",
  record5:"pillar"
}

const Ambience =
{
  ambience1:"fog",
  ambience2:"ghost",
  ambience3:"silent",
  ambience4:"kelp",
  ambience5:"close"
}

const Templates =
{
  left: 0,
  right: 0,
  top: 0,
  bottom: 0,
  
  radius: 0,
  
  margin: 0,
  leftMargin: 0,
  rightMargin: 0,
  topMargin: 0,
  bottomMargin: 0,
  
  titlesAngle: 22,
  monitorsAngle: 47,
  warningsAngle: 44,
  
  lineSpacing: 0.42,
}

const Settings =
{
  sight: 2.0,
  approach: 0.5,
  collision: 0.5,
}
