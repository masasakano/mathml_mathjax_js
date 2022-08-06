(function(){
//var thisScript = document.currentScript;
//setInterval(function(){
  window.addEventListener("load", function(){
    //const versi = document.currentScript.getAttribute('version');  // does not work.
    var scripts = document.getElementsByTagName('script');
		var versi;
    for (let i = 0; i < scripts.length; i++) {
			// searches for <script> with 'data-mathjax-version' attribute,
			// assuming there is at most 1 <script> tag with the attribute!
      versi = scripts[i].getAttribute('data-mathjax-version')
      if (versi){ break; }
    }

    if (versi) {
      mathmlMpaddedCore(versi);
    } else {
      mathmlMpaddedCore();
    }
  })}
)();

