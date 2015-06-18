var gulp = require('gulp');
var gutil = require('gulp-util');
var livereload = require('gulp-livereload')

gulp.task('watch', function() {
	livereload.listen();

	gulp.watch('./source/coffee/**/*.coffee', ['coffee'])
	gulp.watch('./source/stylus/**/*.styl', ['stylus:main'])
	gulp.watch('./source/jade/**/*.jade', ['jade:main'])
	gulp.watch('./source/coffee/**/*.styl', ['stylus:modules'])
	gulp.watch('./source/coffee/**/*.jade', ['jade:modules'])

	var compiled = [
		'./public/js/**/*.js',
		'./public/js/**/*.css',
		'./public/css/**/*.css',
	];
	var watched = gulp.watch(compiled)
	watched.on('change', livereload.changed);
	watched.on('add', livereload.changed);
	watched.on('unlink', livereload.changed);

});