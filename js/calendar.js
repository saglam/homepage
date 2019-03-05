/**
 * @fileoverview Calendar module
 * Reserves the css c* namespace
 */

/**
 * @type {Array<Element>}
 */
let CalendarDetailElements = [];

/**
 * @type {Element}
 */
let NextDetail;

function getTogglerFor(/** @type {Element} */ detailElement) {
  return function() {
    for (let i = 0, len = CalendarDetailElements.length; i < len; ++i) {
      if (CalendarDetailElements[i] !== detailElement) {
        CalendarDetailElements[i].classList.remove("show");
      }
    }
    detailElement.classList.toggle("show");
  }
}

function HammingLauncher()  {
  let talk = window.open("talks/hamming-ias/", "_blank", 'width=1200,height=675');
  if (window.focus) {
    talk.focus();
  }
  return false;
}

function linkCalendar(/** Element */ calendar) {
  for (let i = 0; i < calendar.rows.length; ++i) {
    /** @const {Element} */
    let cell = calendar.rows[i].cells[2];
    /** @type {Element} */
    let link = cell.firstElementChild;    
    if (link == null) {
      continue;
    }

    /** @type {Element} */
    let detail = link.nextElementSibling;
    if (detail == null) {
      continue;
    }

    if (calendar.rows[i].cells[0].classList.contains("next")) {
      NextDetail = detail;
    }

    renderElement(detail);
    CalendarDetailElements.push(detail);
    link.onclick = getTogglerFor(detail);

    for (let elem = detail.firstElementChild; elem !== null; elem = elem.nextElementSibling) {
      /**
       * @type {string}
       */
      let id = elem.dataset["talk"];
      if ("heatdiscrete-cmu" == id) {
        elem.onclick = function() {
          let talk = window.open("talks/heatdiscrete-cmu/", "_blank", 'width=960,height=700');
          if (window.focus) {
            talk.focus();
          }
          return false;
        }
      } else if ("hamming-ias" == id) {
        elem.onclick = HammingLauncher;
      }
    }
  }
}

linkCalendar(document.getElementById("cal"));
if (NextDetail) {
  window.onload = function() {
    NextDetail.classList.remove("masked");
  }
}

