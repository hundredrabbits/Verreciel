class SceneNode extends THREE.LineSegments
{
  constructor()
  {
    super(new THREE.Geometry(), SceneNode.material);
  }

  whenStart()
  {
    for (let node of this.children)
    {
      node.whenStart();
    }
  }
  
  whenTime()
  {
    for (let node of this.children)
    {
      node.whenTime();
    }
  }
  
  whenSecond()
  {
    for (let node of this.children)
    {
      node.whenSecond();
    }
  }
  
  whenRenderer()
  {
    for (let node of this.children)
    {
      node.whenRenderer();
    }
  }

  removeFromParentNode()
  {
    if (this.parent != null)
    {
      this.parent.remove(this);
    }
  }

  convertPositionToNode(posiiton, node)
  {
    return new THREE.Vector3D(); // TODO: REMOVE
    // TODO: THREEJS
  }

  convertPositionFromNode(posiiton, node)
  {
    return new THREE.Vector3D(); // TODO: REMOVE
    // TODO: THREEJS
  }
}

SceneNode.material = new THREE.LineBasicMaterial( { color: 0xffffff, vertexColors: THREE.VertexColors } );
