function notExisting() {
    alert("Doesn't exist");
}

function goBack() {
  window.history.back();
}

  var timedelay = 1;

  function delayCheck() {

    if(timedelay == 7) {
      $('#showdiv').fadeOut();
      timedelay = 1;
    }

    timedelay = timedelay+1;
  }

  $(document).mousemove(function() {
    $('#showdiv').fadeIn();
    timedelay = 1;
    clearInterval(_delay);
    _delay = setInterval(delayCheck, 500);
  });

  _delay = setInterval(delayCheck, 500);

if (
  "IntersectionObserver" in window &&
  "IntersectionObserverEntry" in window &&
  "intersectionRatio" in window.IntersectionObserverEntry.prototype
) {
let observer = new IntersectionObserver(entries => {
  if (entries[0].boundingClientRect.y < 0) {
    document.body.classList.add("header-not-at-top");
    document.getElementById("jsUsed").id = "showdiv";
  } else {
    document.body.classList.remove("header-not-at-top");
    document.getElementById("showdiv").id = "jsUsed";
    $('#jsUsed').fadeIn();
  }
});
observer.observe(document.querySelector("#top-of-site-pixel-anchor"));
}