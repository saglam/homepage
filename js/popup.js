/**
 * @fileoverview Popup module
 * Reserves the css p* namespace
 */

/**
 * @param {Element} content
 */
function showDialog(content) {
  /** @type {Element} */
  let mask = document.createElement('div');
  /** @type {Element} */
  let menu = document.createElement('div');
  /** @type {Element} */
  let close = document.createElement('span');
  close.innerText = "x";
  close.setAttribute("class", "px");
  menu.setAttribute("class", "pc");
  menu.appendChild(close);
  menu.appendChild(content);
  mask.setAttribute("class", "pm");
  mask.appendChild(menu);  
  document.body.appendChild(mask);
  let destroy = function() {
    close.onclick = null;
    mask.onmousedown = null;
    document.body.removeChild(mask);
  }
  close.onclick = destroy;
  mask.onmousedown = function(/** Event */ event) {
    if (event.target == mask) {
      destroy();
    }
  };
}

/**
 * @param {string} text
 */
function showText(text) {
  /** @type {Element} */
  let content = document.createElement('pre');
  content.appendChild(document.createTextNode(text));
  showDialog(content);
}

/**
 * @param {string} html
 */
function showHtml(html) {
  /** @type {Element} */
  let content = document.createElement('div');
  content.innerHTML = html;
  showDialog(content);
}

