import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source"];

  copy(event) {
    event.preventDefault();
    navigator.clipboard.writeText(this.sourceTarget.value);

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
