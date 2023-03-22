import fetch from 'cross-fetch';
import {expect} from 'chai';
import {startServer} from './start.mjs';

describe('Integration Test', async () => {
  let server;

  before(async () => {
    server = await startServer(true);
  });

  after(async () => {
    server.close();
  });

  it('root unknown', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/');
    expect(res.status).to.equal(200);
    expect(await res.text()).to.equal("unknown path");
  });

  it('test1: basic 200 with text', async () => {
    const res = await fetch('http://localhost:3030/ztestabap');
    expect(res.status).to.equal(200);
    expect(await res.text()).to.equal("boo, path:/ztestabap, method:GET, info:");
    expect(res.headers.get("content-type")).to.include("text/plain")
    expect(res.headers.get("content-length")).to.equal("39");
  });

  it('test2: content-type via set_header_field', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test2');
    expect(res.status).to.equal(200);
    expect(await res.text()).to.equal("<b>hello /test2<b>");
    expect(res.headers.get("content-type")).to.include("text/html")
  });

  it('test3: set cache-control header field', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test3');
    expect(res.status).to.equal(200);
    expect(res.headers.get("cache-control") || "").to.include("no-store")
  });

  it('test4: request_uri', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test4');
    expect(res.status).to.equal(200);
    expect(await res.text()).to.equal("/ztestabap/test4");
  });

  it('test4: request_uri with query', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test4?foo=bar');
    expect(res.status).to.equal(200);
    expect(await res.text()).to.equal("/ztestabap/test4?foo=bar");
  });
});