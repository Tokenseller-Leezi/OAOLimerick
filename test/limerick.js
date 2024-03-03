const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Limerick", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployFixture() {

    // Contracts are deployed using the first signer/account by default
    const [owner] = await ethers.getSigners();

    const OAOLimerick = await ethers.deployContract("OAOLimerick", [
      "0xb880D47D3894D99157B52A7F869aB3B1E2D4349d",
    ]);

    return { OAOLimerick };
  }

  describe("Deployment", function () {
    it("Should set the right unlockTime", async function () {
      await loadFixture(deployFixture);
    });
  });

  describe("Requests", function () {
    it("Should currentId be 0", async function () {
      const { OAOLimerick } = await loadFixture(deployFixture);
      await expect(
        OAOLimerick.requestLimerick("flower", { value: 5000000000000000 })
      ).to.be.ok;
    });
  });
});
