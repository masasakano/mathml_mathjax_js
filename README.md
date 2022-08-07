
Handle browser-dependence for MathML with MathJax
==================================================

This package provides MathML-MathJax related JavaScripts, specifically, a small code to automatically determine to load MathJax or not.

The original repository is hosted on Github: <https://github.com/masasakano/mathml_mathjax_js>  
The JavaScript and sample HTML files are ported to <https://masasakano.github.io/mathml_mathjax_js/> ([Index](https://masasakano.github.io/mathml_mathjax_js/dist/))

## Introduction ##

As of 2022 summer, the web-browser support for MathML is limited; in short only Firefox and Safari provide a reasonable support, but not Chrome, Opera, or Edge (or Internet Explorer) —— see [Browser compatibility](https://developer.mozilla.org/en-US/docs/Web/MathML#browser_compatibility "Browser compatibility (of MathML) on mozilla.org") on the Mozilla website.  So, if you write a HTML containing MathML, many people are unable to read it at least in an originally intended form.

A popular and probably the most powerful fallback to interpret MathML by browsers is MathJax, a JavaScript framework. However, MathJax should not be loaded for browsers that can natively interpret MathML. This package offers a JavaScript code to selectively load MathJax, that is, MathJax is loaded only when the browser is a visual browser and does not interpret MathML.

### Predecessor of This Package ###

In mozilla.org, specifically in Section "[Fallback](https://developer.mozilla.org/en-US/docs/Web/MathML/Authoring#fallback_for_browsers_without_mathml_support "Fallback for browsers without mathml support)")", there is a guideline of how to deal with the browser-dependence.  Unfortunately, the document seems obsolete outdated as of 2022 August.

