/*global describe, it, expect, Mopo */
describe("Mopo", function () {
  it("has a namespace for Models", function () {
    expect(Mopo.Models).toBeTruthy();
  });
  it("has a namespace for Collections", function () {
    expect(Mopo.Collections).toBeTruthy();
  });
  it("has a namespace for Views", function () {
    expect(Mopo.Views).toBeTruthy();
  });
  it("has a namespace for Routers", function () {
    expect(Mopo.Routers).toBeTruthy();
  });
});