import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source", "trigger"];

  copy(event) {
    event.preventDefault();
    navigator.clipboard.writeText(
      this.sourceTarget.innerText || this.sourceTarget,
    );

    this.sourceTarget.focus();
    var triggerElement = this.triggerTarget;
    var initialHTML = triggerElement.innerHTML;
    triggerElement.innerHTML = "<span style='color:grey;'>Copied</span>";
    setTimeout(() => {
      triggerElement.innerHTML = initialHTML;
      this.sourceTarget.blur();
    }, 2000);
  }
}
