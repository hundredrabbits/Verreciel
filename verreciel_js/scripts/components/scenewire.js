class SceneWire extends Empty
{
  constructor(host, endA = new THREE.Vector3(), endB = new THREE.Vector3())
  {
    assertArgs(arguments, 3);
    super();
    
    this.segment1 = new SceneLine([], verreciel.white);
    this.segment2 = new SceneLine([], verreciel.white);
    this.segment3 = new SceneLine([], verreciel.white);
    this.segment4 = new SceneLine([], verreciel.white);
    this.segment5 = new SceneLine([], verreciel.white);

    this.segment1.meat.frustumCulled = false;
    this.segment2.meat.frustumCulled = false;
    this.segment3.meat.frustumCulled = false;
    this.segment4.meat.frustumCulled = false;
    this.segment5.meat.frustumCulled = false;
    
    this.isEnabled = true;
    this.isActive = false;
    this.isUploading = false;

    this.host = host;
    this.endA = endA;
    this.endB = endB;
    
    this.add(this.segment1);
    this.add(this.segment2);
    this.add(this.segment3);
    this.add(this.segment4);
    this.add(this.segment5);
    
    this.color = new THREE.Vector4(1, 1, 0, 1);
    
    this.vertex1 = new THREE.Vector3(this.endB.x * 0.2, this.endB.y * 0.2, this.endB.z * 0.2);
    this.vertex2 = new THREE.Vector3(this.endB.x * 0.4, this.endB.y * 0.4, this.endB.z * 0.4);
    this.vertex3 = new THREE.Vector3(this.endB.x * 0.6, this.endB.y * 0.6, this.endB.z * 0.6);
    this.vertex4 = new THREE.Vector3(this.endB.x * 0.8, this.endB.y * 0.8, this.endB.z * 0.8);
    
    this.segment1.updateGeometry( [this.endA, this.vertex1], verreciel.cyan);
    this.segment2.updateGeometry( [this.vertex1, this.vertex2], verreciel.white);
    this.segment3.updateGeometry( [this.vertex2, this.vertex3], verreciel.white);
    this.segment4.updateGeometry( [this.vertex3, this.vertex4], verreciel.white);
    this.segment5.updateGeometry( [this.vertex4, this.endB], verreciel.red);
  }
  
  whenRenderer()
  {
    assertArgs(arguments, 0);
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
    assertArgs(arguments, 2);
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
    this.vertex1.y = this.endB.y * 0.2 + Math.sin((verreciel.game.time + this.vertex1.x + this.vertex1.y + this.vertex1.z)/20) * 0.05;
    this.vertex2.y = this.endB.y * 0.4 + Math.sin((verreciel.game.time + this.vertex2.x + this.vertex2.y + this.vertex2.z)/20) * 0.08;
    this.vertex3.y = this.endB.y * 0.6 + Math.sin((verreciel.game.time + this.vertex3.x + this.vertex3.y + this.vertex3.z)/20) * 0.08;
    this.vertex4.y = this.endB.y * 0.8 + Math.sin((verreciel.game.time + this.vertex4.x + this.vertex4.y + this.vertex4.z)/20) * 0.05;
    
    this.segment1.updateGeometry( [this.endA, this.vertex1], this.segment1.color);
    this.segment2.updateGeometry( [this.vertex1, this.vertex2], this.segment2.color);
    this.segment3.updateGeometry( [this.vertex2, this.vertex3], this.segment3.color);
    this.segment4.updateGeometry( [this.vertex3, this.vertex4], this.segment4.color);
    this.segment5.updateGeometry( [this.vertex4, this.endB], this.segment5.color);
  }
  
  enable()
  {
    assertArgs(arguments, 0);
    this.isEnabled = true;
    this.show();
  }
  
  disable()
  {
    assertArgs(arguments, 0);
    this.isEnabled = false;
    this.hide();
  }
  
  isCompatible()
  {
    assertArgs(arguments, 0);
    return true;
  }
  
  updateColor(color)
  {
    assertArgs(arguments, 1);
    
  }
}
