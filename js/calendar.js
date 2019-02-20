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
let ShowDetail;

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

function linkCalendar(/** Element */ calendar) {
  for (let i = 0; i < calendar.rows.length; ++i) {
    /** @type {Element} */
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
        ShowDetail = detail;
        elem.onclick = function() {
          let talk = window.open("talks/hamming-ias/", "_blank", 'width=1200,height=675');
          if (window.focus) {
            talk.focus();
          }
          return false;
        }
      }
    }
  }
}

linkCalendar(document.getElementById("cal"));
if (ShowDetail) {
  window.onload = function() {
    ShowDetail.classList.remove("masked");
  }
}

