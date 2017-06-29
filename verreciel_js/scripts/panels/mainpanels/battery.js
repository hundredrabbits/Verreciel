class Battery extends MainPanel
{
  constructor()
  {
    super();
    
    this.name = "battery";
    this.details = "powers systems";
  
    // Cells
    
    let distance = 0.3;
    
    this.cellPort1 = new ScenePortSlot(this, Alignment.right);
    this.cellPort1.position.set(-distance, Templates.lineSpacing, 0);
    this.cellPort1.enable();
    this.mainNode.add(this.cellPort1);
    
    this.cellPort2 = new ScenePortSlot(this, Alignment.right);
    this.cellPort2.position.set(-distance, 0, 0);
    this.cellPort2.enable();
    this.mainNode.add(this.cellPort2);
    
    this.cellPort3 = new ScenePortSlot(this, Alignment.right);
    this.cellPort3.position.set(-distance, -Templates.lineSpacing, 0);
    this.cellPort3.enable();
    this.mainNode.add(this.cellPort3);
    
    // Systems
    
    this.enigmaPort = new ScenePort(this);
    this.enigmaPort.position.set(distance, 2 * Templates.lineSpacing, 0);
    this.enigmaLabel = new SceneLabel("shield", 0.1, Alignment.left);
    this.enigmaLabel.position.set(0.3, 0, 0);
    this.enigmaPort.add(this.enigmaLabel);
    this.mainNode.add(this.enigmaPort);
    
    this.thrusterPort = new ScenePort(this);
    this.thrusterPort.position.set(distance, Templates.lineSpacing, 0);
    this.thrusterLabel = new SceneLabel("thruster", 0.1, Alignment.left);
    this.thrusterLabel.position.set(0.3, 0, 0);
    this.thrusterPort.add(this.thrusterLabel);
    this.mainNode.add(this.thrusterPort);
    
    this.radioPort = new ScenePort(this);
    this.radioPort.position.set(distance, 0, 0);
    this.radioLabel = new SceneLabel("radio", 0.1, Alignment.left);
    this.radioLabel.position.set(0.3, 0, 0);
    this.radioPort.add(this.radioLabel);
    this.mainNode.add(this.radioPort);
    
    this.navPort = new ScenePort(this);
    this.navPort.position.set(distance,  -Templates.lineSpacing, 0);
    this.navLabel = new SceneLabel("cloak", 0.1, Alignment.left);
    this.navLabel.position.set(0.3, 0, 0);
    this.navPort.add(this.navLabel);
    this.mainNode.add(this.navPort);
    
    this.shieldPort = new ScenePort(this);
    this.shieldPort.position.set(distance, 2 * -Templates.lineSpacing, 0);
    this.shieldLabel = new SceneLabel("oxygen", 0.1, Alignment.left);
    this.shieldLabel.position.set(0.3, 0, 0);
    this.shieldPort.add(this.shieldLabel);
    this.mainNode.add(this.shieldPort);
    
    this.enigmaLabel.update("--", verreciel.grey);
    this.thrusterLabel.update("--", verreciel.grey);
    this.radioLabel.update("--", verreciel.grey);
    this.navLabel.update("--", verreciel.grey);
    this.shieldLabel.update("--", verreciel.grey);
    
    this.cellPort2.disableAndShow("--", verreciel.grey);
    this.cellPort3.disableAndShow("--", verreciel.grey);
    
    this.footer.add(new SceneHandle(new THREE.Vector3(0,0,-1), this));
  }
  
  whenStart()
  {
    this.installThruster();
  }
  
  contains(item)
  {
    if (this.cellPort1.event != null && this.cellPort1.event == item)
    {
      return true;
    }
    if (this.cellPort2.event != null && this.cellPort2.event == item)
    {
      return true;
    }
    if (this.cellPort3.event != null && this.cellPort3.event == item)
    {
      return true;
    }
    return false;
  }

  // MARK: Modules -
  
  installEnigma()
  {
    this.enigmaPort.enable();
    this.enigmaLabel.update("enigma",verreciel.white);;
  }
  
  installThruster()
  {
    this.thrusterPort.enable();
    this.thrusterLabel.update("thruster",verreciel.white);
    verreciel.player.lookAt(0);
  }
  
  installRadio()
  {
    this.radioPort.enable();
    radioLabel.update("radio",verreciel.white);
  }
  
  installNav()
  {
    this.navPort.enable();
    this.navLabel.update("map",verreciel.white);
  }
  
  installShield()
  {
    this.shieldPort.enable();
    this.shieldLabel.update("shield",verreciel.white);
    if (verreciel.player != null)
    {
      verreciel.player.lookAt(0);
    }
  }
  
  isEnigmaPowered()
  {
    if (this.enigmaPort.isReceivingItemOfType(ItemTypes.battery))
    {
      return true;
    }
    return false;
  }
  
  isThrusterPowered()
  {
    if (this.thrusterPort.isReceivingItemOfType(ItemTypes.battery))
    {
      return true;
    }
    return false;
  }
  
  isRadioPowered()
  {
    if (this.radioPort.isReceivingItemOfType(ItemTypes.battery))
    {
      return true;
    }
    return false;
  }
  
  isMapPowered()
  {
    if (this.navPort.isReceivingItemOfType(ItemTypes.battery))
    {
      return true;
    }
    return false;
  }
  
  isShieldPowered()
  {
    if (this.shieldPort.isReceivingItemOfType(ItemTypes.battery))
    {
      return true;
    }
    return false;
  }
  
  // MARK: Flags -

  onConnect()
  {
    this.refresh();
  }
  
  onDisconnect()
  {
    this.refresh()
  }
  
  refresh()
  {
    if (this.thrusterPort.isReceivingItemOfType(ItemTypes.battery) == true)
    {
      verreciel.thruster.onPowered();
    }
    else
    {
      verreciel.thruster.onUnpowered();
    }
    if (this.shieldPort.isReceivingItemOfType(ItemTypes.battery) == true)
    {
      verreciel.shield.onPowered();
    }
    else
    {
      verreciel.shield.onUnpowered();
    }
    if (this.enigmaPort.isReceivingItemOfType(ItemTypes.battery) == true)
    {
      verreciel.enigma.onPowered();
    }
    else
    {
      verreciel.enigma.onUnpowered();
    }
    if (this.navPort.isReceivingItemOfType(ItemTypes.battery) == true)
    {
      verreciel.map.onPowered();
    }
    else
    {
      verreciel.map.onUnpowered();
    }
    if (this.radioPort.isReceivingItemOfType(ItemTypes.battery) == true)
    {
      verreciel.radio.onPowered();
    }
    else
    {
      verreciel.radio.onUnpowered();
    }
  }
  
  hasCell(target)
  {
    if (this.cellPort1.event != null && this.cellPort1.event == target)
    {
      return true;
    }
    if (this.cellPort2.event != null && this.cellPort2.event == target)
    {
      return true;
    }
    if (this.cellPort3.event != null && this.cellPort3.event == target)
    {
      return true;
    }
    return false;
  }
  
  cellCount()
  {
    var count = 0;
    
    if (this.cellPort1.hasItemOfType(ItemTypes.battery) == true)
    {
      count += 1;
    }
    if (this.cellPort2.hasItemOfType(ItemTypes.battery) == true)
    {
      count += 1;
    }
    if (this.cellPort3.hasItemOfType(ItemTypes.battery) == true)
    {
      count += 1;
    }
    
    return count;
  }
  
  onInstallationBegin()
  {
    super.onInstallationBegin();
    verreciel.player.lookAt(0);
  }
  
  onInstallationComplete()
  {
    super.onInstallationComplete();
    this.port.disable();
  }
}
