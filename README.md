# Food Intolerance Tracker

Besides easily tracking your food and drink on a daily basis, this app will help you make simple but powerful correlations between how you feel right now and what you've been putting into your body over the last couple of days.

A quick [search][0] reveals that - in contrast to food allergies where 1) the symptoms are generally quite acute and obvious and 2) the body's response needs to be tested and confirmed in a laboratory - food intolerances are much harder to identify, diagnose and treat.

The chances are therefore reasonably high that you are living, right now, with one or more side effects of chronic food intolerance. This app will help you self-identify and self-diagnose those intolerances. As far as treatment goes, what you do with the information this app provides is entirely up to you!

## Installing

To see a demo of this tracker in action, please see my [homepage][1].

To get it running yourself on a remote server:

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

[0]: https://g.co/kgs/XiHh5w
[1]: https://emanuelbierman.com/food_intolerance_tracker
[2]: https://github.com/omniauth/omniauth#getting-started
[3]: https://github.com/mkdynamic/omniauth-facebook#configuring
[4]: https://github.com/emanuelbierman/food_intolerance_tracker/issues
[5]: https://opensource.org/licenses/MIT
