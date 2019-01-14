# Food Intolerance Tracker

Discover the effect that the food that you eat has on your body by tracking your food and symptoms.


## Installing

To see a demo of this tracker in action, please see my [homepage][1].

To get it running yourself:

```
$ git clone

$ bundle install

$ rake db:migrate

$ rake db:seed

$ thin start --ssl
```

To enable OmniAuth login via Facebook, use the [OmniAuth docs][2] and the [OmniAuth::Facebook docs][3] (you'll need to supply your own key and secret in the `.env` file).

## Contributing

[Contributions][4] are welcome.

## License

[MIT License][5]

[1]: https://emanuelbierman.com
[2]: https://github.com/omniauth/omniauth#getting-started
[3]: https://github.com/mkdynamic/omniauth-facebook#configuring
[4]: https://github.com/emanuelbierman/food_intolerance_tracker/issues
[5]: https://opensource.org/licenses/MIT
