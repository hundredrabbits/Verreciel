class SceneLine extends Empty
{
  constructor(vertices, color = verreciel.white)
  {
    super();
    this.update(vertices, color);
  }
  
  update(vertices, color)
  {
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
    // TODO: THREEJS
    this.visible = false;
  }
  
  updateColor(color)
  {
    if (color.equals(this.color))
    {
      return;
    }
    this.update(this.vertices, color);
  }
  
  updateVertices(vertices)
  {
    this.update(vertices, this.color);
  }
}
