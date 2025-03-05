#five oldest users on instagram
SELECT 
    *
FROM
    users
ORDER BY created_at ASC
LIMIT 5;


#users who have never posted a single post on instagram
SELECT 
    *
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.user_id IS NULL;

#user with most likes on a single photo
SELECT 
    photos.user_id,
    photos.id,
    COUNT(likes.photo_id) AS like_count
FROM
    photos
        LEFT JOIN
    likes ON photos.id = likes.photo_id
GROUP BY photos.id , photos.user_id
ORDER BY like_count DESC
LIMIT 1;

#top 5 most commonly used hashtags
SELECT 
    tag_name AS Popular_hashtags, COUNT(tag_name) AS occurance
FROM
    photo_tags
        INNER JOIN
    tags ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY occurance DESC
LIMIT 5;


#day of the week when most users register on instagram
SELECT 
    EXTRACT(DAY FROM created_at) AS best_day,
    COUNT(*) AS total_registration
FROM
    users
GROUP BY best_day
ORDER BY total_registration DESC
LIMIT 1;


#avg number of posts per user
SELECT 
    COUNT(id) / COUNT(DISTINCT user_id) AS avg_post, user_id
FROM
    photos
GROUP BY user_id;


#Total Average post
SELECT 
    COUNT(id) / COUNT(DISTINCT user_id) AS total_avg
FROM
    photos;

#fake accounts
SELECT 
    Likes.user_id
FROM
    likes
        INNER JOIN
    photos ON likes.photo_id = photos.id
GROUP BY likes.user_id
HAVING COUNT(DISTINCT likes.photo_id) = (SELECT 
        COUNT(*)
    FROM
        photos);