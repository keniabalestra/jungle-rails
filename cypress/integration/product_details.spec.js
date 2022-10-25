
describe('Visiting the home page', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("Opens details page once product article is clicked ", () => {
    cy.get(".products article").first().click();
  });

});