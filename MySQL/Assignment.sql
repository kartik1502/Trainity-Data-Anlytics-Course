USE ig_clone;

-- Rewarding Most Loyal Users: People who have been using the platform for the longest time.
-- Your Task: Find the 5 oldest users of the Instagram from the database provided
select * from users order by created_at LIMIT 5;

-- Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo.
-- Your Task: Find the users who have never posted a single photo on Instagram
select * from users u where u.id not in(select p.user_id from photos p);

-- Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
-- Your Task: Identify the winner of the contest and provide their details to the team
select username,p.id, count(*)
from users u 
inner join photos p on u.id = p.user_id
inner join likes l on p.id = l.photo_id group by p.id order by count(*) desc limit 1;

-- Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
-- Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform
select tg.tag_name,tag_id, count(*) as "Total_Tags" 
from tags tg, photo_tags pt 
where tg.id = pt.tag_id 
group by pt.tag_id 
order by Total_Tags  desc 
limit 5;

-- Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.
-- Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign
select dayname(created_at) as "Day_of_week", count(*) as "Count_days"
from users
group by Day_of_week
order by Count_days desc
limit 1;

-- User Engagement: Are users still as active and post on Instagram or they are making fewer posts
-- Your Task: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users
select 
count(*) / count(distinct user_id) as "Average user posts", 
count(id) as "number of photos", 
count(distinct user_id) as "Number of user" 
from photos;

-- Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts
-- Your Task: Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).
select u.username 
from likes l, users u
where l.user_id = u.id
group by user_id
having count(*) = (select count(*) from photos);