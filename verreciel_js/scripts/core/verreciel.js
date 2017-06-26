function Verreciel()
{
  this.element = document.createElement("verreciel");

  this.game = new Game();
  this.music = new Music();
  this.demo = new Demo();
  
  this.started = false;

  this.install = function()
  {
    document.body.appendChild(this.element);
    this.demo.install();
  }

  this.start = function()
  {
    console.info("Starting Verreciel");

    document.addEventListener( 'mousemove', this.onDocumentMouseMove.bind(this), false );
    document.addEventListener( 'mousedown', this.onDocumentMouseDown.bind(this), false );
    document.addEventListener( 'mouseup', this.onDocumentMouseUp.bind(this), false );
    window.addEventListener( 'resize', this.onWindowResize.bind(this), false );

    this.demo.start();
    this.demo.resize(window.innerWidth, window.innerHeight);
    this.started = true;
  }

  this.onDocumentMouseDown = function(event)
  {
    
  }

  this.onDocumentMouseMove = function(event)
  {
    
  }

  this.onDocumentMouseUp = function(event)
  {
    
  }

  this.onWindowResize = function()
  {
    this.demo.resize(window.innerWidth, window.innerHeight);
  }
}
