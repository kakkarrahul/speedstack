module.exports = {
  js: {
    path: './public/js/vendor',
    deps: [
      './node_modules/jade/runtime.js',
      './vendor/jquery/dist/jquery.js',
      './vendor/underscore/underscore.js',
      './vendor/backbone/backbone.js',
      './vendor/marionette/lib/backbone.marionette.js',
      './vendor/backbone.radio/build/backbone.radio.js',
      './vendor/richmarker-amd/src/richmarker.js',
      './vendor/requirejs/require.js',
      './vendor/momentjs/moment.js',
      './vendor/typeahead.js/dist/typeahead.bundle.js',
      './vendor/bootstrap/dist/js/bootstrap.js',
      './vendor/chartjs/Chart.js'
    ]
  },
  css: {
    path: './public/css/vendor',
    deps: [
      './vendor/animate.css/animate.css',
      './vendor/bootstrap/dist/css/bootstrap.css'
    ]
  },
  img:{
    path: './public/img'
  },
  font: {
    path: './public/fonts',
    deps: [
      './vendor/fontawesome/fonts/fontawesome-webfont.*',
      './vendor/SourceSansPro/fonts/SourceSansPro-*'
    ]
  },
  others: {
    './vendor/require-css/css.js': './public/js',
    './vendor/require-css/css-builder.js': './public/js',
    './vendor/require-css/normalize.js': './public/js',
    './vendor/requirejs-plugins/src/async.js': './public/js'
  }
};