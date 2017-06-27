class SceneNode extends THREE.LineSegments
{
  constructor()
  {
    super(undefined, SceneNode.material);
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
}

SceneNode.material = new THREE.LineBasicMaterial( { color: 0xffffff, vertexColors: THREE.VertexColors } );
