import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "text", "uploadIcon", "fileIcon"];

  acceptDrop(event) {
    event.preventDefault();
  }

  drop(event) {
    event.preventDefault();
    if (event.dataTransfer.items) {
      const files = event.dataTransfer.items;
      const file = files[0].getAsFile();
      const dataTransfer = new DataTransfer();
      dataTransfer.items.add(file);
      this.inputTarget.files = dataTransfer.files;

      this.textTarget.innerHTML = file.name;
      this.uploadIconTarget.classList.toggle("hidden");
      this.fileIconTarget.classList.toggle("hidden");
    }
  }

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
