import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="night"
export default class extends Controller {
  connect() {
    console.log("salut les copains ");
  }

  nightAnimation(event) {
    event.preventDefault()
    const form = event.currentTarget.closest(".button_to")
    document.querySelector(".day").classList.add("to_night")


    setTimeout(() => {
      form.submit()
    }, 1000);
  }

  notFed(event) {
    event.preventDefault()
    const popup = `
    <div class="alert">
      Tu dois nourrir ton poisson !
    </div>
    `
    document.body.insertAdjacentHTML("beforeend", popup)
  }
}
