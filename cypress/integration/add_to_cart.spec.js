describe('add_to_cart', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("Changes the count of the cart button when adding products to it", () => {
    cy.contains("My Cart (0)")
    cy.get(".btn").first().click({force: true})
    cy.contains("My Cart (1)")
  });

});