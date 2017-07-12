class SceneDrawNode extends Empty
{
  constructor()
  {
    super();
    this.__color4 = new THREE.Vector4(1, 1, 1, 1);
  }

  get color()
  {
    return this.__color4;
  }
  
  set color(newColor)
  {
    if (this.__color4.equals(newColor))
    {
      return;
    }
    this.__color4.copy(newColor);
    this.material.color.r = this.__color4.x;
    this.material.color.g = this.__color4.y;
    this.material.color.b = this.__color4.z;
    this.updateMaterialOpacity();
  }

  makeElement()
  {
    
  }

  updateMaterialOpacity()
  {
    this.material.opacity = this.opacityFromTop * this.__color4.w;
  }

  whenInherit()
  {
    this.updateMaterialOpacity();
    super.whenInherit();
  }
}
