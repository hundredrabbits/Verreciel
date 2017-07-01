class SceneNode
{
  constructor(graphical = false)
  {
    assertArgs(arguments, 0);
    this.graphical = graphical;
    this.children = [];
    var masterOpacity = 1;
    
    if (this.graphical)
    {
      console.log("GRAPHICAL");
      this.material = new THREE.LineBasicMaterial({ color: 0xffffff, transparent:true });
      this.geometry = new THREE.Geometry();
      this.meat = new THREE.LineSegments(this.geometry, this.material);
      var color4 = new THREE.Vector4(1, 1, 1, 1);
      var opacityProperty = new SceneProperty(verreciel.sceneTransaction, this.material, "opacity");
    }
    else
    {
      this.meat = new THREE.Group();
    }
    
    this.meat.rotation.order = "YXZ";

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
        get: function() { return masterOpacity; },
        set: function(value) {
          masterOpacity = value;
          if (this.graphical) { opacityProperty.value = this.opacityFromTop * color4.w; }
          for (let child of this.children)
          {
            child.opacity = child.opacity;
          }
        }
      },
      opacityFromTop:
      {
        enumerable: false,
        get : function() {
          var total = masterOpacity;
          if (this.parent != null)
          {
            total *= this.parent.opacityFromTop;
          }
          return total;
        }
      }
    });

    if (this.graphical)
    {
      Object.defineProperties( this, {
        color:
        {
          enumerable: true,
          get : function() { return color4; },
          set : function(newColor) {
            color4.copy(newColor);
            this.material.color.r = color4.x;
            this.material.color.g = color4.y;
            this.material.color.b = color4.z;
            opacityProperty.value = this.opacityFromTop * color4.w;
            for (let child of this.children)
            {
              child.opacity = child.opacity;
            }
          }
        }
      });
    }
  }

  add(other)
  {
    this.meat.add(other.meat);
    this.children.push(other);
    other.parent = this;
    this.opacity = this.opacity;
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

