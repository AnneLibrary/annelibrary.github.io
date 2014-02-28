module.exports = (grunt) ->
  require('time-grunt') grunt #実行時間の可視化用プラグイン
  grunt.initConfig
    coffee: #CoffeeScriptのコンパイル
      test:
        expand: true
        cwd: 'test/injectors/'
        src: '*.coffee'
        dest: 'int/injectors/'
        ext: '.js'
    webfont: #WebFontのビルド
      dev:
        src: 'src/icons/*.svg'
        dest: 'int/fonts/'
        destCss: 'int/css/'
        options:
          font: 'symbols'
          hashes: false
          types: 'eot,woff,ttf,svg'
          template: 'src/icons/symbols.css'
          htmlDemo: false
          ligatures: true
    cssjoin: #CSSファイルの@import処理
      dev:
        files:
          'int/css/style.css': ['src/css/style.css']
    copy: #単純にコピーするだけのものはここで処理
      dev:
        options:
          process: (content, srcpath) -> content + """\n    script src="../injectors/browser-sync.js" """
        files: [
          expand: true
          dest: 'int/slim/'
          cwd: 'src/slim/'
          src: ['{,*/}*.slim']
        ]
      build:
        files: [
          expand: true
          dest: 'build/'
          cwd: 'int/'
          src: ['fonts/**']
        ]
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
