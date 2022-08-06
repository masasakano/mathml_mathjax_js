function mathmlMpaddedCore(mathjax_version = null, doc = null){

    var a, b, div_mathjax_is_loaded, meta_mathjax_version;
    if (! mathjax_version){ mathjax_version = '3.2.2' };
    var major_version = parseInt(mathjax_version.toString().replace(/\..*/i, ""));
    if (major_version < 2) {
      // throw()  is OK, but sends "Uncaught" to the browser.
      console.error("ERROR(mathml-mpadded): Specified Mathjax version "+mathjax_version+" is invalid.");
      return;
    }
    const uri_tail = (major_version > 2) ? "/es5/tex-mml-chtml.min.js" : "/MathJax.js?config=TeX-MML-AM_CHTML";
    const mathjax_url = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/"+mathjax_version+uri_tail;

    var docu = (doc ? doc : document);
    if (    docu.body.getElementsByTagNameNS("http://www.w3.org/1998/Math/MathML", "math")[0]
        && (docu.body.insertAdjacentHTML(
            "afterbegin",
            "<div style='border: 0; clip: rect(0 0 0 0); height: 1px; margin: -1px; overflow: hidden; padding: 0; position: absolute; width: 1px;'><math xmlns='http://www.w3.org/1998/Math/MathML'><mpadded height='23px' width='77px'></mpadded></math></div>"
            ),
            b = docu.body.firstChild,
            a = b.firstChild.firstChild.getBoundingClientRect(),
            docu.body.removeChild(b),
            1 < Math.abs(a.height-23) || 1 < Math.abs(a.width-77)
          )
       ){
      // Insert a script tag in <head> to load Mathjax
      a = docu.createElement("script");
      a.src=mathjax_url;
      docu.head.appendChild(a);

      // Insert a div tag at the top of <body>
      div_mathjax_is_loaded = docu.createElement('div');
      div_mathjax_is_loaded.setAttribute("id", "mathjax_is_loaded");
      div_mathjax_is_loaded.setAttribute("itemscope", "");
      meta_mathjax_version = docu.createElement('meta');
      meta_mathjax_version.setAttribute("itemprop", "version");
      meta_mathjax_version.setAttribute("content", mathjax_version);
      div_mathjax_is_loaded.appendChild(meta_mathjax_version);
      docu.body.insertAdjacentElement('afterbegin', div_mathjax_is_loaded);
      // At the beginning of <body>, appended:
      //  <div id="mathjax_is_loaded" itemscope=""><meta itemprop="version" content="3.2.2"></div>
			return mathjax_version.toString();  // Always String (for Chrome, Opera, Edge, etc)
    }
    return 0;  // Integer 0 for Firefox and Safari
};

export {mathmlMpaddedCore};

