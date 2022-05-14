## openDevBook

A Ruby on Rails social media app for open-source contributors, based off of Facebook. Features include friends, friendship requests, notifications, posts, comments, and likes. 

### Demo

<img src='opendevbook.gif' alt='devbook_demo'>

### Live Version

You can find a [live version of openDevBook here](www.opendevbook.com). 

To test the most this app has to offer, `Log in with GitHub`, authentication for which is implemented using [Omniauth](https://github.com/omniauth/omniauth). This will auto-fill an initial post for you using GitHub's API, typing out a description of the most recent GitHub public project you're working on!

You'll also receive an automatic friend request from the test user - Jebediah Johnson, which you can accept in the `Friend Requests` tab.

*or*

Create an account by clicking `Sign Up` and filling out the form, authentication for which is implemented using [Devise](https://github.com/heartcombo/devise/). Just the same as a GitHub account creation, this will generate an automatic friend request you can accept. 

*or*

Log in with the test user's data:
email: test@gmail.com
password: 123456

### Development Features

- Automated integration tested using [RSPec](https://github.com/rspec/rspec-rails) and [Capybara](https://github.com/teamcapybara/capybara) to perform tests, alongside [Guard](https://github.com/guard/guard) to re-run tests with every code change, and [FactoryBot](https://github.com/thoughtbot/factory_bot)/[Faker](https://github.com/faker-ruby/faker) to generate test data. 
- GitHub API utilized with to request data regarding GitHub user's most recent repository, and the first sentence of that repository's readme. 
- Performance improved by resolving N+1 queries with eager loading. These were monitored through both the Linux terminal and with [Bullet](https://github.com/flyerhzm/bullet0)
- Behaviour driven development adhered to from beginning to end by planning data architecture (models, associations, schemas) around the user's actions and keeping user experience in mind with every added feature. 
- Styling performed with the [Tailwind CSS](https://tailwindcss.com/) framework to reduce cycle time. Tailwind was effortless to pick up and use having already acquired a solid understanding of the CSS concepts it utilizes. 
- PostgreSQL used exclusively from development to production over previously used SQLite to perform more complex queries

### Currently In Development
- Utilize AWS3 to host user uploaded profile pictures, facilitated through Active Storage

### Reflections
This project solidified my comfort planning, testing, and debugging larger scale Rails applications. I didn't run into any issues which I couldn't resolve by perusing documentation, conducting research, or `debug`ging my way through the MVC structure or interacting with the `rails console`. I believe part of this is also due to the planning I did prior to beginning the project, and another part is due to the quality of the integration tests I wrote. 

All in all this project was a joy to work on, and I'm looking forward to continueing implementing features for it.
