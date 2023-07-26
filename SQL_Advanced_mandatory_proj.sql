/* Q1. Create an ER diagram or draw a schema for the given database. */
/* Ans1. Database -> Reverse Engineer */

/* Q2. We want to reward the user who has been around the longest, Find the 5 oldest users. */
Select * from users
order by created_at
limit 5;

/* Q3. To target inactive users in an email ad campaign, find the users who have never posted a photo. */
Select id, username from users
where id NOT IN(Select user_id from photos)
order by id;

/* Q4. Suppose you are running a contest to find out who got the most likes on a photo. Find out who won? */
With cte as
(Select photo_id, count(user_id) as likes_count from likes
group by photo_id
order by likes_count desc
limit 1)
Select u.id as User_ID, u.username as Username, cte.photo_id as Photo_ID, cte.likes_count as Total_Likes
from users u inner join photos p on u.id = p.user_id join cte on cte.photo_id = p.id;


/* Q5. The investors want to know how many times does the average user post. */
Select round(avg(posts)) as Num_of_Posts_On_Average 
from (Select user_id, count(id) as posts from photos
group by user_id) average_posts;


/* Q6. A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags. */
With CTE as
(Select tag_id, count(photo_id) as No_Of_Times_Used from photo_tags
group by tag_id
order by 2 desc
limit 5)
Select t.tag_name as Top_Five_Tags, CTE.No_Of_Times_Used from tags t
join CTE on t.id = CTE.tag_id;


/* Q7. To find out if there are bots, find users who have liked every single photo on the site. */
Create view Bots as
(Select u.id as User_ID, u.username as Bot_name from users u
where u.id IN (Select user_id from (Select user_id, count(photo_id) as total_photos_liked from likes
group by user_id
having total_photos_liked = (Select count(*) from photos)) bots_table)
order by 1);


/* Q8. Find the users who have created InstagramId in may and select top 5 newest joinees from it? */
Delimiter //
Create procedure New_joinees( IN month_name varchar(10) )
begin
Select id as User_ID,username as Username,created_at as Creation_Date_Time from users 
where monthname(created_at) = month_name
order by created_at desc
limit 5;
end //
delimiter ;


/* Q9. Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos? */
With cte1 as
(Select user_id, count(id) as pp from photos group by user_id),
cte2 as
(Select user_id, count(photo_id) as lp from likes group by user_id)
Select u.id as User_ID, u.username as Insta_Username, cte1.pp as Posted_Photos_Count,
cte2.lp as Liked_Photos_Count
from users u
inner join cte1 on u.id = cte1.user_id
inner join cte2 on u.id = cte2.user_id
where username regexp '^C.*[0-9]$';


/* Q10. Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5. */
Select u.id as User_ID , u.username as Username, (Select count(p.id) from photos p where u.id = p.user_id) as photos_posted, created_at
from users u
where (Select count(p.id) from photos p where u.id = p.user_id) 
between 3 and 5
order by photos_posted desc, created_at asc
limit 30;
