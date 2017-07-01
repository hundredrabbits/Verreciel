class SceneNode extends THREE.LineSegments
{
  constructor()
  {
    assertArgs(arguments, 0);
    let material = new THREE.LineBasicMaterial({
      color: 0xffffff,
      vertexColors: THREE.VertexColors,
    });
    material.transparent = true;
    super(new THREE.Geometry(), material);
  }

  whenStart()
  {
    assertArgs(arguments, 0);
    for (let node of this.children)
    {
      node.whenStart();
    }
  }
  
  whenTime()
  {
    assertArgs(arguments, 0);
    for (let node of this.children)
    {
      node.whenTime();
    }
  }
  
  whenSecond()
  {
    assertArgs(arguments, 0);
    for (let node of this.children)
    {
      node.whenSecond();
    }
  }
  
  whenRenderer()
  {
    assertArgs(arguments, 0);
    for (let node of this.children)
    {
      node.whenRenderer();
    }
  }

  removeFromParentNode()
  {
    assertArgs(arguments, 0);
    if (this.parent != null)
    {
      this.parent.remove(this);
    }
  }

  convertPositionToNode(position, node)
  {
    assertArgs(arguments, 2);
    return new THREE.Vector3D(); // TODO: REMOVE
    // TODO: THREEJS
  }

  convertPositionFromNode(position, node)
  {
    assertArgs(arguments, 2);
    return new THREE.Vector3D(); // TODO: REMOVE
    // TODO: THREEJS
  }
}

