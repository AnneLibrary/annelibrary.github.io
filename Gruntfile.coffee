module.exports = (grunt) ->
  require('time-grunt') grunt #実行時間の可視化用プラグイン
  grunt.initConfig
    webfont: #WebFontのビルド
      dev:
        src: 'icons/*.svg'
        dest: 'fonts/'
        destCss: 'css/'
        options:
          font: 'anne-library'
          hashes: false
          types: 'eot,woff,ttf,svg'
          template: 'icons/tmpl.css'
          htmlDemo: false
          ligatures: true
    cssjoin: #CSSファイルの@import処理
      dev:
        files:
          'css/style.join.css': ['css/style.css']
    copy: #単純にコピーするだけのものはここで処理
      dev:
        files: [
          expand: true
          dest: 'fonts/'
          cwd: 'bower_components/font-awesome/fonts/'
          src: ['fontawesome-webfont.*']
        ,
          expand: true
          dest: 'css/'
          cwd: 'bower_components/font-awesome/css/'
          src: ['font-awesome.css']
        ]
    #監視用の設定
    watch:
      cssjoin:
        files: ['css/{,*/}*.css', '!css/*.join.css']
        tasks: ['cssjoin']
      webfont:
        files: ['icons/*.svg']
        tasks: ['webfont']
    #ブラウザシンク
    browser_sync:
      dev:
        bsFiles:
          src: [
            'css/{,*/}*.css'
            'js/{,*/}*.js'
            '{,*/}*.html'
          ]
        options:
          watchTask: true
          injectChanges: false #@importで読み込むCSSをインジェクションできないバグの回避

  require('load-grunt-tasks')(grunt)

  #aliases
  grunt.registerTask 'default', [
    'browser_sync', 'watch'
  ]
  grunt.registerTask 'build', [
    'webfont', 'cssjoin', 'copy'
  ]
