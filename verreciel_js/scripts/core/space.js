class Space extends Empty
{
  constructor()
  {
    super();
    
    console.log("^ Space | Init");
    
    this.targetSpaceColor = [0,0,0];
    this.currentSpaceColor = [0,0,0];
    this.stars_color = verreciel.white;

    this.lastStarAddedTime = 0;

    this.structuresRoot = new Empty();
    this.starsRoot = new Empty();
    this.add(this.structuresRoot);
    this.add(this.starsRoot);
    
    this.starsRoot.position.set(0,40,0);
  }
  
  whenStart()
  {
    super.whenStart()
    console.log("+ Space | Start");
  }
  
  // Space Color
  
  onSystemEnter(system)
  {
    verreciel.capsule.system = system;
    
    switch (system)
    {
      case Systems.valen:
        this.targetSpaceColor = [0.2,0.2,0.2];
        this.stars_color = white;
        verreciel.music.playAmbience("ambience-2");
        break;
      case Systems.senni:
        this.targetSpaceColor = [0.0,0.0,0.0];
        this.stars_color = true_cyan;
        verreciel.music.playAmbience("ambience-3");
        break;
      case Systems.usul:
        this.targetSpaceColor = [0.2,0.0,0.0];
        this.stars_color = true_white;
        verreciel.music.playAmbience("ambience-4");
        break;
      case Systems.close:
        this.targetSpaceColor = [0.6,0.6,0.6];
        this.stars_color = black;
        verreciel.music.playAmbience("ambience-5");
        break;
      default:
        this.targetSpaceColor = [0.0,0.0,0.0];
        this.stars_color = white;
        verreciel.music.playAmbience("ambience-1");
        break;
    }
    
    if (player.isEjected == true)
    {
      this.targetSpaceColor = [0,0,0];
    }
    else if (capsule.closestStar().isComplete == true)
    {
      this.targetSpaceColor = [44 / 255, 73/255, 65/255];
    }
  }
  
  // Instances
  
  startInstance(location)
  {
    this.structuresRoot.add(location.structure);
  }
  
  whenTime()
  {
    super.whenTime();
    
    if (verreciel.capsule.isDockedAtLocation(verreciel.universe.close) == true)
    {
      verreciel.journey.distance += 3;
    }
    
    if (this.starsRoot.children.length < 30 && verreciel.journey.distance > this.lastStarAddedTime + 20)
    {
      this.starsRoot.add(new StarCluster());
      this.lastStarAddedTime = verreciel.journey.distance;
    }
    
    // Background
    
    if (this.currentSpaceColor[0] < this.targetSpaceColor[0]) { this.currentSpaceColor[0] += 0.01; }
    if (this.currentSpaceColor[0] > this.targetSpaceColor[0]) { this.currentSpaceColor[0] -= 0.01; }
    if (this.currentSpaceColor[1] < this.targetSpaceColor[1]) { this.currentSpaceColor[1] += 0.01; }
    if (this.currentSpaceColor[1] > this.targetSpaceColor[1]) { this.currentSpaceColor[1] -= 0.01; }
    if (this.currentSpaceColor[2] < this.targetSpaceColor[2]) { this.currentSpaceColor[2] += 0.01; }
    if (this.currentSpaceColor[2] > this.targetSpaceColor[2]) { this.currentSpaceColor[2] -= 0.01; }
    
    verreciel.scene.background = new THREE.Color(this.currentSpaceColor[0], this.currentSpaceColor[1], this.currentSpaceColor[2]);
    
    // Etc
    
    this.starsRoot.rotation.set(0, degToRad(verreciel.capsule.direction), 0);
  }
  
  star(position)
  {
    return new SceneLine([this.position, new THREE.Vector3(this.position.x, this.position.y + 1, this.position.z)], this.stars_color);
  }
}


class StarCluster extends Empty
{
  constructor()
  {
    super();
    
    this.starsPositions = [
      new THREE.Vector3(Math.floor(Math.random() * 40) - 20, 0, Math.floor(Math.random() * 40) - 20),
      new THREE.Vector3(Math.floor(Math.random() * 40) - 20, 0, Math.floor(Math.random() * 40) - 20),
      new THREE.Vector3(Math.floor(Math.random() * 40) - 20, 0, Math.floor(Math.random() * 40) - 20),
      new THREE.Vector3(Math.floor(Math.random() * 40) - 20, 0, Math.floor(Math.random() * 40) - 20),
      new THREE.Vector3(Math.floor(Math.random() * 40) - 20, 0, Math.floor(Math.random() * 40) - 20),
    ];

    this.mesh = new SceneLine([
      this.starsPositions[0], new THREE.Vector3(this.starsPositions[0].x, -1, this.starsPositions[0].z),
      this.starsPositions[1], new THREE.Vector3(this.starsPositions[1].x, -1, this.starsPositions[1].z),
      this.starsPositions[2], new THREE.Vector3(this.starsPositions[2].x, -1, this.starsPositions[2].z),
      this.starsPositions[3], new THREE.Vector3(this.starsPositions[3].x, -1, this.starsPositions[3].z),
      this.starsPositions[4], new THREE.Vector3(this.starsPositions[4].x, -1, this.starsPositions[4].z),
    ], verreciel.white);

    this.add(mesh);
  }
  
  whenRenderer()
  {
    var starSpeed = verreciel.thruster.actualSpeed;
    if (verreciel.capsule.isDocked == false && verreciel.capsule.dock != null)
    {
      starSpeed = 0.3;
    }
    else if (verreciel.capsule.isWarping == true)
    {
      starSpeed = 40;
    }
    else
    {
      starSpeed = verreciel.thruster.actualSpeed;
    }
    
    starSpeed *= 0.15;
    
    if (verreciel.capsule.isDockedAtLocation(verreciel.universe.close) == true)
    {
      starSpeed = 0.15;
    }
    
    this.mesh.updateVertices([
      this.starsPositions[0], new THREE.Vector3(this.starsPositions[0].x, starSpeed + 0.1, this.starsPositions[0].z),
      this.starsPositions[1], new THREE.Vector3(this.starsPositions[1].x, starSpeed + 0.1, this.starsPositions[1].z),
      this.starsPositions[2], new THREE.Vector3(this.starsPositions[2].x, starSpeed + 0.1, this.starsPositions[2].z),
      this.starsPositions[3], new THREE.Vector3(this.starsPositions[3].x, starSpeed + 0.1, this.starsPositions[3].z),
      this.starsPositions[4], new THREE.Vector3(this.starsPositions[4].x, starSpeed + 0.1, this.starsPositions[4].z),
    ])
    
    this.position.y -= starSpeed;
    
    if (this.position.y < -80)
    {
      this.removeFromParentNode();
    }
  }
}