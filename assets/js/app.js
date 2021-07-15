// Removes the text from the navbar buttons at the targeted screen width
function hideNavbarButtonText(pageWidth) {
  var eBtnGrid = document.querySelectorAll(".navbar-nav .btn-outline-dark")[0];
  if (eBtnGrid != null) {
    var icon = "<i class='fa fa-th' aria-hidden='true'></i>";
    if (pageWidth.matches)
      eBtnGrid.innerHTML = icon;
    else
      eBtnGrid.innerHTML = "Grid &nbsp;" + icon;
  }

  var eBtnUpload = document.querySelectorAll(".navbar-nav .btn-outline-primary")[0];
  if (eBtnUpload != null) {
    var icon = "<i class='fa fa-upload' aria-hidden='true'></i>";
    if (pageWidth.matches)
      eBtnUpload.innerHTML = icon;
    else
      eBtnUpload.innerHTML = "Upload &nbsp;" + icon;
  }
}

var pageWidthQuery = window.matchMedia("(max-width: 500px)");
hideNavbarButtonText(pageWidthQuery);
pageWidthQuery.addListener(hideNavbarButtonText);