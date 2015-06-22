var gulp = require('gulp');
var spawn = require('child_process').spawn;
var gutil = require('gulp-util');

Assets = require('./gulp/assets');

SourceDir = process.cwd() + '/source';
DestDir   = process.cwd() + '/public';

require('./gulp/copy')
require('./gulp/coffee')
require('./gulp/stylus')
require('./gulp/jade')
require('./gulp/watch')


gulp.task('songs', function(cb){
	var child = spawn('python', ['scanner.py']);
	child.stdout.on('data', function(d){ return gutil.log(d.toString()); });
	child.stderr.on('data', function(d){ return gutil.log(d.toString()); });
	child.on('close', function(){cb();});
});

gulp.task('build', ['copy', 'coffee', 'stylus', 'jade']);
gulp.task('default', ['build', 'watch']);


module.exports = gulp;