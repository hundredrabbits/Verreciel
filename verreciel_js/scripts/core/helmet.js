class Helmet extends Empty
{
  constructor()
  {
    super();
    
    console.log("^ Helmet | Init");
    
    this.canAlign = false;
    this.visor = new Empty();
    this.message = "";
    this.passive = "";
    this.textSize = 0.025;
    this.visorDepth = -1.3;

    this.warningString = "";
    this.warningColor = verreciel.red;
    this.lastWarning = 0;

    this.add(this.visor);
    
    // Left
    
    this.displayLeft = new Empty();
    this.displayLeft.position.set(-0.5,0, this.visorDepth);
    this.displayLeft.add(new SceneLine([
      new THREE.Vector3(-0.2, -1.3, 0),
      new THREE.Vector3(0, -1.3, 0),
    ], verreciel.grey));
    this.displayLeft.add(new SceneLine([
      new THREE.Vector3(0, -1.3, 0),
      new THREE.Vector3(0.01, -1.275, 0),
    ], verreciel.grey));
    
    this.leftHandLabel = new SceneLabel("--", this.textSize, Alignment.left, verreciel.grey);
    this.leftHandLabel.position.set(-0.2, -1.375, 0);
    this.displayLeft.add(this.leftHandLabel);
    
    this.messageLabel = new SceneLabel("--", this.textSize, Alignment.center, verreciel.white);
    this.messageLabel.position.set(0,1.35, this.visorDepth);
    this.visor.add(this.messageLabel);
    
    this.passiveLabel = new SceneLabel("--", this.textSize, Alignment.center, verreciel.grey);
    this.passiveLabel.position.set(0,-1.2, this.visorDepth);
    this.visor.add(this.passiveLabel);
    
    this.displayLeft.rotation.y = degToRad(10);
    
    this.visor.add(this.displayLeft);
    
    // Right
    
    this.displayRight = new Empty();
    this.displayRight.position.set(0.5,0, this.visorDepth);
    this.displayRight.add(new SceneLine([
      new THREE.Vector3(0.2, -1.3, 0),
      new THREE.Vector3(0, -1.3, 0),
    ], verreciel.grey));
    this.displayRight.add(new SceneLine([
      new THREE.Vector3(0, -1.3, 0),
      new THREE.Vector3(-0.01, -1.275, 0),
    ], verreciel.grey));
    
    this.rightHandLabel = new SceneLabel("--", this.textSize, Alignment.right, verreciel.white);
    this.rightHandLabel.position.set(0.2, -1.375, 0);
    this.displayRight.add(this.rightHandLabel);
    
    this.displayRight.rotation.y = degToRad(-10);
    
    this.visor.add(this.displayRight);
    
    this.displayRight.add(new SceneLine([
      new THREE.Vector3(0.2, 1.4, 0),
      new THREE.Vector3(0.1, 1.4, 0),
    ], verreciel.grey));
    this.displayLeft.add(new SceneLine([
      new THREE.Vector3(-0.2, 1.4, 0),
      new THREE.Vector3(-0.1, 1.4, 0),
    ], verreciel.grey));
    
    // Center
    
    this.warningLabel = new SceneLabel("", 0.1, Alignment.center, verreciel.red);
    this.warningLabel.position.set(0, 2, -3.25);
    this.visor.add(this.warningLabel);
    
    this.visor.add(verreciel.player.port);
    verreciel.player.port.position.set(0,-3,-2.5);
    
    // iPhone4
    if (verreciel.width == 320 && verreciel.height == 480)
    {
      verreciel.player.port.position.set(0,-2,-2.5);
    }
    // iPad
    if (verreciel.width == 768 && verreciel.height == 1024)
    {
      verreciel.player.port.position.set(0,-2,-2.5);
      this.messageLabel.position.set(0,1.2, this.visorDepth);
    }
    // iPad Pro
    if (verreciel.width == 1024 && verreciel.height == 1366)
    {
      verreciel.player.port.position.set(0,-2,-2.5);
      this.messageLabel.position.set(0,1.2, this.visorDepth);
    }
  }
  
  whenStart()
  {
    super.whenStart();
    console.log("+ Helmet | Start");
  }
  
  whenRenderer()
  {
    super.whenRenderer();
        
    if (this.rotation.y > verreciel.player.rotation.y + 0.0001)
    {
      this.rotation.y -= (this.rotation.y - verreciel.player.rotation.y) * 0.75;
    }
    else if (this.rotation.y < verreciel.player.rotation.y - 0.0001)
    {
      this.rotation.y -= (this.rotation.y - verreciel.player.rotation.y) * 0.75;
    }
    if (this.rotation.x > verreciel.player.rotation.x + 0.0001)
    {
      this.rotation.x -= (this.rotation.x - verreciel.player.rotation.x) * 0.85;
    }
    else if (this.rotation.x < verreciel.player.rotation.x - 0.0001)
    {
      this.rotation.x -= (this.rotation.x - verreciel.player.rotation.x) * 0.85;
    }

    this.updatePort();
    this.warningLabel.blink();
  }

  updatePort()
  {
    if (verreciel.player.port.origin != null)
    {
      let test = convertPositionToNode(verreciel.player.port.position, verreciel.player.port.origin);
      verreciel.player.port.origin.wire.update(new THREE.Vector3(), test);
    }
    if (verreciel.player.port.connection != null)
    {
      let test = convertPositionFromNode(verreciel.player.port.position, verreciel.player.port.connection);
      verreciel.player.port.wire.update(test, new THREE.Vector3());
    }
  }
  
  addMessage(message, color)
  {   
    if (this.message == message)
    {
      return;
    }
    
    this.message = message;
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.1
    // this.messageLabel.hide();
    // this.messageLabel.updateColor(verreciel.cyan);
    // SCNTransaction.completionBlock = {
      // SCNTransaction.begin()
      // SCNTransaction.animationDuration = 0.1
      // this.messageLabel.update(this.message, color);
      // this.messageLabel.show();
      // SCNTransaction.commit()
    // }
    // SCNTransaction.commit()
  }
  
  addPassive(passive)
  {
    if (this.passive == passive)
    {
      return;
    }
    
    this.passive = passive;
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.1
    // this.passiveLabel.position.set(0,-1.2,this.visorDepth - 0.01);
    // this.passiveLabel.hide();
    // SCNTransaction.completionBlock = {
      // SCNTransaction.begin()
      // SCNTransaction.animationDuration = 0.1
      // this.passiveLabel.update(this.passive);
      // this.passiveLabel.position.set(0,-1.2,this.visorDepth);
      // this.passiveLabel.show();
      // SCNTransaction.commit()
    // }
    // SCNTransaction.commit()
  }
  
  addWarning(text, color = verreciel.red, duration, flag)
  {
    if (verreciel.game.time - this.lastWarning <= 10)
    {
      return;
    }
    if (text == "")
    {
      return;
    }
    
    this.warningString = text;
    this.warningColor = color;
    this.warningFlag = flag;
    this.lastWarning = verreciel.game.time;
    
    this.warningLabel.update(this.warningString, this.warningColor);
    verreciel.music.playEffect("beep2");
    
    delay(duration, this.hideWarning.bind(this));
  }
  
  hideWarning()
  {
    this.warningFlag = "";
    this.warningString = "";
    this.warningLabel.update("");
  }
}
