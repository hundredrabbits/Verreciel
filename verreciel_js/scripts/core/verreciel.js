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

    this.camera = new THREE.PerspectiveCamera( 80, 1, 1, 3000 );
    // this.camera.position.z = 1000;
    this.scene = new THREE.Scene();
    this.renderer = new THREE.WebGLRenderer( { antialias: true } );
    this.renderer.setPixelRatio( window.devicePixelRatio );
    this.renderer.setSize( 0, 0 );
    this.element.appendChild( this.renderer.domElement );
    this.lastMousePosition = new THREE.Vector2();
    this.music = new Music();

    // Panels
    // this.battery = new PanelBattery();
    // this.pilot = new PanelPilot();
    // this.hatch = new PanelHatch();
    // this.intercom = new PanelIntercom();
    // this.cargo = new PanelCargo();
    // this.thruster = new PanelThruster();
    // this.console = new PanelConsole();
    // this.radar = new PanelRadar();
    // this.above = new PanelAbove();
    // this.below = new PanelBelow();

    // Monitors
    // this.journey = new MonitorJourney();
    // this.exploration = new MonitorExploration();
    // this.progress = new MonitorProgress();
    // this.completion = new MonitorComplete();
    // this.radio = new WidgetRadio();
    // this.map = new WidgetMap();
    // this.shield = new WidgetShield();
    // this.enigma = new WidgetEnigma();

    // Collections
    this.missions = new Missions();
    this.items = new Items();
    // this.locations = new Locations();
    // this.recipes = new Recipess();

    // Colors
    this.black = new THREE.Vector4(0, 0, 0, 1);
    this.grey = new THREE.Vector4(0.5, 0.5, 0.5, 1);
    this.white = new THREE.Vector4(1, 1, 1, 1);
    this.red = new THREE.Vector4(1, 0, 0, 1);
    this.cyan = new THREE.Vector4(0.44, 0.87, 0.76, 1);
    this.clear = new THREE.Vector4(0, 0, 0, 0);
    
    // Core
    this.game = new Game();
    this.universe = new Universe();
    this.capsule = new Capsule();
    this.player = new Player();
    this.space = new Space();
    this.helmet = new Helmet();

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
    
    let dragX = Float(e.screenX - lastMousePosition.x);
    let dragY = Float(e.screenY - lastMousePosition.y);
    
    lastMousePosition.x = e.screenX;
    lastMousePosition.y = e.screenY;

    player.accelY += degToRad(dragX/6);
    player.accelX += degToRad(dragY/6);
        
    helmet.updatePort();
  }

  mouseUp(e)
  {
    if (this.player.isLocked)
    {
      return;
    }
    
    this.player.canAlign = true;
    this.helmet.canAlign = true;
    helmet.updatePort();
  }

  windowResize()
  {
    let width = window.innerWidth;
    let height = window.innerHeight;
    this.camera.aspect = width / height;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize( width, height );
  }
}

class Alignment extends Enum{} setEnumValues(Alignment, ['left', 'center', 'right',]);
class Systems extends Enum{} setEnumValues(Systems, ['loiqe', 'valen', 'senni', 'usul', 'close', 'unknown',]);
class ItemTypes extends Enum{} setEnumValues(ItemTypes, ['generic', 'fragment', 'battery', 'star', 'quest', 'waste', 'panel', 'key', 'currency', 'drive', 'cargo', 'shield', 'map', 'record', 'cypher', 'unknown',]);

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
