(function() {
  var images, imagesLoaded, imagesPath, imagesToLoad, serviceURL, urlSegs;
  images = [];
  urlSegs = window.location.pathname.split("/");
  serviceURL = imagesPath = '';
  imagesToLoad = imagesLoaded = 0;
  if (urlSegs.length === 2) {
    serviceURL = urlSegs[1] + '_images';
    imagesPath = urlSegs[1] === 'places' ? 'images/logos/' : 'images/categories/';
    $.getJSON(serviceURL, function(imageNames) {
      var i, _results;
      imagesToLoad = imageNames.length;
      _results = [];
      for (i in imageNames) {
        if (i < imageNames.length) {
          _results.push(new (Image().src = imagesPath + imageNames[i] + '.png'));
        }
      }
      return _results;
    });
  }
}).call(this);
