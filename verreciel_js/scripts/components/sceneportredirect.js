class ScenePortRedirect extends ScenePort
{
  removeEvent()
  {
    let redirectedHost = verreciel.console.port.origin.host;
    if (redirectedHost instanceof Cargo)
    {
      redirectedHost.removeItem(this.event);
      this.disable();
    }
  }
  
  disable()
  {
    this.isEnabled = false;
    this.disconnect();
    this.trigger.disable();
  }
  
  whenRenderer()
  {
    super.whenRenderer();
    
    if (this.event != null)
    {
      this.sprite_input.updateChildrenColors(verreciel.clear);
    }
  }
  
  disconnect()
  {
    if (this.connection == null)
    {
      return
    }
    
    let stored_connection = this.connection;
    let stored_connection_host = this.connection.host;
    
    this.connection.origin = null;
    this.connection = null;
    
    if (stored_connection != null)
    {
      stored_connection.onDisconnect();
    }
    if (stored_connection_host != null)
    {
      stored_connection_host.onDisconnect();
    }
    this.host.onDisconnect();
    
    this.wire.disable();
  }
}
