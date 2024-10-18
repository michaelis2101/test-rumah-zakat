class APISettings {
  String apikey = '30279d13a8b7b9917908970b520fa054';
  String endpoint = 'https://api.openweathermap.org/data/2.5/weather?';
  //usage
  //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  String forecast =
      'https://api.openweathermap.org/data/2.5/forecast?';
  
  //usage
  //api.openweathermap.org/data/2.5/forecast?q=Bandung&appid=30279d13a8b7b9917908970b520fa054&cnt=5

  String provinceEndpoint =
      'https://emsifa.github.io/api-wilayah-indonesia/api/provinces.json';

  String cityEndpoint =
      'https://emsifa.github.io/api-wilayah-indonesia/api/regencies';
  //usage city api
  //https://emsifa.github.io/api-wilayah-indonesia/api/regencies/{provinceId}.json
}
