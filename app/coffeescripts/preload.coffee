images = []
urlSegs = window.location.pathname.split("/")
serviceURL = imagesPath = ''
imagesToLoad = imagesLoaded = 0

if urlSegs.length == 2
    serviceURL = urlSegs[1] + '_images'
    imagesPath = if urlSegs[1] == 'places' then 'images/logos/' else 'images/categories/'
    $.getJSON serviceURL, (imageNames) ->
        imagesToLoad = imageNames.length
        for i of imageNames when i < imageNames.length
            new Image().src = imagesPath + imageNames[i] + '.png'


