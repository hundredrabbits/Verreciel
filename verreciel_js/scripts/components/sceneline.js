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

    let oldLength = this.vertices == null ? 0 : this.vertices.length;
    this.vertices = vertices;
    while (this.vertices.length < oldLength)
    {
      this.vertices.push(SceneLine.DUD_VERT);
    }

    if (this.vertices.length > oldLength && oldLength != 0) // oldLength of zero is special case
    {
      this.geometry.dispose();
      this.geometry = new THREE.Geometry();
      this.meat.geometry = this.geometry;
      // console.log("EXPAND:", oldLength, "-->", this.vertices.length);
    }

    this.geometry.vertices = vertices;
    this.geometry.verticesNeedUpdate = true;
    this.geometry.computeBoundingSphere();
  }
}

SceneLine.DUD_VERT = new THREE.Vector3();
