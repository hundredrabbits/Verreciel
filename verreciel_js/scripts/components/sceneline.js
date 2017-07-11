class SceneLine extends Empty
{
  constructor(vertices, color = verreciel.white)
  {
    // assertArgs(arguments, 1);
    super(Methods.lineArt);
    this.updateVertices(vertices);
    this.color = color;
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
    this.color = color;
  }
}
