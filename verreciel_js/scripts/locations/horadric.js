class LocationHoradric extends Location
{
  constructor(name, system, at, mapRequirement = null)
  {
    // assertArgs(arguments, 3);
    super( name,system, at, new IconHoradric(), new StructureHoradric());
    
    this.details = "unknown";
    this.mapRequirement = mapRequirement;
    this.recipeValid = null;
    this.combinationPercentage = 0;
  }
  
  panel()
  {
    // assertArgs(arguments, 0);
    let newPanel = new Panel();
    
    this.inPort1 = new ScenePortSlot(this, Alignment.center, false, "In");
    this.inPort2 = new ScenePortSlot(this, Alignment.center, false, "In");
    
    this.inPort1.label.position.set(0,0.5,0);
    this.inPort2.label.position.set(0,0.5,0);
    
    this.inPort1.enable();
    this.inPort2.enable();
    
    this.inPort1.position.set(0.6,0.6,0);
    this.inPort2.position.set(-0.6,0.6,0);
    
    this.outPort = new ScenePortSlot(this, Alignment.center, false, "");
    this.outPort.position.set(0,-0.8,0);
    this.outPort.label.position.set(0,-0.4,0);
    this.outPort.label.updateText("Out");
    
    newPanel.add(this.inPort1);
    newPanel.add(this.inPort2);
    newPanel.add(this.outPort);
    
    newPanel.add(new SceneLine([new THREE.Vector3(0.6,0.6 - 0.125,0), new THREE.Vector3(0.6,0.3 - 0.125,0)], verreciel.grey));
    newPanel.add(new SceneLine([new THREE.Vector3(-0.6,0.6 - 0.125,0), new THREE.Vector3(-0.6,0.3 - 0.125,0)], verreciel.grey));
    
    newPanel.add(new SceneLine([new THREE.Vector3(0,-0.2 - 0.125,0), new THREE.Vector3(0.6,0.3 - 0.125,0)], verreciel.grey));
    newPanel.add(new SceneLine([new THREE.Vector3(0,-0.2 - 0.125,0), new THREE.Vector3(-0.6,0.3 - 0.125,0)], verreciel.grey));
    
    newPanel.add(new SceneLine([new THREE.Vector3(0,-0.2 - 0.125,0), new THREE.Vector3(0,-0.8 + 0.125,0)], verreciel.grey));
    
    this.storage = [this.inPort1,this.inPort2,this.outPort];
    
    return newPanel;
  }
  
  dockUpdate()
  {
    // assertArgs(arguments, 0);
    if (this.inPort1.isEnabled == true && this.inPort2.isEnabled == true)
    {

    }
    
    if (this.combinationPercentage > 0)
    {
      this.structure.blink();
    }
  }
  
  onUploadComplete()
  {
    // assertArgs(arguments, 0);
    this.verifyRecipes();
  }
  
  verifyRecipes()
  {
    // assertArgs(arguments, 0);
    var ingredients = [];
    
    if (this.inPort1.event != null)
    {
      ingredients.push(this.inPort1.event);
    }
    if (this.inPort2.event != null)
    {
      ingredients.push(this.inPort2.event);
    }
    
    for (let recipe of verreciel.recipes.horadric)
    {
      if (recipe.isValid(ingredients) == true)
      {
        this.recipeValid = recipe;
        this.combine(recipe);
        break;
      }
      else
      {
        this.recipeValid = null;
      }
    }
    
    this.refresh();
  }
  
  refresh()
  {
    // assertArgs(arguments, 0);
    if (this.outPort.hasEvent() == true)
    {
      this.inPort1.disable();
      this.inPort2.disable();
      this.outPort.enable();
    }
    else
    {
      this.inPort1.enable();
      this.inPort2.enable();
      this.outPort.disable();
    }
    
    if (this.recipeValid != null)
    {
      this.inPort1.disable();
      this.inPort2.disable();
    }
    
    if (this.recipeValid != null)
    {
      this.inPort1.label.updateText("IN", verreciel.white);
      this.inPort2.label.updateText("IN", verreciel.white);
      this.outPort.label.updateText(this.recipeValid.result.name, verreciel.white);
    }
    else if (this.inPort1.event != null && this.inPort2.event != null)
    {
      this.inPort1.label.updateText("IN", verreciel.grey);
      this.inPort2.label.updateText("IN", verreciel.grey);
      this.outPort.label.updateText("error", verreciel.red);
    }
    else
    {
      if (this.inPort1.event != null)
      {
        this.inPort1.label.updateText("IN", verreciel.white);
      }
      else
      {
        this.inPort1.label.updateText("IN", verreciel.grey);
      }
      if (this.inPort2.event != null)
      {
        this.inPort2.label.updateText("IN", verreciel.white);
      }
      else
      {
        this.inPort2.label.updateText("IN", verreciel.grey);
      }
      this.outPort.label.updateText("Out", verreciel.grey);
    }
  }
  
  // MARK: Combinatrix
  
  combine(recipe)
  {
    // assertArgs(arguments, 1);
    this.inPort1.disable();
    this.inPort2.disable();
    this.inPort1.label.updateColor(verreciel.cyan);
    this.inPort2.label.updateColor(verreciel.cyan);
    
    this.combinationRecipe = recipe;
    this.combineProgress();
    verreciel.music.playEffect("beep1");
  }
  
  combineProgress()
  {
    // assertArgs(arguments, 0);
    this.combinationPercentage += Math.random() * 2;
    this.combinationPercentage += 1; // Faster!
    
    if (this.combinationPercentage > 100)
    {
      this.onCombinationComplete();
      return;
    }
    else
    {
      delay(0.05, this.combineProgress.bind(this));
    }
    this.outPort.label.updateText(this.combinationPercentage.toFixed(0) + "%", verreciel.grey);
  }
  
  onCombinationComplete()
  {
    // assertArgs(arguments, 0);
    this.inPort1.removeEvent();
    this.inPort2.removeEvent();
    this.inPort1.label.updateColor(verreciel.grey);
    this.inPort2.label.updateColor(verreciel.grey);
    
    this.outPort.addEvent(this.combinationRecipe.result);
    
    // this.structure.show();
    
    this.combinationPercentage = 0;
    
    this.refresh();
    verreciel.music.playEffect("beep2");
  }
}

