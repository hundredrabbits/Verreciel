class SceneLine extends Empty
{
  constructor(vertices, color = verreciel.white)
  {
    // assertArgs(arguments, 1);
    super(Methods.lineArt);
    this.updateVertices(vertices);
    this.color = color;
  }
  
  reset()
  {
    // assertArgs(arguments, 0);
    this.vertices = [];
    this.geometry.vertices = [];
    this.geometry.verticesNeedUpdate = true;
  }
  
  updateVertices(vertices)
  {
    // assertArgs(arguments, 1);
    if (vertices.indexOf(null) != -1)
    {
      throw "BAD GEOMETRY";
    }
    
    this.vertices = vertices;
    this.geometry.vertices = vertices;
    this.geometry.verticesNeedUpdate = true;
  }

  updateColor(color)
  {
    // assertArgs(arguments, 1);
    if (color.equals(this.color))
    {
      return;
    }
    this.color = color;
  }
}
