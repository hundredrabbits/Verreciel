class Demo
{
  constructor()
  {
    this.camera = new THREE.PerspectiveCamera( 80, 1, 1, 3000 );
    // this.camera.position.z = 1000;
    this.scene = new THREE.Scene();
    this.renderer = new THREE.WebGLRenderer( { antialias: true } );
    this.renderer.setPixelRatio( window.devicePixelRatio );
    this.renderer.setSize( 0, 0 );
  }

  resize(width, height)
  {

    this.camera.aspect = width / height;
    this.camera.updateProjectionMatrix();

    this.renderer.setSize( width, height );

  }

  animate()
  {
    requestAnimationFrame( this.animate.bind(this) );
    this.render();
  }

  update()
  {
    var time = Date.now() * 0.0001;

    // this.camera.position.y = Math.sin(time * 7) * 1000;
    // this.camera.lookAt( this.scene.position );

    for ( var i = 0; i < this.scene.children.length; i ++ ) {
      var object = this.scene.children[ i ];
      if ( object instanceof THREE.Line ) {
        object.rotation.y = time * (i + 1);
      }

    }

    setTimeout(this.update.bind(this), 20);
  }

  render()
  {
    this.renderer.render( this.scene, this.camera );
  }
  
  whenStart()
  {
    var vertex1;
    var vertex2;
    var material;
    
    var geometry = new THREE.Geometry();
    for ( var i = 0; i < 500; i ++ ) {

      var vertex1 = new THREE.Vector3(Math.random() * 2 - 1, Math.random() * 2 - 1, Math.random() * 2 - 1);
      vertex1.normalize();
      vertex1.multiplyScalar( 450 );

      var vertex2 = new THREE.Vector3();
      vertex2.x = vertex1.y;
      vertex2.y = vertex1.z;
      vertex2.z = vertex1.x;

      geometry.vertices.push( vertex1 );
      geometry.vertices.push( vertex2 );

      var color = new THREE.Color( Math.random(), Math.random(), Math.random() );

      geometry.colors.push(color);
      geometry.colors.push(color);
    }

    for( i = 0; i < 3; i++ ) {

      // material = new THREE.LineBasicMaterial( { color: 0xffffff, vertexColors: THREE.VertexColors } );

      var line = new Empty();
      line.geometry = geometry;
      line.scale.x = line.scale.y = line.scale.z = 0.125 * (i + 1);
      line.rotation.y = Math.random() * Math.PI;
      line.updateMatrix();
      this.scene.add( line );

    }
    verreciel.element.appendChild( this.renderer.domElement );

    this.update();
    this.animate();
  }
}
