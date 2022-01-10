# express-icf-shim

[express](https://expressjs.com) 4.x ICF shim, `if_http_extension`

## Usage

wip,

```js
import express from 'express';
import {initializeABAP} from "../output/init.mjs";
import {cl_express_icf_shim} from "../output/cl_express_icf_shim.clas.mjs";
await initializeABAP();

....

app.all("/abap", async function (req, res) {
  await cl_express_icf_shim.run({req, res, class: "ZCL_HTTP_HANDLER"});
});
```
