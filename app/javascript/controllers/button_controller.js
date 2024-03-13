import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button"
export default class extends Controller {
  playFlushSound(event) {
    event.preventDefault()

    const flushSound = document.getElementById("flushSound");
    flushSound.play();

    setTimeout(() => {
      event.target.closest("form").submit()
    },
      2000,
    );
  }
}
