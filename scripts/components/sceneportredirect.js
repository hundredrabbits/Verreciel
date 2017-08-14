//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class ScenePortRedirect extends ScenePort {
  removeEvent() {
    // assertArgs(arguments, 0);
    let redirectedHost = verreciel.console.port.origin.host;
    if (redirectedHost instanceof Cargo) {
      redirectedHost.removeItem(this.event);
      this.disable();
    }
  }
  /*
  disable()
  {
    // assertArgs(arguments, 0);
    this.isEnabled = false;
    this.disconnect();
    this.trigger.disable();
  }
  */
  whenRenderer() {
    // assertArgs(arguments, 0);
    super.whenRenderer();
  }

  disconnect() {
    // assertArgs(arguments, 0);
    if (this.connection == null) {
      return;
    }

    let stored_connection = this.connection;
    let stored_connection_host = this.connection.host;

    this.connection.origin = null;
    this.connection = null;

    if (stored_connection != null) {
      stored_connection.onDisconnect();
    }
    if (stored_connection_host != null) {
      stored_connection_host.onDisconnect();
    }
    this.host.onDisconnect();

    this.wire.disable();
  }
}
