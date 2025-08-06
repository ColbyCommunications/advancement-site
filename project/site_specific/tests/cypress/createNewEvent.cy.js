describe('Event Creation', () => {
    before(() => {
        // Login via UI and set cookies
        cy.visit('/wp/wp-admin/');
        cy.get('#user_login').type(Cypress.env('WP_USERNAME'));
        cy.get('#user_pass').type(Cypress.env('WP_PASSWORD'));
        cy.get('#wp-submit').click();
    });

    it('Creates a new event', () => {
        cy.visit('/wp/wp-admin/post-new.php?post_type=events');
        cy.get('.editor-post-title__input').type('My New Event');
        cy.get('.acf-field-646157c578254 input[type="text"]').type('August 6, 1970 1:00 pm');
        cy.get('.acf-field-6679a58545b3e input[type="text"]').type('August 6, 1970 2:00 pm');
        cy.get('.editor-post-publish-button__button').click();
        cy.wait(2000);

        cy.get(
            '.interface-interface-skeleton__actions .editor-post-publish-button__button'
        ).click();
        cy.wait(1000);

        // Verify page is published
        cy.get('.components-snackbar__content').should('contain', 'Post published.');
    });
});

describe('New Event', () => {
    it('Should match the new event', () => {
        cy.visit('/events/event-calendar/my-new-event/');
        cy.get('.text-group__heading > span').should('have.length', 3);
        cy.get('.text-group__subheading > span').should('have.length', 5);
    });
});

describe('New Event Calendar', () => {
    it('Should match the new event', () => {
        cy.visit('/events/past-events/');
        cy.get('.article-grid .grid > .article-grid__item:last-child h2').should('have.length', 3);
        cy.get(
            '.article-grid .grid > .article-grid__item:last-child .text-group__subheading'
        ).should('have.length', 11);
    });
});
