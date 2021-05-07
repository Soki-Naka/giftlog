module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
<<<<<<< HEAD
    require('postcss-preset-env')({
=======
    require('postcss-preset-env')
    ({
>>>>>>> origin/master
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
