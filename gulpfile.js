var gulp = require('gulp');

Assets = require('./gulp/assets');

SourceDir = process.cwd() + '/source';
DestDir   = process.cwd() + '/public';

require('./gulp/copy')
require('./gulp/coffee')
require('./gulp/stylus')
require('./gulp/jade')
require('./gulp/watch')


gulp.task('build', ['copy', 'coffee', 'stylus', 'jade']);
gulp.task('default', ['build', 'watch']);