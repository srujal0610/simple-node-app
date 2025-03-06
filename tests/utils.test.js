const { add, subtract } = require("../src/utils");

test("adds 5 + 3 to equal 8", () => {
    expect(add(5, 3)).toBe(8);
});

test("subtracts 10 - 7 to equal 3", () => {
    expect(subtract(10, 7)).toBe(3);
});

