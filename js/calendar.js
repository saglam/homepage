/**
 * @fileoverview Calendar module
 * Reserves the css c* namespace
 */
 
function getTogglerFor(/** @type {Element} */ detailElement) {
  return function() {
    for (let i = 0, len = calendarDetailElements.length; i < len; ++i) {
      if (calendarDetailElements[i] != detailElement) {
        calendarDetailElements[i].classList.remove("show");
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
    calendarDetailElements.push(detail);
    link.onclick = getTogglerFor(detail);

    for (let elem = detail.firstElementChild; elem != null; elem = elem.nextElementSibling) {
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

/**
 * @type {Array<Element>}
 */
let calendarDetailElements = [];
linkCalendar(document.getElementById("cal"));

