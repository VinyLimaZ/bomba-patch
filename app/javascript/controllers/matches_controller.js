// JS Controller for global methods and functions
import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {

  static targets = [ ]

  connect() {
    this.channel = consumer.disconnect()

    document.querySelectorAll('.match').forEach(match => {
      this.channel = consumer.subscriptions.create(
        {
          channel: "MatchChannel",
          match_id: match.getAttribute("data-match-id")
        }, {
        connected: this._cableConnected.bind(this),
        disconnected: this._cableDisconnected.bind(this),
        received: this._cableReceived.bind(this),
      })
    });
  }

  _cableConnected() {
    // Called when the subscription is ready for use on the server
  }

  _cableDisconnected() {
    // Called when the subscription has been terminated by the server
  }

  _cableReceived(data) {
    let matchElement = document.querySelector('[data-match-id="' + data.id + '"]')
    if (matchElement){
      let homeTeam = matchElement.querySelector('[data-team="home"]')
      let awayTeam = matchElement.querySelector('[data-team="away"]')
      homeTeam.innerHTML = data.score.home_team
      awayTeam.innerHTML = data.score.away_team
    }
  }

}
