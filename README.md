# Hello!

Thanks for letting me complete this challenge. It was a lot of fun! While I can't guarantee it's bug-free, it's pretty robust, imho. What follows are a few thoughts about why I did things the way I did.

Custom Fields were by far the most interesting and challenging part of this project. I considered a few approaches before choosing one (which I'll explain below). Here are the pros and cons of each approach and why I eventually chose the one I did:

1. A custom_fields table with separate columns for each data type:
    - Pros: Since the assignment stipulates that the value will be a number, string, or array of strings, a table with separate columns for each data type would allow for easy validation.
    - Cons: Lots of useless fields. Given that each row would have only one of the three columns populated, the database would fill up with nulls, which take up space even though we aren't using them.
2. A custom_fields table with a field_type column:
    - Pros: Even easier validation, since we can validate on field_type and field_value together. If they don't match, it's not valid.
    - Cons: Using one column to keep track of the type of another column violates the [third normal form](https://www.snowflake.com/trending/data-normalization-flexible-data-science/) of database normalization. As the app grows, keeping the data normalized is good pratice.
3. A custom_fields table with a jsonb data column:
    - Pros: 1) Easily extensible. If we decide we want to start allowing booleans or hashes or anything else, it's no problem. It all gets stored as json regarldess. 2) Fast! Jsonb is binary, so it's very quick to translate into json. 3) Normalized! We can change the data in the data column without having to change any other columns.
    - Cons: Trickiest to implement on the frontend. We have to do a lot of playing around with JS objects before we pass them to Rails.
4. (Secret 4th Option) MongoDB and GraphQL: Since the data is inherently not in a normalized format, it makes sense to use something other than a relational database to store it. I think a key/value store like Mongo makes sense. We would then use GraphQL to make two trips: one to Postgres to grab Clients and Buildings, and one to Mongo to grab CustomFields. The assignment said I had to use Postgres, though, so that's what I did.
    - Pros: Gets around having to put un-normalized data into a relational database altogether.
    - Cons: More complicated, requires two DB roundtrips to get everything and package it up.

I ended up choosing option 3. It creates the least database bloat given the constraints of the assignment.

I used two gems: [dotenv](https://github.com/bkeepers/dotenv) to manage environment variables and [blueprinter](https://github.com/procore-oss/blueprinter) for JSON serialization. It's my fav JSON serialization library, the declarative syntax is *chef's kiss*.

To seed the db, run `docker compose exec web bundle exec rails db:reset`. I edited `docker-compose.yml` so the specs run every time the app builds. If you find that annoying, remove `bundle exec rspec` from `docker-compose.yml` on line 12.

Thanks for reading, and I hope you enjoy!

Taylor
