import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  playPopSound(event) {
    event.preventDefault()

    // Récupérez l'élément audio
    const popSound = document.getElementById("popSound");
    if (!popSound) return;

    // Jouez le son
    popSound.play();

    setTimeout(() => {
        event.target.closest("form").submit()
      },
      150,
    );
  }
}
