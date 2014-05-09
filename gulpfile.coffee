gulp = require 'gulp'
loadPlugins = require 'gulp-load-plugins'
$ = loadPlugins(lazy: true) 
gutil = require 'gulp-util'
require 'coffee-script/register'

dir =
  dist: __dirname + '/dist'
  tests: __dirname + '/test'
  source: __dirname + '/lib'

dirGlobs = 
  base: __dirname + '/**/*.coffee'
  dist: dir.dist + '/**/*.coffee'
  tests: dir.tests + '/*.coffee'
  source: dir.source + '/**/*.coffee'


gulp.task 'build', ->
  gulp.src([dirGlobs.dist])
        .pipe(
          $.coffee().on('error', (err) -> console.log err) 
        )
        .pipe(gulp.dest dir.dist)

gulp.task 'clean', ->
  gulp.src(dir.dist, read: false)
    .pipe $.clean()

gulp.task 'test', ->
  gulp.src(dirGlobs.tests)
      .pipe $.mocha (reporter:'spec')


gulp.task 'lint', ->
  gulp.src([dirGlobs.source,dirGlobs.tests])
        .pipe($.coffeelint())
        .pipe($.coffeelint.reporter())


gulp.task 'watch-test', ->
  gulp.watch dirGlobs.tests,['test']
  gulp.watch dirGlobs.source,['test']
