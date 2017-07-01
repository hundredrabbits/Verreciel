class Player extends Empty
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();
    
    console.log("^ Player | Init");

    this.canAlign = true;
    this.isLocked = false;
    this.isEjected = false;
    this.name = "helmet";
    this.position.set(0, 0, 0);
    this.accelX = 0;
    this.accelY = 0;
    
    this.port = new ScenePort(this);
    this.port.enable();

    this.trigger = new SceneTrigger(this, 2, 0.75);
    this.trigger.position.set(0, 0.9, -1.01);
    this.trigger.hide();
    this.add(this.trigger);
    
    this.triggerLabel = new SceneLabel("return to capsule", 0.03, Alignment.center, verreciel.red);
    this.triggerLabel.position.set(0,0,0);
    this.trigger.add(this.triggerLabel);
  }
  
  whenStart()
  {
    assertArgs(arguments, 0);
    super.whenStart();
    console.log("+ Player | Start");
  }
  
  activateEvent(event)
  {
    assertArgs(arguments, 1);
    this.event = event;
  }
  
  whenRenderer()
  {
    assertArgs(arguments, 0);
    super.whenRenderer();

    if (!this.isLocked)
    {
      this.rotation.x += this.accelX;
      this.rotation.y += this.accelY;

      this.rotation.x = sanitizeAngle(this.rotation.x);
      this.rotation.y = sanitizeAngle(this.rotation.y);

      this.rotation.x = Math.max(-Math.PI / 2, Math.min(Math.PI * 2 / 3, this.rotation.x));

      //dampening
      // closer to 1 for more 'momentum'
      this.accelX *= 0.75;
      this.accelY *= 0.75;
      if (Math.abs(this.accelX) < 0.005)
      {
          this.accelX = 0; //if it gets too small just drop to zero
      }
      if (Math.abs(this.accelY) < 0.005)
      {
          this.accelY = 0; //if it gets too small just drop to zero
      }
    }

    this.meat.add(verreciel.camera);
  }
  
  lookAt(deg = 0)
  {
    assertArgs(arguments, 1);
    let normalizedDeg = radToDeg(this.rotation.y) % 360;
    this.rotation.y = degToRad(normalizedDeg);
    verreciel.helmet.rotation.y = degToRad(normalizedDeg);
    
    this.isLocked = true;
    
    verreciel.sceneTransaction.begin();
    verreciel.sceneTransaction.animationDuration = 2.5;
    
    this.position.set(0, 0, 0); // ?
    this.rotation.y = degToRad(deg);
    verreciel.helmet.position.set(0, 0, 0); // ?
    verreciel.helmet.rotation.y = degToRad(deg);
    
    verreciel.sceneTransaction.completionBlock = function(){ this.isLocked = false; }.bind(this);
    verreciel.sceneTransaction.commit();
    
    this.releaseHandle();
  }
  
  eject()
  {
    assertArgs(arguments, 0);
    verreciel.sceneTransaction.begin();
    verreciel.sceneTransaction.animationDuration = 2;
    
    this.position.set(0,0,0);
    verreciel.capsule.opacity = 0;
    verreciel.helmet.opacity = 0; 
    
    verreciel.sceneTransaction.completionBlock = function(){
    
      verreciel.sceneTransaction.begin();
      verreciel.sceneTransaction.animationDuration = 10;
      
      this.position.set(0,5,0);
      
      verreciel.sceneTransaction.completionBlock = function(){
        this.isEjected = true;
        game.save(0);
      }.bind(this);
      verreciel.sceneTransaction.commit();
      
    }.bind(this);
    verreciel.sceneTransaction.commit();
  }
  
  // MARK: Left Hand -
  
  holdPort(port)
  {
    assertArgs(arguments, 1);
    if (port.host != null && port.host.name != null)
    {
      verreciel.helmet.leftHandLabel.updateText(port.host.name, verreciel.white);
    }
    
    this.activePort = port;
    this.port.activate();
    verreciel.music.playEffect("click1");
  }
  
  connectPorts(from, to)
  {
    assertArgs(arguments, 2);
    verreciel.helmet.leftHandLabel.updateText("--", verreciel.grey);
    
    this.activePort = null;
    from.connect(to);
    from.desactivate();
    to.desactivate();
    from.update();
    to.update();
    verreciel.music.playEffect("click3");
  }
  
  releasePort()
  {
    assertArgs(arguments, 0);
    verreciel.helmet.leftHandLabel.updateText("--", verreciel.grey);
    
    this.activePort.desactivate();
    this.activePort.disconnect();
    this.activePort = null;
    verreciel.music.playEffect("click2");
  }
  
  // MARK: Right Hand -

  holdHandle(handle)
  {
    assertArgs(arguments, 1);
    this.releaseHandle();
    
    verreciel.helmet.rightHandLabel.updateText(handle.host.name, verreciel.white);
    
    this.activeHandle = handle;
    this.activeHandle.disable();
    
    verreciel.sceneTransaction.begin();
    verreciel.sceneTransaction.animationDuration = 2.5;
    this.position.copy(this.activeHandle.destination);
    verreciel.helmet.position.copy(this.activeHandle.destination);
    verreciel.sceneTransaction.commit();
    
    delay(5, this.releaseHandle.bind(this));
  }
  
  releaseHandle()
  {
    assertArgs(arguments, 0);
    if (this.activeHandle == null)
    {
      return;
    }

    verreciel.helmet.rightHandLabel.updateText("--", verreciel.grey);
    
    verreciel.sceneTransaction.begin();
    verreciel.sceneTransaction.animationDuration = 2.5;
    this.position.set(0,0,0);
    verreciel.helmet.position.set(0,0,0);
    verreciel.sceneTransaction.commit();

    this.activeHandle.enable();
    this.activeHandle = null;
  }
  
  onConnect()
  {
    assertArgs(arguments, 0);
    super.onConnect()
    if (port.isReceivingFromPanel(verreciel.nav) == true)
    {
      radar.modeOverview();
    }
  }
  
  onDisconnect()
  {
    assertArgs(arguments, 0);
    super.onDisconnect()
    if (port.isReceivingFromPanel(verreciel.nav) != true)
    {
      radar.modeNormal();
    }
  }
  
  payload()
  {
    assertArgs(arguments, 0);
    return new ConsolePayload([
      new ConsoleData("Hiversaire unit", "type"), 
      new ConsoleData("--", "--"),
      new ConsoleData("paradise", "console"),
      new ConsoleData("ready.", "status"),
    ]);
  }
}
