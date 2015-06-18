var gulp = require('gulp');
var gutil = require('gulp-util');
var coffee = require('gulp-coffee');
var sourcemaps = require('gulp-sourcemaps');
var changed = require('gulp-changed');

gulp.task('coffee', function() {
	gulp.src( SourceDir + '/coffee/**/*.coffee')
		.pipe(changed( DestDir + '/js', {extension: '.js'}))
		.pipe(sourcemaps.init())
		.pipe(coffee())
			.on('error', gutil.log)
		.pipe(sourcemaps.write())
		.pipe(gulp.dest( DestDir + '/js' ))
});