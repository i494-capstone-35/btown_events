(function() {
  var imagesPath, serviceURL, urlSegs;
  urlSegs = window.location.pathname.split("/");
  serviceURL = imagesPath = '';
  if (urlSegs.length === 2) {
    serviceURL = urlSegs[1] + '_images';
    imagesPath = urlSegs[1] === 'places' ? 'images/logos/' : 'images/categories/';
    $.getJSON(serviceURL, function(imageNames) {
      var i, _results;
      _results = [];
      for (i in imageNames) {
        if (i < imageNames.length) {
          _results.push((new Image()).src = imagesPath + imageNames[i] + '.png');
        }
      }
      return _results;
    });
  }
}).call(this);
