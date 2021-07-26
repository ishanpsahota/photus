function printPrettyBytes(bytes, decimalPlaces = 2) {
  if (bytes == 0)
    return '0 bytes';

  const kb = 1024;
  const units = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  const i = Math.floor(Math.log(bytes) / Math.log(kb));

  return parseFloat((bytes / Math.pow(kb, i)).toFixed(decimalPlaces)) + ' ' + units[i];
}

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

class ImageUploader {
  constructor(uploadForm) {
    this.form = document.querySelector(uploadForm);
    this.dropzone = this.form.querySelectorAll(".dropzone, .dropzone-icon");
    this.dropzoneOverlay = this.form.querySelector(".dropzone-error-overlay");
    this.list = this.form.querySelector('.file-display');
    this.input = this.form.querySelector('#file-input');

    this.updateDropzoneStyle = this.updateDropzoneStyle.bind(this);
    this.addFile = this.addFile.bind(this);

    this.dropzoneOverlay.lastElementChild.setAttribute("onclick", 
      "uploader.dropzone[0].classList.toggle('overlay-active')");

    this.eventListen();
  }

  eventListen() {
    this.dropzone[0].addEventListener("dragover", this.updateDropzoneStyle);
    this.dropzone[0].addEventListener("dragleave", this.updateDropzoneStyle);
    this.dropzone[0].addEventListener("drop", this.updateDropzoneStyle);

    this.input.addEventListener("change", this.addFile);
  }

  updateDropzoneStyle(e) {
    if (this.overlayActive)
      this.toggleOverlay();

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

    if (this.listNotEmpty)
      this.resetList(false);

    // SECURITY CRITICAL: THIS CAN BE SPOOFED BY EXT CHANGE
    // if (!/^image\/jpeg|jpg|png/.test(files[0].type)) {
    //   this.form.reset();
    //   return;
    // }

    let sig = new ImageSignature(files[0]);
    sig.sniff(sig.maxBytesCanRead, (result) => {
      if (result == "image/jpeg" || result == "image/png") {
        const maxSize = this.maxFileSize;
        if ((sig.blob.size) <= maxSize) {
          this.addToList(sig.blob);
        } else {
          this.form.reset();
          this.showErrorMsg(`Size of the chosen file is larger than the allowed
            maximum of ${printPrettyBytes(maxSize, 0)}.`);
        }
      } else {
        this.form.reset();
        this.showErrorMsg(`Chosen file is of an unrecognized type and cannot be uploaded.<br>
          Accepted files must be images of type <strong>JPEG</strong>, <strong>JPG</strong>, 
          <strong>PNG</strong>.`);
        // console.log("Someone's feeling sneaky: " + sig.blob.type);
      }
    });
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

  toggleOverlay() {
    this.dropzone[0].classList.toggle("overlay-active");
  }

  showErrorMsg(msg) {
    this.dropzoneOverlay.firstElementChild.innerHTML = msg;
    this.toggleOverlay();
  }

  get maxFileSize() {
    return 2097152; // 2MB
  }

  get listNotEmpty() {
    return this.list.children.length != 0;
  }

  get overlayActive() {
    return this.dropzone[0].classList.contains('overlay-active');
  }
}

class ImageSignature {
  constructor(blob) {
    this.blob = blob;

    // https://mimesniff.spec.whatwg.org/#matching-an-image-type-pattern
    this.data = [
      {
          mediaType: "image/jpeg",
          bytePattern: [0xff, 0xd8, 0xff],
          patternMask: [0xff, 0xff, 0xff]
      },
      {
          mediaType: "image/png",
          bytePattern: [0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a],
          patternMask: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff]
      }
    ];
  }

  get maxBytesCanRead() {
    let longest = this.data.reduce((p, c, i, a) => 
      a[p].bytePattern.length > c.bytePattern.length ? p : i, 0);

    return this.data[longest].bytePattern.length;
  }

  match(bytes, sig) {
    // https://mimesniff.spec.whatwg.org/#matching-a-mime-type-pattern
    // No bytes to be ignored
    for (let p = 0; p < sig.patternMask.length; p++) {
      if ((bytes[p] & sig.patternMask[p]) - sig.bytePattern[p] !== 0)
          return false;
    }

    return true;
  }

  sniff(maxBytesRead, callback) {
    let reader = new FileReader();
    let that = this;

    reader.onloadend = function(e) {
      if (e.target.readyState !== FileReader.DONE)
        return;

      const buff = (new Uint8Array(e.target.result));
      for (let i = 0; i < that.data.length; i++) {
        if (that.match(buff, that.data[i])) {
          callback(that.data[i].mediaType);
          return;
        }
      }
      return callback("unrecognized");
    }
    reader.readAsArrayBuffer(this.blob.slice(0, maxBytesRead));
  }
}