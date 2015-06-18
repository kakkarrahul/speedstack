var gulp = require('gulp');
var gutil = require('gulp-util');
var stylus = require('gulp-stylus');
var nib = require('nib');
var axis = require('axis');
var changed = require('gulp-changed');
var newer = require('gulp-newer');

var stylus_compile = function(source_path, dest, withAssets){
	var _imports = [
		'nib',
		'axis',
		process.cwd() + "/" + "source/stylus/variables",
		process.cwd() + "/" + "source/stylus/mixins/*"
	];
	if (!withAssets) { _imports = ['nib', 'axis'] }

	var config = {
		use:    [ nib(), axis() ],
		import: _imports,
		error : false,
		compress: true
	};

	if (process.env.NODE_ENV !== 'production'){
		config.sourcemap = { inline: true, comment: true };
		config.compress = false;
	}

	var stream =
		gulp
			.src(source_path)
			.pipe(newer(dest, {ext: '.css'}))
			.pipe(stylus(config)).on('error', gutil.log)
	return stream
};
gulp.task('stylus:main', function () {
	var src = './source/stylus/style.styl';
	var dest= './public/css';
	
	stylus_compile(src, dest, false).pipe(gulp.dest(dest));
});
gulp.task('stylus:modules', function(){
	var src = SourceDir + '/coffee/**/*.styl';
	var dest= DestDir + '/js';
	
	stylus_compile(src, dest, true).pipe(gulp.dest(dest));
});

// Compile Stylus
gulp.task('stylus', ['stylus:modules', 'stylus:main']);
