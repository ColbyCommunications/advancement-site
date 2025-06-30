describe('Give Button', () => {
    it('Should go to ways to give page', () => {
        cy.visit('/');
        cy.get('.header__utility > ul > li:first-child a').click();
        cy.location('pathname', { timeout: 3000 }).should('include', '/ways-to-give/give/');
    });
});
