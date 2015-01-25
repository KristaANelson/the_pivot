[![Code Climate](https://codeclimate.com/github/mikedao/dinner_dash/badges/gpa.svg)](https://codeclimate.com/github/mikedao/dinner_dash) [![Stories in Ready](https://badge.waffle.io/mikedao/dinner_dash.png?label=ready&title=Ready)](http://waffle.io/mikedao/dinner_dash)



## Dinner Dash

This jam was brought to you by Emily Berkeley, Michael Dao, Krista Nelson and
Nathan Owsiany.

This project is for the second module at the Turing School of Software and
Design.

Full project specifications are available here:
http://tutorials.jumpstartlab.com/projects/dinner_dash.html

Emily Berkeley: https://github.com/EmilyMB

Michael Dao: https://github.com/mikedao

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
