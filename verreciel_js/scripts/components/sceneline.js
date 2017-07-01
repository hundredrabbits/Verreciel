class SceneLine extends Empty
{
  constructor(vertices, color = verreciel.white)
  {
    assertArgs(arguments, 1);
    super();
    this.updateGeometry(vertices, color);
  }
  
  updateGeometry(vertices, color)
  {
    assertArgs(arguments, 2);
    if (vertices.length < 2)
    {
      return;
    }
    if (vertices.length % 2 == 1)
    {
      return;
    }

    this.vertices = vertices;
    this.color = color;
  
    // TODO: THREEJS

    this.visible = true;
  }
  
  reset()
  {
    assertArgs(arguments, 0);
    // TODO: THREEJS
    this.visible = false;
  }
  
  updateColor(color)
  {
    assertArgs(arguments, 1);
    if (color.equals(this.color))
    {
      return;
    }
    this.updateGeometry(this.vertices, color);
  }
  
  updateVertices(vertices)
  {
    assertArgs(arguments, 1);
    this.updateGeometry(vertices, this.color);
  }
}
