const TEMPLATE_FILE_UPLOAD_LIST_ITEM = `
  <div class="file-info">
    <div class="file-name">
      <strong>File:</strong>
    </div>
  </div>
  <button class="file-action" title="Upload">
    <i class="fa fa-upload" aria-hidden="true"></i>
  </button>
  <button class="file-action" title="Remove" type="reset" onclick="uploader.resetList(true)">
    <i class="fa fa-trash-alt" aria-hidden="true"></i>
  </button>`;

// Removes the text from the navbar buttons at the targeted screen width
function hideNavbarButtonText(pageWidth) {
  let navbarButtons = document.querySelectorAll(".nav-item button");
  for (let i = 0; i < navbarButtons.length; i++) {
    if (pageWidth.matches)
      navbarButtons[i].firstElementChild.style.display = "none";
    else
      navbarButtons[i].firstElementChild.style.display = "inline";
  }
}

var pageWidthQuery = window.matchMedia("(max-width: 500px)");
hideNavbarButtonText(pageWidthQuery);
pageWidthQuery.addListener(hideNavbarButtonText);


class ImageUploader {
  constructor(uploadForm) {
    this.form = document.querySelector(uploadForm);
    this.dropzone = this.form.querySelectorAll(".dropzone, .dropzone-icon");
    this.list = this.form.querySelector('.file-display');
    this.input = this.form.querySelector('#file-input');

    this.updateDropzoneStyle = this.updateDropzoneStyle.bind(this);
    this.addFile = this.addFile.bind(this);

    this.eventListen();
  }

  eventListen() {
    this.dropzone[0].addEventListener("dragover", this.updateDropzoneStyle);
    this.dropzone[0].addEventListener("dragleave", this.updateDropzoneStyle);
    this.dropzone[0].addEventListener("drop", this.updateDropzoneStyle);

    this.input.addEventListener("change", this.addFile);
  }

  updateDropzoneStyle(e) {
    const action = (e.type === "dragover" ? "add" : "remove");
    e.currentTarget.classList[action]("active");
    this.dropzone[1].classList[action]("active");
  }

  addFile(e) {
    const files = e.currentTarget.files;

    // Proceed no further in case the user presses "Cancel" in the browser dialog
    //
    /* Chromium bug: https://bugs.chromium.org/p/chromium/issues/detail?id=2508
     * Selecting a file, then opening the browser dialog again and pressing
     * "Cancel" will clear the file input. Firefox does not exhibit this
     * behaviour. Behaviour on Safari is untested.
     */
    if (files.length == 0) {
      if (!!window.chrome) {
        this.resetList(false);
        return;
      }

      return;
    }

    if (this.listNotEmpty())
      this.resetList(false);

    // SECURITY WARNING: THIS CAN BE SPOOFED BY EXT CHANGE
    if (!/^image\/jpeg|jpg|png/.test(files[0].type)) {
      this.form.reset();
      return;
    }

    this.addToList(files[0]);
  }

  addToList(file) {
    const li = document.createElement("li");
    li.classList.add("file");
    li.innerHTML = TEMPLATE_FILE_UPLOAD_LIST_ITEM;

    const fileName = li.querySelector(".file-name");
    fileName.childNodes[2].textContent = file.name;

    this.list.appendChild(li);
    this.list.style.display = "block";
    return li;
  }

  resetList(includeForm) {
    includeForm = (typeof includeForm !== 'undefined') ?  includeForm : false

    this.list.innerHTML = "";
    this.list.style.display = "none";

    if (includeForm)
      this.form.reset();
  }

  listNotEmpty() {
    return this.list.children.length != 0;
  }
}