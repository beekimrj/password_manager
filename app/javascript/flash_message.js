window.addEventListener('load', hideFlashMessage)
function hideFlashMessage() {
  console.log("hello biki")
  if (document.querySelector(".js_flash_close_btn")) {


    function fadeOutEffect(elem) {
      var fadeEffect = setInterval(function () {
        if (!elem.style.opacity) {
          elem.style.opacity = 1;
        }
        if (elem.style.opacity > 0) {
          elem.style.opacity -= 0.1;
        } else {
          hideElem(elem)
          clearInterval(fadeEffect);
        }
      }, 300);
    }

    function hideElem(elem) {
      elem.style.display = 'none';
    }

    let flashCloseBtns = document.querySelectorAll(".js_flash_close_btn")
    flashCloseBtns.forEach(function (flashCloseBtn) {
      var fadeTarget = flashCloseBtn.closest(".js_flash_box");
      fadeOutEffect(fadeTarget);
      // flashCloseBtn.addEventListener("click", hideElem(fadeTarget), false)
    })
  }
}
