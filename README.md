

## The Pivot || HubStub

**LIVE HERE:** Hubstub.us

*This three week group Ruby on Rails project was a pivot from a food ordering site into a market place for both buying and selling event tickets. It featured a session based shopping cart, Administrative Dashboard, and filter based queries.*

HubStub was brought to you by Scott Crawford, Bhargavi Satpathy, Krista Nelson and
Nathan Owsiany.

This project is for the third module at the Turing School of Software and
Design.

Full project specifications are available here:
http://tutorials.jumpstartlab.com/projects/the_pivot.html

Scott Crawford: https://github.com/ScottCrawford03

Bhargavi Satpathy: https://github.com/bhargavisatpathy

Krista Nelson: https://github.com/KristaANelson

Nathan Owsiany: https://github.com/ndwhtlssthr

## Notes

To get this to run locally, you need to run the following:

    brew install imagemagick

### Here's what you'll need to do after pulling to get it working on heroku
* `bundle install`
* `git push heroku master`
* `heroku pg:reset`
* `heroku run rake db:schema:load db:seed`
* `heroku open` and look at all the glorious menu/item images