In short, the JavaScripts described in the Mozilla site no longer work, as they fail to load MathJax JavaScript. Indeed, some JavaScripts contain hard-coded URIs for MathJax JavaScript, the hosting URIs of which are outdated, presumably because of the [shutdown of the cdn server on mathjax.org](https://www.mathjax.org/cdn-shutting-down/ "MathJax CDN shutting down on April 30, 2017. Alternatives available.")) in 2017.

The couple of pieces of the main JavaScript code introduced in the Mozilla site were obviously developped (or at least published) by [Frédéric Wang](https://github.com/fred-wang/Mathzilla). However, I have failed to locate the original repository for the set of minified code, including [`mpadded-min.js`](https://fred-wang.github.io/mathjax.js/mpadded-min.js). In fact, the [original repository of Mathzilla](https://github.com/fred-wang/Mathzilla), a collection of MathML-realted code developed by the same author, comes with a warning now (as of 2022 August):

> Warning: This directory contains some obsolete or experimental content and is only kept for historical purpose.

(Some or all of) The JavaScripts in this package are based on the minified code introduced in the above-mentioned [Mozilla document](https://developer.mozilla.org/en-US/docs/Web/MathML/Authoring#fallback_for_browsers_without_mathml_support "Fallback for browsers without mathml support)"). The major point of modification is that the URIs for MathJax are updated and work at the time of writing. I note that the version number has to be explicitly given in this package, unlike the original minified code, which simply specifies the latest version, because the new hosting site <https://cdnjs.cloudflare.com/> gives no option to specify the latest version but requires you to specify the version explicitly.

This package is licensed under the [MPL 2](https://www.mozilla.org/en-US/MPL/2.0/).

### Background ###

Historically, it is not easy to write mathematical expressions in a presentable way on websites.
Brian Hayes's article [Writing Math on the Web](https://www.americanscientist.org/article/writing-math-on-the-web "Writing Math on the Web on American Scientist, 2009, vol 97, number 2, p.98") published on American Scientist in 2009 summarises the situation at the time, for example.

MathML is probably the most natural way for the purpose, being compatible with HTML.
It is a text form of mathematical expressions and hence is most easily processed by a computer, meaning perhaps optimum for indexing (for searching etc) and processing for non-visual environments, such as auditorial browsers.
However, MathML does have drawbacks. In short, MathML is not human-friendly. It is hard to read and even harder to write, requiring a lot of effort to write even the smallest piece of mathematical expression. I guess most MathML documents on the Internet were generated, machine-converted from a different format. Also, the format is fairly lengthy and so needs a slightly more amount of data storage and data transfer and computer power to interpret, although the former is nothing compared with binary such as images and the latter is probably nothing, either, in the modern computer standard.

There are some fallback mechanisms for MathML so browsers that cannot natively interpret MathML can display it nicely. Also, there are alternative ways to present maths on websites. Here is a brief summary (though incomplete).

1. Fallback for MathML
   1. [mathml.css](https://github.com/fred-wang/mathml.css)
      * **Pros**: Relatively simple CSS to interprete MathML to be provided with the HTML+MathML.
      * **Cons**: This works only for a limited (aka most basic) subset of MathML. This should not be provided for browsers that can interprete MathML. Therefore, the website must judge the user's browser or instruct users' choices of the browser (for example, separate pages for the same contents should be provided, depending on the browser).
   2. [MathJax](https://www.mathjax.org/)
      * **Pros**: Most powerful JavaScript fallback. It works in all major visual browsers. It can interprete a vast majority of MathML, though still incomplete (as of Version 3.2.2 in 2022 August), e.g., it does not interpret the `rowspan` attribute for the MathML tag `mtd` in `mtable`.
      * **Cons**: Like [mathml.css](https://github.com/fred-wang/mathml.css), this should not be provided for browsers that can interprete MathML, although in most cases the browser-native and MathJax interpretations of MathML (by the browser that can natively interpret MathML) are pretty similar, except some unsupported cases by MathJax.
   3. [KaTeX](https://katex.org/)
      * **Pros**: Similar to MathJax, but processing is much lighter and faster.
      * **Cons**: The range of support of MathML is more limited than MathJax (at least as of 2022 August). Like [mathml.css](https://github.com/fred-wang/mathml.css), this should not be provided for browsers that can interprete MathML. If one does, the chance of failure for the correct interpretation is higher than MathJax.
2. Alternative way to present mathematical expressions
   1. PDF or epub
      * **Pros**: What a user sees is what the author intends.
      * **Cons**: Unfriendly for automated processing, including indexing and searching. Not suitable for non-visual environments, such as for auditorial or text browsers.
   2. conversion to images; famously, `latex2html` converts LaTeX format into HTML, in which all the mathematical expressions are converted into images.
      * **Pros**: The document is mostly computer-friendly, like searchable, **except** the mathematical expressions.
      * **Cons**: The same problem as for the PDF about mathematical expression.
   3. LaTeX (or AMS-TeX or even plain TeX) source code
      * **Pros**: A gold standard to write mathematical expressions in the text form (in ASCII, UTF-8, etc). One of the easiest to write (though the learning cost is fairly expensive). Pretty computer friendly, though LaTeX does not care the semantics.
      * **Cons**: Very hard to read, except for the simplest ones. Not presentable on websites as it is, partly because there is no official standard to specify the form in the website protocol and no browsers natively interpret LaTeX.
   4. On-the-spot interpretation of LaTeX-style expressions embedded in HTML
      * Popular ones inclulde [MathJax](https://www.mathjax.org/) and [KaTeX](https://katex.org/). See a [list of alternatives](https://alternativeto.net/software/mathjax/).
      https://alternativeto.net/software/mathjax/
      * **Pros**: Maths expressions are pretty easy to write (providing the author is knowledeable about LaTeX) and is easier to read than MathML. Indexing by search engines is in principle relatively easy, though it probably is not for users' environments. Browsers do not need to do anything, except interpreting the JavaScript code.
      * **Cons**: As far as the existing frameworks are concerned, they are no use (or maybe arguably worse?) for non-visual or text-only (terminal-like) environments, though technically it is possible to develop systems to accommodate a wide variety of environments. No semantics are preserved.
   5. [AsciiMath](http://asciimath.org/)
      * **Pros**: Merginally simpler to write than LaTeX.
      * **Cons**: Tha [native JavaScript interpreter](http://git.io/X84VQQ) works only on Firefox and Safari, though, alternatively, [MathJax](https://www.mathjax.org/) can also interpret it and works in all major visual browsers. Like LaTeX, (I think) it does not care the semantics. The learning cost to write is still high, though seemingly lower than LaTeX and though it is designed so that people knowledeable about LaTeX can migrate fairly easily. Much less popular than LaTeX, which means less people can actually read it, though the simplest form is admittedly intuitive and can be interpreted by anyone regardless of their knowledge of AsciiMath.


## How To Use the Code ##

Include one of the following inside (preferably) the `<head>` element in the HTML page. For the last one, an arbitrary (valid) MathJax version number can be specified.

```html
 <script src="https://masasakano.github.io/mathml_mathjax_js/dist/mathml-mpadded-3-2-2.min.js"> </script>
 <script src="https://masasakano.github.io/mathml_mathjax_js/dist/mathml-mpadded-2-7-7.min.js"> </script>
 <script src="https://masasakano.github.io/mathml_mathjax_js/dist/mathml-mpadded.min.js" data-mathjax-version="3.1.0"> </script>
```

Their differences are potential versions of MathJax to be loaded *if* MathJax is found to be necessary.

The first one is the latest release one at the time of writing and the second one is (I think) the last release of MathJax version 2.
The third one is a generic one, which loads the user-specified version of MathJax.  Note that it assumes no other `<script>` tags in the HTML from which the JavaScript is called have a `data-mathjax-version` attribute.

As soon as the HTML is read, if a browser does not deal with MathML, it automatically load MathJax.
And if MathJax is loaded, the following set of tags (with the version of the loaded MathJax) is inserted at the beginning of the `<body>`, which you can use in your own script/CSS.

```html
  <div id="mathjax_is_loaded" itemscope><meta itemprop="version" content="3.2.2"></div>
```

The tag to load MathJax is not added (existing statements are unaffected anyway) if either the content contains no MathML or the browser can handle MathML more or less (in practice, if the browser is either Firefox or Safari as of 2022 Augurst), and nor such tag is inserted. In such cases, the above three do not mofidy the existing contents at all.

### Demo ###

[`dist/` directory](https://masasakano.github.io/mathml_mathjax_js/dist/ "dist/ on the hosting github.io website") contains a couple of MathML HTMLs, in the header of which a JavaScript of this package is specified.

## Limitations ##

The algorithm assumes a few points:

* The initial tag for MathML (`<math>`) must contain the attribute `xmlns="http://www.w3.org/1998/Math/MathML"`.
* The locations of MathJax on Cloudflare are hard-coded.
  * If MathJax of the specified version is not found on the link, the JavaScript simply ends and there is no fallback.
  * The version prior to 2 is not supported. The version higher than 3, if released ever in the future, will work, **providing** the format of the URI is identical.
* The `data-mathjax-version` attribute in `<script>` tags must be unique in the HTML.
  * This constraint should be able to be removed……
* The minified JSs work with classic JS, not ES6.
  * However, the source code in the repository is compatible only with ES6 and not with classic JS. It is because of convenience for unit-testing purposes.
* The algorithm relies on the visual appearance of browser's handling of MathML.  In other words, it would not work with non-visual web browsers.

## Development ##

In the developer environment, the following has to be available.

* standard `make`
* `Ruby` (any version)
  * used in `Makefile`
* `npm`
  * `uglifyjs` for minifying in `Makefile`.
  * `mocha`, `chai`, `jsdom` for testing.
  * These should be installed with `npm install` at the top directory.
* `pandoc`
  * To create a HTML file from the markdown file (`README.md`) for local use.

### make ###

The basic command is `make`. In the master branch, `make` generates or updates minified (Common) JavsScript files (see below) and `README.html` both under the `tmp/` directory, if any of the relevant files have been updated since the last update. The latter `tmp/README.html` is for local use only (for the convenience of development).

If you want to forcibly update `tmp/README.html` (from `README.md`), run `make doc` .

Routine testing (unit-testing) is carried out with `make test` at the top directory.
It is far from sufficient.  More browser-dependent test frameworks are desirable.

#### make in gh-pages branch ####

It has the following functions.

* `make` : to update (auto-generate) `dist/README.md` if need be (ie., if JS and/or HTML are updated))
* `make check` : to check if any update is required.
  * **NOTE**: This function is, although it probably works, not thoroughly tested. You should know which files should be updated (because they have been updated in the *master* branch) before switching to *gh-pages* branch, anyway. So use `make check` to just confirm it.

### Minify and "dist" ###

The minified and combined versions of JavaScript are generated under `tmp/` directory (in the `master` branch) with `make` executed at the top directory.
The generated minified ones are compatible with classic JS, whereas the original ones under `src` directory are not.

In minification, the core function `src/mathml-mpadded-core.js` is combined with one of the wrappers, such as `src/mathml-mpadded.js` .

The generated JS files under `tmp/` should be later copied into the `dist/` directory in the `gh-pages` branch.  The directory `tmp/` is registered in both `master` and `gh-pages` branches (whereas none of the normal files but `.gitignore` under `tmp/` is registered in either) and therefore the generated files are not lost during `git switch`.  That is the idea for this separation. Note that the standard `git diff` is unusable in this case because `XXX.min.js` exists only in the `gh-pages` branch whereas the updated `XXX.js` exists only in the `master` branch.

The standard work-flow is as follows:

1. In the *master* branch, edit the files as you like.
2. `make` (and `make test`), which generates minified JSs.
3. `git commit` (and maybe `git push`)
4. `git switch gh-pages` (Move to *gh-pages* branch)
5. `make check` (to see if there is any update required, ie., if the corresponding file in the master branch has been updated — usually yes; this does the following checks but does not fix the problems)
   1. `git diff master -- README.md`
      * If any diff, run ``git checkout master README.md`
   2. `for f in tmp/*.min.js; do diff ../dist/`basename $f` $f; done`
      * If any diff, `mv MODIFIED.min.js ../dist/`  (n.b., this will usually overwrite an existing file.)
   3. `git diff master -- dist/demo/*.html`  (should return none if no HTML is updated in the master branch.)
      * If any diff, `git checkout master dist/demo/MY_UPDATED.html`
6. `make`  (to update `dist/README.md` if need be (ie., if JS and/or HTML are updated))
7. `git add -u` and `git commit` (and maybe `git push`)

### Publishing ###

The files under the directory `dist/` are automatically published on <https://masasakano.github.io/mathml_mathjax_js/> in a way they (JavaScript and HTML files) are available to be called directly from the website (see [Index](https://masasakano.github.io/mathml_mathjax_js/dist/)).

None of the generated files under the directory `tmp/` (or `dist/`) is registered in the master branch, whereas the static files, specifically `dist/demo/sample-*.html` and `.gitignore`, are.  The `gh-pages` branch contains those files under the directory `dist/` in the repository (but none under `tmp/`), but almost none of the files in the other directories.

### TODO ###

* The constraint requiring that `data-mathjax-version` attribute in `<script>` tags must be unique in the HTML should be removed.
  * In Common JS, `document.currentScript` may work, but it is hard to make it work in a separate JS file like in this case; see [Stackoverflow](https://stackoverflow.com/questions/38769103/document-currentscript-is-null "document.currentScript is null"), which is summarised in [newbedev.com](https://newbedev.com/document-currentscript-is-null "document.currentScript is null"). In ES6, `import.meta.my_attr` [should work](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/import.meta "import.meta in Mozilla").
* It would be nice to implement the other two methods by Frédéric Wang mentioned in the [mozilla website](https://developer.mozilla.org/en-US/docs/Web/MathML/Authoring#fallback_for_browsers_without_mathml_support "Fallback for browsers without mathml support)").

## Licence and Disclaimer ##

The licence is [MPL 2](https://www.mozilla.org/en-US/MPL/2.0/), as described in `LICENSE.txt` in the package.

The author owes no responsibility for the package. Use it at your own risk.

## Acknowledgement ##

I thank Frédéric Wang and Mozilla team for the earlier development. I hope MathML will be fully supported by all browsers one day.

------

Author: Masa Sakano - <https://github.com/masasakano/>

