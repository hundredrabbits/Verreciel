class SceneNode
{
  constructor(method = null)
  {
    assertArgs(arguments, 0);
    this.id = SceneNode.ids++;
    this.method = method;
    this.children = [];
    var masterOpacity = 1;
    var masterVisible = true;
    
    if (this.method == null)
    {
      this.meat = new THREE.Group();
    }
    else
    {
      if (this.method == Methods.lineArt)
      {
        this.material = new THREE.LineBasicMaterial({ color: 0xffffff, transparent:true });
        
        this.geometry = new THREE.Geometry();
        this.geometry.dynamic = true;
        this.meat = new THREE.LineSegments(this.geometry, this.material);
      } else if (this.method == Methods.interactiveRegion)
      {
        this.material = new THREE.MeshBasicMaterial({ color: 0xffffff, visible: DEBUG_SHOW_TRIGGERS });
        this.geometry = new THREE.Geometry();
        this.geometry.dynamic = true;
        this.meat = new THREE.Mesh(this.geometry, this.material);
      }
      
      this.__color4 = new THREE.Vector4(1, 1, 1, 1);
      this.__opacityProperty = new AnimatedProperty(verreciel.animator, this.material, "opacity", false, true);
    }
    
    this.meat.node = this;
    this.meat.rotation.order = "YXZ";

    this.position = new AnimatedXYZ(verreciel.animator, this.meat, "position");
    this.rotation = new AnimatedXYZ(verreciel.animator, this.meat, "rotation", true);

    Object.defineProperties( this, {
      opacity:
      {
        get: function() { return masterOpacity; },
        set: function(value) {
          if (masterOpacity == value) { return; }
          masterOpacity = value;
          this.whenInherit();
        }
      },
      opacityFromTop:
      {
        get : function() { return masterOpacity * (this.parent == null ? 1 : this.parent.opacityFromTop); }
      },
      visible:
      {
        get: function() { return masterVisible; },
        set: function(value) {
          if (masterVisible == value) { return; }
          masterVisible = value;
          this.whenInherit();
        }
      },
      visibleFromTop:
      {
        get : function() { return masterVisible && (this.parent == null ? true : this.parent.visibleFromTop); }
      }
    });

    if (this.method != null)
    {
      Object.defineProperties( this, {
        color:
        {
          get: function() { return this.__color4; },
          set: function(newColor) {
            if (!this.material.visible) { return; }
            if (this.__color4.equals(newColor)) { return; }
            this.__color4.copy(newColor);
            this.material.color.r = this.__color4.x;
            this.material.color.g = this.__color4.y;
            this.material.color.b = this.__color4.z;
            this.whenInherit();
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
    other.meat.updateMatrixWorld(true);
    other.whenInherit();
    if (verreciel.phase == Phase.render)
    {
      other.whenRenderer();
    }
  }

  remove(other)
  {
    this.meat.remove(other.meat);
    this.children.splice(this.children.indexOf(other), 1);
    other.parent = null;
  }

  whenInherit()
  {
    if (this.method != null)
    {
      this.__opacityProperty.value = this.opacityFromTop * this.__color4.w;
      this.meat.visible = this.visibleFromTop && this.opacityFromTop > 0; // This might mess up fade-outs
    }
    else
    {
      this.meat.visible = this.visibleFromTop;
    }
    for (let node of this.children)
    {
      node.whenInherit();
    }
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

  whenUpdateMatrix()
  {
    assertArgs(arguments, 0);
    this.meat.updateMatrixWorld(false);
    for (let node of this.children)
    {
      node.whenUpdateMatrix();
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

  convertPositionToNode(xyz, node)
  {
    assertArgs(arguments, 2);
    let position = new THREE.Vector3(xyz.x, xyz.y, xyz.z);
    position.applyMatrix4(this.meat.matrixWorld).applyMatrix4(node.meat.matrixWorld.getInverse(node.meat.matrixWorld));
    return position;
  }

  convertPositionFromNode(xyz, node)
  {
    assertArgs(arguments, 2);
    let position = new THREE.Vector3(xyz.x, xyz.y, xyz.z);
    position.applyMatrix4(node.meat.matrixWorld).applyMatrix4(this.meat.matrixWorld.getInverse(this.meat.matrixWorld));
    return position;
  }
}

SceneNode.ids = 0;