class IconHoradric extends Icon
{
  constructor()
  {
    // assertArgs(arguments, 0);
    super();
    
    this.mesh.add(new SceneLine([
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(this.size,0,0), 
      new THREE.Vector3(-this.size,0,0),  
      new THREE.Vector3(0,-this.size,0), 
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(-this.size,0,0), 
      new THREE.Vector3(this.size,0,0),  
      new THREE.Vector3(0,-this.size,0), 
      new THREE.Vector3(-this.size,0,0),  
      new THREE.Vector3(this.size,0,0), 
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(0,-this.size,0),
    ], this.color));
  }
}

class StructureHoradric extends Structure
{
  constructor()
  {
    // assertArgs(arguments, 0);
    super();
    
    this.root.position.set(0,0,0);

    let nodes = Math.floor(Math.random() * 10) + 4;
    let radius = 5;
    
    let cube1 = new Cube(radius, verreciel.grey);
    this.root.add(cube1);
    // cube1.line9.updateColor(verreciel.clear);
    // cube1.line10.updateColor(verreciel.clear);
    // cube1.line11.updateColor(verreciel.clear);
    // cube1.line12.updateColor(verreciel.clear);
    
    let cube2 = new Cube(radius, verreciel.grey);
    this.root.add(cube2);
    // cube2.line9.updateColor(verreciel.clear);
    // cube2.line10.updateColor(verreciel.clear);
    // cube2.line11.updateColor(verreciel.clear);
    // cube2.line12.updateColor(verreciel.clear);
    
    let cube3 = new Cube(radius, verreciel.grey);
    this.root.add(cube3);
    // cube3.line9.updateColor(verreciel.clear);
    // cube3.line10.updateColor(verreciel.clear);
    // cube3.line11.updateColor(verreciel.clear);
    // cube3.line12.updateColor(verreciel.clear);
    
    let cube4 = new Cube(radius, verreciel.grey);
    this.root.add(cube4);
    // cube4.line9.updateColor(verreciel.clear);
    // cube4.line10.updateColor(verreciel.clear);
    // cube4.line11.updateColor(verreciel.clear);
    // cube4.line12.updateColor(verreciel.clear);
    
    let cube5 = new Cube(radius, verreciel.grey);
    this.root.add(cube5);
    // cube5.line9.updateColor(verreciel.clear);
    // cube5.line10.updateColor(verreciel.clear);
    // cube5.line11.updateColor(verreciel.clear);
    // cube5.line12.updateColor(verreciel.clear);
    
    let cube6 = new Cube(radius, verreciel.grey);
    this.root.add(cube6);
    // cube6.line9.updateColor(verreciel.clear);
    // cube6.line10.updateColor(verreciel.clear);
    // cube6.line11.updateColor(verreciel.clear);
    // cube6.line12.updateColor(verreciel.clear);
  }
  
  onUndock()
  {
    // assertArgs(arguments, 0);
    super.onUndock();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 3;
    
    this.root.children[0].rotation.y = degToRad(0);
    this.root.children[1].rotation.y = degToRad(0);
    
    this.root.children[2].rotation.z = degToRad(0);
    this.root.children[3].rotation.z = degToRad(0);
    
    this.root.children[4].rotation.x = degToRad(0);
    this.root.children[5].rotation.x = degToRad(0);
    
    this.rotation.y = degToRad(0);
    
    verreciel.animator.commit();
  }
  
  onDock()
  {
    // assertArgs(arguments, 0);
    super.onDock();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 3;
    
    this.root.children[0].rotation.y =  degToRad(22.5);
    this.root.children[1].rotation.y = -degToRad(22.5);
    
    this.root.children[2].rotation.z =  degToRad(45);
    this.root.children[3].rotation.z = -degToRad(45);
    
    this.root.children[4].rotation.x =  degToRad(90);
    this.root.children[5].rotation.x = -degToRad(90);
    
    this.rotation.y = degToRad(90);
    
    verreciel.animator.commit();
  }
}
