-- creamos tabla base
create table reviews_raw(
  	review_id text,
  	order_id text,
  	review_score text,
  	review_comment_title text,
  	review_comment_message text,
  	review_creation_date text,
  	review_answer_timestamp text
)

--importamos csv

--creamos tabla reviews
create table reviews(
  	review_id text,
  	order_id text,
  	review_score int,
  	review_comment_title text,
  	review_comment_message text,
  	review_creation_date timestamp,
  	review_answer_timestamp timestamp
)

-- pasamos datos limpios
insert into reviews
select  review_id,
  		order_id,
  		review_score::int,
  		review_comment_title,
  		review_comment_message,
  		review_creation_date::timestamp,
  		review_answer_timestamp::timestamp
from reviews_raw;
drop table reviews_raw;