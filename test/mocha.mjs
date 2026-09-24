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
    expect(await res.text()).to.equal("boo, path:/ztestabap, method:GET, request_method:GET, info:");
    expect(res.headers.get("content-type")).to.include("text/plain");
    expect(res.headers.get("content-length")).to.equal("59");
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

  it('test5: path_translated_expanded', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test5');
    expect(res.status).to.equal(200);
    expect(await res.text()).to.equal("/ztestabap/test5");
  });

  it('test6: query_string', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test6?foo=bar');
    expect(res.status).to.equal(200);
    expect(await res.text()).to.equal("foo=bar");
  });

  it('test7: form_fields', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test7?foo=bar&MOO=BOO');
    expect(res.status).to.equal(200);
    expect((await res.text()).trimEnd()).to.equal(`foo=bar
moo=BOO
foo=bar
MOO=BOO`);
  });

  it('test8: implicit content type', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test8');
    expect(res.status).to.equal(200);
    expect(res.headers.get("content-type")).to.include("text/html");
  });
  it('test9: form fields from a posted form body', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test9', {
      method: 'POST',
      headers: {'content-type': 'application/x-www-form-urlencoded'},
      body: 'name=hello+world&sign=%26%3D&caf%C3%A9=ok'});
    expect(res.status).to.equal(200);
    expect(await res.text()).to.equal(`name=hello world
sign=&=
caf\u00e9=ok
get_form_field:hello world`);
  });

  it('test9: a charset parameter on the form content type', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test9', {
      method: 'POST',
      headers: {'content-type': 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: 'name=x'});
    expect(await res.text()).to.equal(`name=x
get_form_field:x`);
  });

  it('test9: body fields come before query string fields', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test9?name=query&q=1', {
      method: 'POST',
      headers: {'content-type': 'application/x-www-form-urlencoded'},
      body: 'name=body'});
    expect(await res.text()).to.equal(`name=body
name=query
q=1
get_form_field:body`);
  });

  it('test9: a body that is not a form gives no fields', async () => {
    const res = await fetch('http://localhost:3030/ztestabap/test9?q=1', {
      method: 'POST',
      headers: {'content-type': 'text/plain'},
      body: 'name=body'});
    expect(await res.text()).to.equal(`q=1
get_form_field:`);
  });
});
