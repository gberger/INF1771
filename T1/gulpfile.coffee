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
	for glob in ['./src/*.html', './src/lib/*', './src/img/*', './src/data']
		gulp.src glob
			.pipe gulp.dest './build/'

gulp.task 'coffee', ->
	gulp.src './src/js/*'
		.pipe coffee().on('error', gutil.log)
		.pipe rename extname: '.js'
		.pipe gulp.dest './build/js/'

gulp.task 'sass', ->
	gulp.src './src/css/*'
		.pipe sass().on('error', gutil.log)
		.pipe rename extname: '.css'
		.pipe gulp.dest './build/css/'

gulp.task 'build', ['clean', 'copy', 'coffee', 'sass']
gulp.task 'default', ['build']
