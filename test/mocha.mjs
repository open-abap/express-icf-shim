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

  it('basic 200 with text', async () => {
    const res = await fetch('http://localhost:3030/abap');
    expect(res.status).to.equal(200);
    expect(await res.text()).to.equal("boo, path:/abap, method:GET");
  });

  it('test2', async () => {
    expect(1).to.equal(1);
  });
});