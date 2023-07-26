/* Q1 - Write a SQL query to count the number of characters except for the spaces for each actor. 
		Return the first 10 actor's name lengths along with their names */
  
Select concat(first_name,' ',last_name) as Name_of_the_actor, length(concat(first_name, last_name)) as Length 
from actor limit 10;

/* Q2 - List all Oscar awardees (Actors who received the Oscar award) with their full names and 
        the length of their names. */

Select concat(first_name,' ',last_name) as Name_of_the_actor, length(concat(first_name, last_name)) as Length, awards 
from actor_award where awards like '%Oscar%';

/* Q3 - Find the actor who have acted in the film 'Frost Head' */

Select first_name, last_name, title from actor
inner join film_actor using (actor_id)
inner join film using (film_id)
where title = 'Frost Head';

/* Q4 - Pull all the films acted by the actor 'Will Wilson' */

Select title as Films_acted_by_Will_Wilson from actor
inner join film_actor using (actor_id)
inner join film using (film_id)
where first_name = 'Will' and last_name = 'Wilson';

/* Q5 - Pull all the films which were rented and returned in the month of May */

Select title as Films_rented_returned_in_May from film
inner join inventory using (film_id)
inner join rental using (inventory_id)
where month(rental_date) = 5 and month(return_date) = 5;

/* Q6 - Pull all the films with comedy category */

Select title as Film, name as Category from film
inner join film_category using (film_id)
inner join category using (category_id)
where name = 'Comedy';