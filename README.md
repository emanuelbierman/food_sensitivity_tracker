# Food Intolerance Tracker

Discover the effect that the food that you eat has on your body by tracking your food and symptoms.


## Installing

To see a demo of this tracker in action, please see my [homepage][].

To get it running yourself:

$ git clone

$ bundle install

$ rake db:migrate

$ rake db:seed

$ thin start --ssl

To enable OmniAuth login via Facebook, use the [OmniAuth docs][] and the [OmniAuth::Facebook docs][] (you'll need to supply your own key and secret in the ```.env``` file).

## Contributing

[Contributions][] are welcome.

## License

[MIT License][]

[]: https://emanuelbierman.com
[]: https://github.com/omniauth/omniauth#getting-started
[]: https://github.com/mkdynamic/omniauth-facebook#configuring
[]: https://github.com/emanuelbierman/food_intolerance_tracker/issues
[]: https://opensource.org/licenses/MIT
