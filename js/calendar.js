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
    
    calendarDetailElements.push(detail);
    link.onclick = getTogglerFor(detail);
  }
}

/**
 * @type {Array<Element>}
 */
let calendarDetailElements = [];
linkCalendar(document.getElementById("cal"));

