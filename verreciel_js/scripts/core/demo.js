class Demo extends THREE.Group
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();
  }

  update()
  {
    assertArgs(arguments, 0);
    var time = Date.now() * 0.0001;
    for ( var i = 0; i < this.children.length; i ++ ) {
      var object = this.children[ i ];
      if ( object instanceof THREE.Line ) {
        object.rotation.y = time * (i + 1);
      }
    }
  }

  whenStart()
  {
    assertArgs(arguments, 0);
    var vertex1;
    var vertex2;
    var material;
    
    var geometry = new THREE.Geometry();
    for ( var i = 0; i < 500; i ++ ) {

      var vertex1 = new THREE.Vector3(Math.random() * 2 - 1, Math.random() * 2 - 1, Math.random() * 2 - 1);
      vertex1.normalize();
      vertex1.multiplyScalar( 450 );

      var vertex2 = new THREE.Vector3(Math.random() * 2 - 1, Math.random() * 2 - 1, Math.random() * 2 - 1);
      vertex2.normalize();
      vertex2.multiplyScalar( 450 );

      geometry.vertices.push( vertex1 );
      geometry.vertices.push( vertex2 );
    }

    for( i = 0; i < 3; i++ ) {
      var line = new Empty().meat;
      line.geometry = geometry;
      line.scale.x = line.scale.y = line.scale.z = 0.125 * (i + 1);
      line.rotation.y = Math.random() * Math.PI;
      line.rotation.x = Math.random() * Math.PI;
      line.updateMatrix();
      this.add( line );
    }
  }
}
