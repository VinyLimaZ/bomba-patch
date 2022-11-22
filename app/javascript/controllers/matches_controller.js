// JS Controller for global methods and functions
import { Controller } from "stimulus"

export default class extends Controller {

  static targets = [  ]

  connect() {
    console.log("aqui")
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