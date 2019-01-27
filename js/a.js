/**
 * @const
 * @type {Object<string, string>} mapping bib keys to bib entry
 */
var bibMap = {
  "Saglam2018": "@InProceedings(   Saglam2018,\n" +
"  author        = {Mert Sağlam},\n" +
"  title         = {Near Log-Convexity of Measured Heat in (Discrete) Time and\n" +
"                  Consequences},\n" +
"  booktitle     = {59th {IEEE} Annual Symposium on Foundations of Computer\n" +
"                  Science, {FOCS} 2018, Paris, France, October 7-9, 2018},\n" +
"  pages         = {967--978},\n" +
"  year          = {2018},\n" +
"  crossref      = {DBLP:conf/focs/2018},\n" +
"  url           = {https://arxiv.org/abs/1808.06717},\n" +
"  doi           = {10.1109/FOCS.2018.00095},\n" +
"  timestamp     = {Sun, 23 Dec 2018 08:29:07 +0100},\n" +
"  biburl        = {https://dblp.org/rec/bib/conf/focs/Saglam18},\n" +
")",

  "SaglamT2013": "@InProceedings(   SaglamT2013,\n" +
"  author        = {Mert Sağlam and Gábor Tardos},\n" +
"  title         = {On the Communication Complexity of Sparse Set Disjointness\n" +
"                  and Exists-Equal Problems},\n" + 
"  booktitle     = {54th {IEEE} Annual Symposium on Foundations of Computer\n" +
"                  Science, {FOCS} 2013, Berkeley, CA, October 26-29, 2013},\n" +
"  pages         = {678--687},\n" +
"  year          = {2013},\n" +
"  url           = {https://arxiv.org/abs/1304.1217},\n" +
"  doi           = {10.1109/FOCS.2013.78},\n" +
"  timestamp     = {Tue, 16 Dec 2014 09:57:23 +0100},\n" +
"  biburl        = {https://dblp.org/rec/bib/conf/focs/SaglamT13}\n" +
")",

  "JowhariST2011": "@InProceedings(   JowhariST2011,\n" +
"  author        = {Hossein Jowhari and Mert Sağlam and Gábor Tardos},\n" +
"  title         = {Tight bounds for Lp samplers, finding duplicates in streams,\n" +
"                  and related problems},\n" +
"  booktitle     = {Proceedings of the 30th {ACM} {SIGMOD-SIGACT-SIGART}\n" +
"                  Symposium on Principles of Database Systems, {PODS} 2011, June\n" +
"                  12-16, 2011, Athens, Greece},\n" +
"  pages         = {49--58},\n" +
"  year          = {2011},\n" +
"  crossref      = {DBLP:conf/pods/2011},\n" +
"  url           = {https://arxiv.org/abs/1012.4889},\n" +
"  doi           = {10.1145/1989284.1989289},\n" +
"  timestamp     = {Wed, 23 May 2012 16:53:24 +0200},\n" +
"  biburl        = {https://dblp.org/rec/bib/conf/pods/JowhariST11}\n" +
")",
  "ErgunJS2010": "@InProceedings(   ErgunJS2010,\n" +
"  author        = {Funda Ergün and Hossein Jowhari and Mert Sağlam},\n" +
"  title         = {Periodicity in Streams},\n" +
"  booktitle     = {Approximation, Randomization, and Combinatorial Optimization.\n" +
"                  Algorithms and Techniques, 13th International Workshop,\n" +
"                  {APPROX} 2010, and 14th International Workshop, {RANDOM} 2010,\n" +
"                  Barcelona, Spain, September 1-3, 2010. Proceedings},\n" +
"  pages         = {545--559},\n" +
"  year          = {2010},\n" +
"  url           = {http://dx.doi.org/10.1007/978-3-642-15369-3_41},\n" +
"  doi           = {10.1007/978-3-642-15369-3_41},\n" +
"  timestamp     = {Sun, 29 Aug 2010 20:35:26 +0200},\n" +
"  biburl        = {https://dblp.org/rec/bib/conf/approx/ErgunJS10}\n" +
")",

  "Saglam2011": "@MastersThesis(   Saglam2011,\n" +
"  author        = {Mert Sağlam},\n" +
"  title         = {Tight bounds for data stream algorithms and communication\n" +
"                  problems},\n" +
"  school        = {Simon Fraser University, School of Computing Science},\n" +
"  year          = {2011},\n" +
"  address       = {8888 University Drive, Burnaby, B.C. Canada V5A 1S6},\n" +
"  month         = {9}\n" +
")"
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
  close.setAttribute("class", "mx");
  menu.setAttribute("class", "mc");
  menu.appendChild(close);
  menu.appendChild(content);
  mask.setAttribute("class", "mask");
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

/**
 * @param {Element} paper element to link and texify
 */
function linkPaper(paper) {
  /** @type {Element} */
  var absButton;
  /** @type {Element} */
  var absDiv;

  renderElement(paper);

  /** @type {Element} */
  var elem;
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
let papers = document.getElementsByClassName("paper");
/**
 * @const
 * @type {number}
 */
let n = papers.length;

/** @type {number} */
let i;
for (i = 0; i < n; i++) {
  linkPaper(papers[i]);
}

