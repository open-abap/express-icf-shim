# express-icf-shim

[express](https://expressjs.com) 4.x and 5.x ICF shim, `if_http_extension`

The ABAP code must set correct status and content types in responses.

`npm install express --save-dev`, or `npm install express@4 --save-dev`

## Usage

```js
import express from 'express';
import {initializeABAP} from "../output/init.mjs";
import {cl_express_icf_shim} from "../output/cl_express_icf_shim.clas.mjs";
await initializeABAP();

...

app.use(express.raw({type: "*/*"}));

...

// express 5
app.all("/abap{*splat}", async function (req, res) {
  await cl_express_icf_shim.run({req, res, class: "ZCL_HTTP_HANDLER"});
});

// express 4
app.all(["/abap", "/abap*"], async function (req, res) {
  await cl_express_icf_shim.run({req, res, class: "ZCL_HTTP_HANDLER"});
});

...
```

Express 5 does not accept the `*` wildcard of express 4, `"/abap{*splat}"` matches the same paths as `["/abap", "/abap*"]`.
