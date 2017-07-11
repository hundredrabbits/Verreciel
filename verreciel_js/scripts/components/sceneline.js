class SceneLine extends Empty
{
  constructor(vertices, color = verreciel.white)
  {
    // assertArgs(arguments, 1);
    super(Methods.lineArt);
    this.updateGeometry(vertices, color);
  }
  
  updateGeometry(vertices, color)
  {
    // assertArgs(arguments, 2);
    if (vertices.indexOf(null) != -1)
    {
      throw "BAD GEOMETRY";
    }
    if (vertices.length < 2)
    {
      return;
    }
    if (vertices.length % 2 == 1)
    {
      return;
    }

    this.vertices = vertices;
    this.geometry.vertices = vertices;
    this.geometry.verticesNeedUpdate = true;
    this.color = color;
  }
  
  reset()
  {
    // assertArgs(arguments, 0);
    this.vertices = [];
    this.geometry.vertices = [];
    this.geometry.verticesNeedUpdate = true;
  }
  
  updateColor(color)
  {
    // assertArgs(arguments, 1);
    if (color.equals(this.color))
    {
      return;
    }
    this.updateGeometry(this.vertices, color);
  }
  
  updateVertices(vertices)
  {
    // assertArgs(arguments, 1);
    this.updateGeometry(vertices, this.color);
  }
}
