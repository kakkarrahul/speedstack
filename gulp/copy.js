var gulp = require('gulp');
var gutil = require('gulp-util');
var replace = require('gulp-replace');
var changed = require('gulp-changed');
gulp.task('copy:vendor', function(){
  //copy assets
  gulp
    .src(Assets.js.deps)
    .pipe(changed(Assets.js.path))
    .pipe(gulp.dest(Assets.js.path))
  gulp
    .src(Assets.css.deps)
    .pipe(changed(Assets.css.path))
    .pipe(gulp.dest(Assets.css.path))
  gulp
    .src(Assets.font.deps)
    .pipe(changed(Assets.font.path))
    .pipe(gulp.dest(Assets.font.path))

  // copy others
  Object.keys(Assets.others).map(function(path){
  	gulp.src(path)
      .pipe(changed(Assets.others[path]))
      .pipe(gulp.dest(Assets.others[path]));
  })
})

gulp.task('copy:fonts', function(){
  gulp
    .src('./vendor/fontawesome/css/font-awesome.css')
    .pipe(changed(Assets.css.path))
    .pipe(replace(/..\/fonts/g, '../../fonts'))
    .pipe(gulp.dest(Assets.css.path))
  
  gulp
    .src('./vendor/SourceSansPro/SourceSansPro.css')
    .pipe(changed(Assets.css.path))
    .pipe(replace(/\.\/fonts/g, '../../fonts'))
    .pipe(gulp.dest(Assets.css.path))
})

gulp.task('copy:img', function(){
  gulp
    .src([
      './source/img/**/*.{jpg,jpeg,png,gif,svg}',
      './favicon.ico'
    ])
    .pipe(changed(Assets.img.path))
    .pipe(gulp.dest(Assets.img.path))
});

gulp.task('copy', ['copy:vendor', 'copy:img', 'copy:fonts']);