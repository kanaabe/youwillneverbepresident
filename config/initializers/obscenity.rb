# configuring the gem dictionary to allow certain words
Obscenity.configure do |config|
    config.whitelist   = ["aids", "baller", "balling", 
      "big baller", "bigballer", "cocaine", "condom", 
      "crap", "devil", "eggplant", "drugs", "flip",
      "hell", "genocide", "ho", "kill", "lsd", "marijuana",
      "murder", "pcp", "psilocybin", "redneck", "slope",
      "suicide", "transvestite", "transexual"]
  end