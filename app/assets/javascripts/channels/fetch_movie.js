$(function () {
  let movies = $("[data-movie-title]")
  if(movies.length) {
    fetchMoviesDetails(movies)
  }
})

function fetchMoviesDetails(movies) {
  App.cable.subscriptions.create({ channel: "FetchMovieChannel", id: uuidv4() }, {
    connected: function () {
      movies.each((_index, movie) => {
        let title = $(movie).attr('data-movie-title')
        this.perform('fetch_movie', { title })
      })
    },

    received: function (data) {
      updateMovies(data)
    }
  })
}

function updateMovies({ title, poster, rating, plot }) {
  let movies = $(`[data-movie-title='${title}']`)
  movies.each((_i, movie) => {
    $(movie).find('[data-movie="poster"]').attr("src", poster)
    $(movie).find('[data-movie="rating"]').text(`${rating}/10`)
    let plotEl = $(movie).find('[data-movie="plot"]')
    plotEl.text(plot)
    plotEl.addClass("movie__plot--filled-in")
  })
}
