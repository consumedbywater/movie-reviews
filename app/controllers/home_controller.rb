class HomeController < ApplicationController
  def index
    @recent_reviews = Review.get_five_most_recent_reviews
    @recent_movies = Review.get_five_most_recently_reviewed_movies
    @reviews = Review.all
    @movies = [Movie.new(id: 1, title: "Movie Title 1", release_date: "September 22, 2018", image_location: "star-filled.png", rating: 3, genres: ["Action", "Comedy"]),
               Movie.new(id: 2, title: "Movie Title 2", release_date: "September 3, 2017", image_location: "star-filled.png", rating: 4, genres: ["Adventure", "Science Fiction"])]
  end

  def about
  end

  def movies
    movieJSON = '{
      "page": 1,
      "total_results": 378037,
      "total_pages": 18902,
      "results": [
          {
              "vote_count": 358,
              "id": 439079,
              "video": false,
              "vote_average": 6,
              "title": "The Nun",
              "popularity": 250.681,
              "poster_path": "/sFC1ElvoKGdHJIWRpNB3xWJ9lJA.jpg",
              "original_language": "en",
              "original_title": "The Nun",
              "genre_ids": [
                  27,
                  9648,
                  53
              ],
              "backdrop_path": "/fgsHxz21B27hOOqQBiw9L6yWcM7.jpg",
              "adult": false,
              "overview": "When a young nun at a cloistered abbey in Romania takes her own life, a priest with a haunted past and a novitiate on the threshold of her final vows are sent by the Vatican to investigate. Together they uncover the order’s unholy secret. Risking not only their lives but their faith and their very souls, they confront a malevolent force in the form of the same demonic nun that first terrorized audiences in “The Conjuring 2,” as the abbey becomes a horrific battleground between the living and the damned.",
              "release_date": "2018-09-05"
          },
          {
              "vote_count": 125,
              "id": 346910,
              "video": false,
              "vote_average": 5.3,
              "title": "The Predator",
              "popularity": 231.276,
              "poster_path": "/wMq9kQXTeQCHUZOG4fAe5cAxyUA.jpg",
              "original_language": "en",
              "original_title": "The Predator",
              "genre_ids": [
                  27,
                  878,
                  28,
                  35
              ],
              "backdrop_path": "/deGN469i1I4HGYTRhvlztSbWXVL.jpg",
              "adult": false,
              "overview": "From the outer reaches of space to the small-town streets of suburbia, the hunt comes home. Now, the universe’s most lethal hunters are stronger, smarter and deadlier than ever before, having genetically upgraded themselves with DNA from other species. When a young boy accidentally triggers their return to Earth, only a ragtag crew of ex-soldiers and a disgruntled science teacher can prevent the end of the human race.",
              "release_date": "2018-09-13"
          },
          {
              "vote_count": 8017,
              "id": 299536,
              "video": false,
              "vote_average": 8.3,
              "title": "Avengers: Infinity War",
              "popularity": 230.807,
              "poster_path": "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
              "original_language": "en",
              "original_title": "Avengers: Infinity War",
              "genre_ids": [
                  12,
                  878,
                  28
              ],
              "backdrop_path": "/lmZFxXgJE3vgrciwuDib0N8CfQo.jpg",
              "adult": false,
              "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.",
              "release_date": "2018-04-25"
          },
          {
              "vote_count": 1555,
              "id": 348350,
              "video": false,
              "vote_average": 6.7,
              "title": "Solo: A Star Wars Story",
              "popularity": 174.43,
              "poster_path": "/4oD6VEccFkorEBTEDXtpLAaz0Rl.jpg",
              "original_language": "en",
              "original_title": "Solo: A Star Wars Story",
              "genre_ids": [
                  28,
                  12,
                  878
              ],
              "backdrop_path": "/96B1qMN9RxrAFu6uikwFhQ6N6J9.jpg",
              "adult": false,
              "overview": "Through a series of daring escapades deep within a dark and dangerous criminal underworld, Han Solo meets his mighty future copilot Chewbacca and encounters the notorious gambler Lando Calrissian.",
              "release_date": "2018-05-15"
          },
          {
              "vote_count": 1492,
              "id": 353081,
              "video": false,
              "vote_average": 7.3,
              "title": "Mission: Impossible - Fallout",
              "popularity": 166.278,
              "poster_path": "/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg",
              "original_language": "en",
              "original_title": "Mission: Impossible - Fallout",
              "genre_ids": [
                  12,
                  28,
                  53
              ],
              "backdrop_path": "/a9fRqsl6P27qxbDSb4pBXNv9Fwl.jpg",
              "adult": false,
              "overview": "When an IMF mission ends badly, the world is faced with dire consequences. As Ethan Hunt takes it upon himself to fulfill his original briefing, the CIA begin to question his loyalty and his motives. The IMF team find themselves in a race against time, hunted by assassins while trying to prevent a global catastrophe.",
              "release_date": "2018-07-25"
          },
          {
              "vote_count": 3291,
              "id": 351286,
              "video": false,
              "vote_average": 6.5,
              "title": "Jurassic World: Fallen Kingdom",
              "popularity": 153.56,
              "poster_path": "/c9XxwwhPHdaImA2f1WEfEsbhaFB.jpg",
              "original_language": "en",
              "original_title": "Jurassic World: Fallen Kingdom",
              "genre_ids": [
                  28,
                  12,
                  878
              ],
              "backdrop_path": "/3s9O5af2xWKWR5JzP2iJZpZeQQg.jpg",
              "adult": false,
              "overview": "Three years after the demise of Jurassic World, a volcanic eruption threatens the remaining dinosaurs on the isla Nublar, so Claire Dearing, the former park manager, recruits Owen Grady to help prevent the extinction of the dinosaurs once again.",
              "release_date": "2018-06-06"
          },
          {
              "vote_count": 848,
              "id": 345940,
              "video": false,
              "vote_average": 6.1,
              "title": "The Meg",
              "popularity": 122.968,
              "poster_path": "/xqECHNvzbDL5I3iiOVUkVPJMSbc.jpg",
              "original_language": "en",
              "original_title": "The Meg",
              "genre_ids": [
                  28,
                  878,
                  53,
                  27
              ],
              "backdrop_path": "/rH79sB6Nkx4cMW3JzsUy7wK0rhX.jpg",
              "adult": false,
              "overview": "A deep sea submersible pilot revisits his past fears in the Mariana Trench, and accidentally unleashes the seventy foot ancestor of the Great White Shark believed to be extinct.",
              "release_date": "2018-08-09"
          },
          {
              "vote_count": 20,
              "id": 135870,
              "video": false,
              "vote_average": 4.2,
              "title": "Rebel",
              "popularity": 122.914,
              "poster_path": "/dNTzorrVmcJ25fUGzs9FfkoXb0P.jpg",
              "original_language": "te",
              "original_title": "రెబెల్",
              "genre_ids": [
                  28
              ],
              "backdrop_path": "/yCGEkEqy7uOo7NwlbgOzGrI8i43.jpg",
              "adult": false,
              "overview": "Rebel is a romantic action revenge drama, which revolves around the story of a happy-go-lucky guy. The hero (Prabhas) is the son of a good-natured mafia don (Krishnam Raju). The hero becomes Rebel after his father is killed. How he takes revenge upon the people, who killed his father, will form the second half of the movie. Apart from directing, Raghava Lawrence also handles the choreography, screenplay and music direction for the film. The film is being produced by J. Bhaghawan and J. Pulla Rao under Sri Balaji Cine Media banner.",
              "release_date": "2012-09-28"
          },
          {
              "vote_count": 4893,
              "id": 383498,
              "video": false,
              "vote_average": 7.5,
              "title": "Deadpool 2",
              "popularity": 118.424,
              "poster_path": "/to0spRl1CMDvyUbOnbb4fTk3VAd.jpg",
              "original_language": "en",
              "original_title": "Deadpool 2",
              "genre_ids": [
                  28,
                  35,
                  878
              ],
              "backdrop_path": "/3P52oz9HPQWxcwHOwxtyrVV1LKi.jpg",
              "adult": false,
              "overview": "Wisecracking mercenary Deadpool battles the evil and powerful Cable and other bad guys to save a boys life.",
              "release_date": "2018-05-15"
          },
          {
              "vote_count": 23,
              "id": 507569,
              "video": false,
              "vote_average": 5.2,
              "title": "The Seven Deadly Sins: Prisoners of the Sky",
              "popularity": 111.455,
              "poster_path": "/r6pPUVUKU5eIpYj4oEzidk5ZibB.jpg",
              "original_language": "ja",
              "original_title": "劇場版 七つの大罪 天空の囚われ人",
              "genre_ids": [
                  28,
                  12,
                  14,
                  16
              ],
              "backdrop_path": "/uKwOX7MtKlAaGeCQe6c4jc1vZpj.jpg",
              "adult": false,
              "overview": "The Seven Deadly Sins travel to a remote land in search of the phantom ingredient \"sky fish.\" Meliodas and Hawk end up at a \"Sky Palace\" that exists above the clouds, where all the residents have wings. Meliodas is mistaken for a boy who committed a crime and is thrown in prison. Meanwhile, the residents are preparing a ceremony for defense against a ferocious beast that awakens once every 3,000 years. But the Six Knights of Black, a Demon Clan army, arrives and removes the seal on the beast in order to threaten the lives of the residents of Sky Palace. Meliodas and his allies meet the Six Knights of Black in battle.",
              "release_date": "2018-08-18"
          },
          {
              "vote_count": 8065,
              "id": 284054,
              "video": false,
              "vote_average": 7.4,
              "title": "Black Panther",
              "popularity": 100.458,
              "poster_path": "/uxzzxijgPIY7slzFvMotPv8wjKA.jpg",
              "original_language": "en",
              "original_title": "Black Panther",
              "genre_ids": [
                  28,
                  12,
                  14,
                  878
              ],
              "backdrop_path": "/b6ZJZHUdMEFECvGiDpJjlfUWela.jpg",
              "adult": false,
              "overview": "King TChalla returns home from America to the reclusive, technologically advanced African nation of Wakanda to serve as his countrys new leader. However, TChalla soon finds that he is challenged for the throne by factions within his own country as well as without. Using powers reserved to Wakandan kings, TChalla assumes the Black Panther mantel to join with girlfriend Nakia, the queen-mother, his princess-kid sister, members of the Dora Milaje (the Wakandan special forces) and an American secret agent, to prevent Wakanda from being dragged into a world war.",
              "release_date": "2018-02-13"
          },
          {
              "vote_count": 1614,
              "id": 402900,
              "video": false,
              "vote_average": 7,
              "title": "Oceans Eight",
              "popularity": 87.901,
              "poster_path": "/MvYpKlpFukTivnlBhizGbkAe3v.jpg",
              "original_language": "en",
              "original_title": "Oceans Eight",
              "genre_ids": [
                  80,
                  35,
                  28,
                  53
              ],
              "backdrop_path": "/scQf03Fm3jeyv4FH04qvi4fp4wh.jpg",
              "adult": false,
              "overview": "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century at New Yorks annual Met Gala.",
              "release_date": "2018-06-07"
          },
          {
              "vote_count": 24,
              "id": 390845,
              "video": false,
              "vote_average": 3.7,
              "title": "A Delicious Flight",
              "popularity": 79.05,
              "poster_path": "/kGlBKJBosHTA4elgHS54olzD4oS.jpg",
              "original_language": "ko",
              "original_title": "맛있는 비행",
              "genre_ids": [
                  10749
              ],
              "backdrop_path": "/4MJkbiDU5lr6TAwSLPV14C9w0vs.jpg",
              "adult": false,
              "overview": "The in- flight service for Hong Kong starts now!  An erotic story that took place in the spacious blue sky!  An innocent actress runs away from the scandal with an idol, the impudent idol that ruined her career, a passionate manager who is devoted to her and his ex-girlfriend who is now a sexy stewardess. These four that should never be together run into each other in an airplane. No one can run away and the most cheeky and erotic things happen here.",
              "release_date": "2015-11-01"
          },
          {
              "vote_count": 33,
              "id": 460885,
              "video": false,
              "vote_average": 6.8,
              "title": "Mandy",
              "popularity": 70.225,
              "poster_path": "/m0yf7J7HsKeK6E81SMRcX8vx6mH.jpg",
              "original_language": "en",
              "original_title": "Mandy",
              "genre_ids": [
                  28,
                  14,
                  27,
                  53
              ],
              "backdrop_path": "/7UYdlNrL0mI9MzoqSyCvN3PJrvH.jpg",
              "adult": false,
              "overview": "The Shadow Mountains, 1983. Red and Mandy lead a loving and peaceful existence; but when their pine-scented haven is savagely destroyed, Red is catapulted into a phantasmagoric journey filled with bloody vengeance and laced with fire.",
              "release_date": "2018-05-12"
          },
          {
              "vote_count": 670,
              "id": 447200,
              "video": false,
              "vote_average": 6,
              "title": "Skyscraper",
              "popularity": 69.816,
              "poster_path": "/5LYSsOPzuP13201qSzMjNxi8FxN.jpg",
              "original_language": "en",
              "original_title": "Skyscraper",
              "genre_ids": [
                  28,
                  53,
                  18
              ],
              "backdrop_path": "/oMKFQmoVgB69fyXfSMu0lGlHJP2.jpg",
              "adult": false,
              "overview": "Framed and on the run, a former FBI agent must save his family from a blazing fire in the worlds tallest building.",
              "release_date": "2018-07-11"
          },
          {
              "vote_count": 3819,
              "id": 158015,
              "video": false,
              "vote_average": 6.1,
              "title": "The Purge",
              "popularity": 68.603,
              "poster_path": "/tGGJOuLHX7UDlTz57sjfhW1qreP.jpg",
              "original_language": "en",
              "original_title": "The Purge",
              "genre_ids": [
                  878,
                  27,
                  53
              ],
              "backdrop_path": "/1sZ9Nnic1ldHhHttAMDmNxaNM04.jpg",
              "adult": false,
              "overview": "Given the countrys overcrowded prisons, the U.S. government begins to allow 12-hour periods of time in which all illegal activity is legal. During one of these free-for-alls, a family must protect themselves from a home invasion.",
              "release_date": "2013-05-31"
          },
          {
              "vote_count": 3048,
              "id": 238636,
              "video": false,
              "vote_average": 6.6,
              "title": "The Purge: Anarchy",
              "popularity": 67.961,
              "poster_path": "/l1DRl40x2OWUoPP42v8fjKdS1Z3.jpg",
              "original_language": "en",
              "original_title": "The Purge: Anarchy",
              "genre_ids": [
                  27,
                  53
              ],
              "backdrop_path": "/zWGAnbxjjwY3xFGuOeR26LGbBlG.jpg",
              "adult": false,
              "overview": "One night per year, the government sanctions a 12-hour period in which citizens can commit any crime they wish -- including murder -- without fear of punishment or imprisonment. Leo, a sergeant who lost his son, plans a vigilante mission of revenge during the mayhem. However, instead of a death-dealing avenger, he becomes the unexpected protector of four innocent strangers who desperately need his help if they are to survive the night.",
              "release_date": "2014-07-17"
          },
          {
              "vote_count": 604,
              "id": 462919,
              "video": false,
              "vote_average": 7.2,
              "title": "Sierra Burgess Is a Loser",
              "popularity": 66.973,
              "poster_path": "/vjnHRySiVM4YcBYzjCxw344y9g.jpg",
              "original_language": "en",
              "original_title": "Sierra Burgess Is a Loser",
              "genre_ids": [
                  35,
                  18,
                  10749
              ],
              "backdrop_path": "/fdFIVBpq57ZbHok07SI3gNLWUbO.jpg",
              "adult": false,
              "overview": "A case of mistaken identity results in unexpected romance when the most popular girl in high school and the biggest loser must come together to win over their crushes.",
              "release_date": "2018-09-07"
          },
          {
              "vote_count": 8278,
              "id": 284053,
              "video": false,
              "vote_average": 7.5,
              "title": "Thor: Ragnarok",
              "popularity": 66.111,
              "poster_path": "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg",
              "original_language": "en",
              "original_title": "Thor: Ragnarok",
              "genre_ids": [
                  28,
                  12
              ],
              "backdrop_path": "/kaIfm5ryEOwYg8mLbq8HkPuM1Fo.jpg",
              "adult": false,
              "overview": "Thor is on the other side of the universe and finds himself in a race against time to get back to Asgard to stop Ragnarok, the prophecy of destruction to his homeworld and the end of Asgardian civilization, at the hands of an all-powerful new threat, the ruthless Hela.",
              "release_date": "2017-10-25"
          },
          {
              "vote_count": 649,
              "id": 442249,
              "video": false,
              "vote_average": 6,
              "title": "The First Purge",
              "popularity": 63.531,
              "poster_path": "/2slvblTroiT1lY9bYLK7Amigo1k.jpg",
              "original_language": "en",
              "original_title": "The First Purge",
              "genre_ids": [
                  28,
                  27,
                  878,
                  53
              ],
              "backdrop_path": "/dnaitaoCh8MftfYEVnprcuYExZp.jpg",
              "adult": false,
              "overview": "To push the crime rate below one percent for the rest of the year, the New Founding Fathers of America test a sociological theory that vents aggression for one night in one isolated community. But when the violence of oppressors meets the rage of the others, the contagion will explode from the trial-city borders and spread across the nation.",
              "release_date": "2018-07-04"
          }
      ]
  }'
    render plain: movieJSON
  end

  def genres
    render plain: '{
        "genres": [
          {
            "id": 28,
            "name": "Action"
          },
          {
            "id": 12,
            "name": "Adventure"
          },
          {
            "id": 16,
            "name": "Animation"
          },
          {
            "id": 35,
            "name": "Comedy"
          },
          {
            "id": 80,
            "name": "Crime"
          },
          {
            "id": 99,
            "name": "Documentary"
          },
          {
            "id": 18,
            "name": "Drama"
          },
          {
            "id": 10751,
            "name": "Family"
          },
          {
            "id": 14,
            "name": "Fantasy"
          },
          {
            "id": 36,
            "name": "History"
          },
          {
            "id": 27,
            "name": "Horror"
          },
          {
            "id": 10402,
            "name": "Music"
          },
          {
            "id": 9648,
            "name": "Mystery"
          },
          {
            "id": 10749,
            "name": "Romance"
          },
          {
            "id": 878,
            "name": "Science Fiction"
          },
          {
            "id": 10770,
            "name": "TV Movie"
          },
          {
            "id": 53,
            "name": "Thriller"
          },
          {
            "id": 10752,
            "name": "War"
          },
          {
            "id": 37,
            "name": "Western"
          }
        ]
      }'
  end

  def movie
    render inline: 'hi'
  end
end