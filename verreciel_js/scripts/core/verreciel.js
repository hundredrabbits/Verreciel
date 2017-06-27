class Verreciel
{
  constructor()
  {
    this.element = document.createElement("verreciel");
    document.body.appendChild(this.element);
    this.game = new Game();
    this.music = new Music();
    this.demo = new Demo();
  }

  whenStart()
  {
    console.info("Starting Verreciel");

    document.addEventListener( "mousemove", this.mouseMove.bind(this), false );
    document.addEventListener( "mousedown", this.mouseDown.bind(this), false );
    document.addEventListener( "mouseup", this.mouseUp.bind(this), false );
    window.addEventListener( "resize", this.windowResize.bind(this), false );

    this.demo.whenStart();
    this.demo.resize(window.innerWidth, window.innerHeight);
  }

  mouseDown(e)
  {
    
  }

  mouseMove(e)
  {
    
  }

  mouseUp(e)
  {
    
  }

  windowResize()
  {
    this.demo.resize(window.innerWidth, window.innerHeight);
  }
}
