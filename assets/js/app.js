// Removes the text from the navbar buttons at the targeted screen width
function hideNavbarButtonText(pageWidth) {
  var navbarButtons = document.querySelectorAll(".nav-item button");
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