var gulp = require('gulp');
var gutil = require('gulp-util');
var jade = require('gulp-jade');
var wrap = require('gulp-wrap-amd');
var changed = require('gulp-changed');

var jade_compile = function(source_path, dest){

	var jadeOps = {
		client: true,
		basedir: process.cwd() + '/source/jade'
	};
 
	var stream = gulp.src(source_path)
		.pipe( changed(dest, {extension: '.js'}) )
		.pipe( jade(jadeOps) )
			.on( 'error', gutil.log )
		.pipe( wrap({
			deps: ['jade', 'underscore'], 
			params: ['jade', '_']
			}) 
		)
	return stream
};

gulp.task('jade:main', function(){
	source = SourceDir + '/jade/**/*.jade'
	dest = './public/js/templates'
	jade_compile(source, dest).pipe(gulp.dest(dest))
});

gulp.task('jade:modules', function(){
	source = SourceDir + '/coffee/**/*.jade'
	dest = './public/js'
	jade_compile(source, dest).pipe(gulp.dest(dest))
});

// Compile Jade
gulp.task('jade', ['jade:modules', 'jade:main']);