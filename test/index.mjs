import express from 'express';
import {initializeABAP} from "../output/init.mjs";
import {cl_express_icf_shim} from "../output/cl_express_icf_shim.clas.mjs";
await initializeABAP();

const PORT = 3000;

const app = express();
app.set('etag', false);
app.use(express.raw({type: "*/*"}));

// ------------------

app.get('/', function (req, res) {
  res.send('path: /');
});

// ------------------

app.all("/abap", async function (req, res) {
  await cl_express_icf_shim.run({req, res, class: "ZCL_HTTP_HANDLER"});
});

app.listen(PORT);
console.log("Listening on port http://localhost:" + PORT);