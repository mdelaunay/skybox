# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ -> 
  $('#clear-all-files').click -> 
    resp = prompt "Attention, vous êtes sur le point d'effacer tous les fichiers du document.\nPour confirmer, saisissez exactement 'Effacer tous les fichiers' : "
    if resp is "Effacer tous les fichiers"
      data_id = $('#clear-all-files').attr("data-id")
      window.location.href = "http://"+location.host+"/documents/"+data_id+"/clear_files";
    else alert "Vous avez saisit '" + resp + "'.\nLes fichiers ne seront pas effacés."  if resp?
