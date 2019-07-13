const Token = artifacts.require("MembershipVerificationToken");

contract("MembershipVerificationToken", function(accounts) {
  const OWNER = accounts[0];
  const ALICE = accounts[1];
  const BOB = accounts[2];

  let tokenInstance;

  beforeEach(async function () {
    tokenInstance = await Token.new();
  });

  describe.only("MembershipVerificationToken tests", () => {
    it("should add stock", async function () {
      await tokenInstance.add(100, "0x01");
      const actual = await tokenInstance._inventory(0);
      assert.equal(Number(actual[0]), 100, "Stock not correct");
    });
  });
});