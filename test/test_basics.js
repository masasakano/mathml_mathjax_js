import { expect } from 'chai';
import { mathmlMpaddedCore } from "../src/mathml-mpadded-core.js";

import { JSDOM } from "jsdom";
const { html } = `
<!DOCTYPE html>
<html lang="en">
<head> <title>Test of MathML/Mathjax</title> </head>
<body>
<p>
Using <i>a</i>, the formula
<math xmlns="http://www.w3.org/1998/Math/MathML" alttext="\sqrt{a}">
  <msqrt> <mi>a</mi> </msqrt>
</math>
is displayed inline.
</p>
</body>
</html>`;

const { document } = (new JSDOM(html)).window;

describe("Basic tests", function(){  // Section
  it("unit tests of mathmlMpaddedCore()", function() {  // Tests
    expect(1+1).to.equal(2)
    console.log('** An Error message is expected to be printed below:');
    expect(mathmlMpaddedCore("1.0")).to.be.undefined;
    //expect(mathmlMpaddedCore( 1.0 )).to.be.undefined;  // Same result -- OK.

    //// The following does not work well, presumably because JSDOM does not handle
    //// the actual appearance, which the algorithm of the function checks.
    //expect(mathmlMpaddedCore(4.7, document)).to.equal("4.7");
  });
});

