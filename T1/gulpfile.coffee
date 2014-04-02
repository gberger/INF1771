gulp   = require 'gulp'
gutil  = require 'gulp-util'
clean  = require 'gulp-clean'
coffee = require 'gulp-coffee'
sass   = require 'gulp-sass'
rename = require 'gulp-rename'

gulp.task 'clean', ->
	gulp.src './build/**/*', read: false
		.pipe clean()

gulp.task 'copy', ->
	gulp.src './src/**/*'
		.pipe gulp.dest './build'

gulp.task 'coffee', ->
	gulp.src './src/js/*.coffee'
		.pipe coffee().on('error', gutil.log)
		.pipe rename extname: '.js'
		.pipe gulp.dest './build/js/'

gulp.task 'sass', ->
	gulp.src './src/css/*.scss'
		.pipe sass().on('error', gutil.log)
		.pipe rename extname: '.css'
		.pipe gulp.dest './build/css/'

gulp.task 'build', ['clean', 'copy', 'coffee', 'sass']
gulp.task 'default', ['build']
