gulp         = require 'gulp'
rename       = require 'gulp-rename'
iconfont     = require 'gulp-iconfont'
consolidate  = require 'gulp-consolidate'
cssimport    = require 'gulp-cssimport'
autoprefixer = require 'gulp-autoprefixer'
minifyCss    = require 'gulp-minify-css'
browserSync  = require 'browser-sync'
reload       = browserSync.reload

fontName = 'anne-library' # set name of your symbol font
template = 'fontawesome-style' # you can also choose 'foundation-style'

gulp.task 'symbols', ->
  gulp.src './icons/*.svg'
    .pipe iconfont fontName: fontName
    .on 'codepoints', (codepoints) ->
      options = 
        glyphs: codepoints
        fontName: fontName
        fontPath: '../fonts/'
        className: 'ai'
      gulp.src "./templates/#{template}.css"
        .pipe consolidate 'lodash', options
        .pipe rename basename: fontName
        .pipe gulp.dest 'css/' # set path to export your CSS
    .pipe gulp.dest 'fonts/' # set path to export your fonts

gulp.task 'css', ->
  gulp.src './css/style.css'
  .pipe cssimport()
  .pipe autoprefixer 'last 2 versions'
  .pipe minifyCss keepSpecialComments: 0
  .pipe rename extname: '.join.css'
  .pipe gulp.dest './css/'

gulp.task 'watch', ->
  browserSync.init
    notify: false
    server:
      baseDir: './'
  gulp.watch ['./css/**/*.css', '!./css/style.join.css'], ['css']
  gulp.watch ['./icons/*.svg'], ['symbols']
  gulp.watch ['./css/style.join.css', './index.html'], reload
