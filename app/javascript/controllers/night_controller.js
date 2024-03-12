import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="night"
export default class extends Controller {

  nightAnimation(event) {
    event.preventDefault()
    const day = document.querySelector(".day")
    day.classList.toggle('night')
    console.log(day);

    setTimeout(() => {
      event.target.closest("form").submit()
    },
    500,
  );
  }
}
