/**
 * @fileoverview JavaScript entry point. Links paper and abstract buttons
 * Reserves css e* namespace
 */

/**
 * @const
 * @type {Object<string, string>} mapping bib keys to bib entry
 */
var bibMap = {
  "Saglam2018": "build:Saglam2018bibtex",
  "SaglamT2013": "build:SaglamT2013bibtex",
  "JowhariST2011": "build:JowhariST2011bibtex",
  "ErgunJS2010": "build:ErgunJS2010bibtex",
  "Saglam2011": "build:Saglam2011bibtex",
}

/**
 * @const
 * @type {Object<string, string>} mapping changelog keys to changelog entries
 */
var changelogMap = {
  "Saglam2018"  : "<pre>build:Saglam2018changelog</pre>See also the <a class=l href='//github.com/saglam/heatdiscrete'>git repo</a>.",
  "SaglamT2013" : "<pre>build:SaglamT2013changelog</pre>See also the <a class=l href='//github.com/saglam/ssd'>git repo</a>.",
};

/**
 * @param {Element} paper element to link and texify
 */
function linkPaper(paper) {
  /** @type {Element} */
  let absButton;
  /** @type {Element} */
  let absDiv;

  renderElement(paper);

  /** @type {Element} */
  let elem;
  for (elem = paper; elem != null; elem = elem.nextElementSibling) {
    if (elem.innerHTML == "[abstract]") {
      absButton = elem;
    } else if (elem.className.slice(0, 3) == "abs") {
      absDiv = elem;
    } else if (elem.className == "v") {
      let id = elem.dataset.id;
      if (!id) continue;
      elem.onclick = (
        /**
         * @param {string} changelogId
         * @return {function()}
         */
        function (changelogId) {
          return function() {
            showHtml(changelogMap[changelogId]);
          }
        }
      )(id);
    } else if (elem.innerHTML == "[bib]") {
      elem.onclick = (
        /**
         * @param {string} bibId
         * @return {function()}
         */
        function (bibId) {
          return function() {
            showText(bibMap[bibId]);
          }
        }
      )(elem.dataset.id);
    }
  }
  if (absDiv) {
    /** @type {function()} */
    let toggler = (
      /**
       * @param {Element} abstractElement
       * @return {function()}
       */
      function (abstractElement) {
        return function() {
          abstractElement.classList.toggle("show");
        }
      }
    )(absDiv);
    if (absButton) {
      absButton.onclick = toggler;
    }
    paper.onclick = toggler;
    renderElement(absDiv);
  }
}

/** 
 * @const
 * @type {!NodeList<!Element>}
 */
let papers = document.getElementsByClassName("ep");

for (let i = 0, papersLen = papers.length; i < papersLen; i++) {
  linkPaper(papers[i]);
}

