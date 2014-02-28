module.exports = (grunt) ->
  require('time-grunt') grunt #実行時間の可視化用プラグイン
  grunt.initConfig
    webfont: #WebFontのビルド
      dev:
        src: 'icons/*.svg'
        dest: 'fonts/'
        destCss: 'css/'
        options:
          font: 'symbols'
          hashes: false
          types: 'eot,woff,ttf,svg'
          template: 'icons/symbols.css'
          htmlDemo: false
          ligatures: true
    cssjoin: #CSSファイルの@import処理
      dev:
        files:
          'css/style.join.css': ['css/style.css']
    #監視用の設定
    watch:
      cssjoin:
        files: ['src/**/*.css']
        tasks: ['cssjoin']
      webfont:
        files: ['src/icons/*.svg']
        tasks: ['webfont']
    #ブラウザシンク
    browser_sync:
      dev:
        bsFiles:
          src: [
            'src/**/*.css'
            'int/css/symbols.css'
            'int/js/*.js'
            'int/html/*.html'
          ]
        options:
          watchTask: true
          injectChanges: false #@importで読み込むCSSをインジェクションできないバグの回避

  require('load-grunt-tasks')(grunt)

  #aliases
  grunt.registerTask 'default', [
    'browser_sync', 'watch'
  ]
