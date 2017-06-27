class SceneNode extends THREE.LineSegments
{
  constructor()
  {
    super(null, SceneNode.material);
  }

  whenStart()
  {
    for (node of this.children)
    {
      node.whenStart();
    }
  }
  
  whenTime()
  {
    for (node of this.children)
    {
      node.whenTime();
    }
  }
  
  whenSecond()
  {
    for (node of this.children)
    {
      node.whenSecond();
    }
  }
  
  whenRenderer()
  {
    for (node of this.children)
    {
      node.whenRenderer();
    }
  }
}

SceneNode.material = new THREE.LineBasicMaterial( { color: 0xffffff, vertexColors: THREE.VertexColors } );
