// JS Controller for global methods and functions
import { Controller } from "stimulus"

export default class extends Controller {

  static targets = [  ]

  connect() {
    this.channel = consumer.subscriptions.create({channel: "MatchChannel", match_id: this.matchTarget.getAttribute("data-match-id")}, {
      connected: this._cableConnected.bind(this),
      disconnected: this._cableDisconnected.bind(this),
      received: this._cableReceived.bind(this),
    })
  }

  _cableConnected() {
    // Called when the subscription is ready for use on the server
  }

  _cableDisconnected() {
    // Called when the subscription has been terminated by the server
  }

  _cableReceived(data) {
    console.log(data)
  }

}