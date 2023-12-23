import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["text", "uploadIcon", "fileIcon"];

  display(event) {
    const file = event.target.files[0];
    if (file) {
      const fileName = file.name;
      this.textTarget.innerHTML = `${fileName}`;
      this.uploadIconTarget.classList.toggle("hidden");
      this.fileIconTarget.classList.toggle("hidden");
    }
  }
}
