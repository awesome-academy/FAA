//= require js/gmap.api
//= require js/jquery.gmap

$(document).ready(function(){
  $('#google-map').gMap({
    address: 'Danang, Vietnam',
    maptype: 'ROADMAP',
    zoom: 14,
    doubleclickzoom: false,
    controls: {
      panControl: true,
      zoomControl: true,
      mapTypeControl: true,
      scaleControl: false,
      streetViewControl: false,
      overviewMapControl: false
    }
  });
})
