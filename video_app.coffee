window.Video = {
  initialize: ->
    console.log "Video app initialized"
    window.video_router = new Video.VideoRouter()
    window.Video.root_path = "http://192.168.0.102:8080/restapi/api/"
    Backbone.history.start()
}

