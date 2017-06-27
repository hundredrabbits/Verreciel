class Verreciel
{
  constructor() {
    this.element = document.createElement("verreciel");
    this.game = new Game();
    this.music = new Music();
    this.demo = new Demo();
    this.started = false;
  }

  install()
  {
    document.body.appendChild(this.element);
    this.demo.install();
  }

  start()
  {
    console.info("Starting Verreciel");

    document.addEventListener( "mousemove", this.mouse_move.bind(this), false );
    document.addEventListener( "mousedown", this.mouse_down.bind(this), false );
    document.addEventListener( "mouseup", this.mouse_up.bind(this), false );
    window.addEventListener( "resize", this.window_resize.bind(this), false );

    this.demo.start();
    this.demo.resize(window.innerWidth, window.innerHeight);
    this.started = true;
  }

  mouse_down(e)
  {
    
  }

  mouse_move(e)
  {
    
  }

  mouse_up(e)
  {
    
  }

  window_resize()
  {
    this.demo.resize(window.innerWidth, window.innerHeight);
  }
}
