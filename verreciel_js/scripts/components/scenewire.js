class SceneWire extends Empty
{
  constructor(host, endA = new THREE.Vector3(), endB = new THREE.Vector3())
  {
    // assertArgs(arguments, 3);
    super();
    this.isEnabled = true;
    this.isUploading = false;
    this.host = host;
    this.endA = endA;
    this.endB = endB;

    this.vertex1 = new THREE.Vector3(this.endB.x * 0.2, this.endB.y * 0.2, this.endB.z * 0.2);
    this.vertex2 = new THREE.Vector3(this.endB.x * 0.4, this.endB.y * 0.4, this.endB.z * 0.4);
    this.vertex3 = new THREE.Vector3(this.endB.x * 0.6, this.endB.y * 0.6, this.endB.z * 0.6);
    this.vertex4 = new THREE.Vector3(this.endB.x * 0.8, this.endB.y * 0.8, this.endB.z * 0.8);
    
    this.segment1 = new SceneLine( [this.endA, this.vertex1], verreciel.cyan);
    this.segment2 = new SceneLine( [this.vertex1, this.vertex2], verreciel.white);
    this.segment3 = new SceneLine( [this.vertex2, this.vertex3], verreciel.white);
    this.segment4 = new SceneLine( [this.vertex3, this.vertex4], verreciel.white);
    this.segment5 = new SceneLine( [this.vertex4, this.endB], verreciel.red);

    this.segment1.element.frustumCulled = false;
    this.segment2.element.frustumCulled = false;
    this.segment3.element.frustumCulled = false;
    this.segment4.element.frustumCulled = false;
    this.segment5.element.frustumCulled = false;

    this.add(this.segment1);
    this.add(this.segment2);
    this.add(this.segment3);
    this.add(this.segment4);
    this.add(this.segment5);
  }
  
  whenRenderer()
  {
    // assertArgs(arguments, 0);
    super.whenRenderer();
    
    if (this.isEnabled == false || this.endB == null)
    {
      return;
    }
    if (this.endA.x == this.endB.x && this.endA.y == this.endB.y && this.endA.z == this.endB.z)
    {
      return;
    }
    
    this.updateSegments();
  }
  
  updateEnds(endA = new THREE.Vector3(), endB = new THREE.Vector3())
  {
    // assertArgs(arguments, 2);
    this.endA = endA;
    this.endB = endB;
    
    this.vertex1 = new THREE.Vector3(this.endB.x * 0.2, this.endB.y * 0.2, this.endB.z * 0.2);
    this.vertex2 = new THREE.Vector3(this.endB.x * 0.4, this.endB.y * 0.4, this.endB.z * 0.4);
    this.vertex3 = new THREE.Vector3(this.endB.x * 0.6, this.endB.y * 0.6, this.endB.z * 0.6);
    this.vertex4 = new THREE.Vector3(this.endB.x * 0.8, this.endB.y * 0.8, this.endB.z * 0.8);
    
    this.updateSegments();
  }

  updateSegments()
  {
    this.vertex1.x = this.endB.x * 0.2 + Math.cos((verreciel.game.time + this.vertex1.x + this.vertex1.y + this.vertex1.z)/20) * 0.05;
    this.vertex2.x = this.endB.x * 0.4 + Math.cos((verreciel.game.time + this.vertex2.x + this.vertex2.y + this.vertex2.z)/20) * 0.08;
    this.vertex3.x = this.endB.x * 0.6 + Math.cos((verreciel.game.time + this.vertex3.x + this.vertex3.y + this.vertex3.z)/20) * 0.08;
    this.vertex4.x = this.endB.x * 0.8 + Math.cos((verreciel.game.time + this.vertex4.x + this.vertex4.y + this.vertex4.z)/20) * 0.05;

    this.vertex1.y = this.endB.y * 0.2 + Math.sin((verreciel.game.time + this.vertex1.x + this.vertex1.y + this.vertex1.z)/20) * 0.05;
    this.vertex2.y = this.endB.y * 0.4 + Math.sin((verreciel.game.time + this.vertex2.x + this.vertex2.y + this.vertex2.z)/20) * 0.08;
    this.vertex3.y = this.endB.y * 0.6 + Math.sin((verreciel.game.time + this.vertex3.x + this.vertex3.y + this.vertex3.z)/20) * 0.08;
    this.vertex4.y = this.endB.y * 0.8 + Math.sin((verreciel.game.time + this.vertex4.x + this.vertex4.y + this.vertex4.z)/20) * 0.05;
    
    this.segment1.updateVertices([this.endA, this.vertex1]);
    this.segment2.updateVertices([this.vertex1, this.vertex2]);
    this.segment3.updateVertices([this.vertex2, this.vertex3]);
    this.segment4.updateVertices([this.vertex3, this.vertex4]);
    this.segment5.updateVertices([this.vertex4, this.endB]);
  }
  
  enable()
  {
    // assertArgs(arguments, 0);
    this.isEnabled = true;
    this.show();
  }
  
  disable()
  {
    // assertArgs(arguments, 0);
    this.isEnabled = false;
    this.hide();
  }
  
  isCompatible()
  {
    // assertArgs(arguments, 0);
    return true;
  }

  updateChildrenColors(color)
  {
    // NOPE.
  }
}
