class SceneNode
{
  constructor()
  {
    assertArgs(arguments, 0);
    this.material = new THREE.LineBasicMaterial({ color: 0xffffff });
    this.material.transparent = true;
    this.children = [];
    this.geometry = new THREE.Geometry();
    this.meat = new THREE.LineSegments(this.geometry, this.material);
    this.meat.rotation.order = "YXZ";

    var opacityProperty = new SceneProperty(verreciel.sceneTransaction, this.material, "opacity");

    Object.defineProperties( this, {
      position:
      {
        enumerable: true,
        value: new ScenePropertyXYZ(verreciel.sceneTransaction, this.meat, "position")
      },
      rotation:
      {
        enumerable: true,
        value: new ScenePropertyXYZ(verreciel.sceneTransaction, this.meat, "rotation")
      },
      opacity:
      {
        enumerable: true,
        get: function() { return opacityProperty.value; },
        set: function(value) { opacityProperty.value = value; }
      }
    });
  }

  add(other)
  {
    this.meat.add(other.meat);
    this.children.push(other);
    other.parent = this;
  }

  remove(other)
  {
    this.meat.remove(other.meat);
    this.children.splice(this.children.indexOf(other), 1);
    other.parent = null;
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

