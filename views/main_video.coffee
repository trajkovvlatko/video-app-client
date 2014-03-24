class Video.MainVideo extends Backbone.View
  template: "#main_video_tpl"
  # className: "video"

  initialize: ->
    _.bindAll this, "render"

  render: ->
    container = $(@el)
    self = @
    if @options.videos
      @options.videos.each (video) ->
        template = _.template( $(self.template).html(), { video: video } )
        container.html(template)
    else
      video = new Video.VideoModel()
      video.url = window.Video.root_path + "videos/view/36"
      video.fetch
        success: =>
          video = new Video.VideoModel(video.get("0"))
          template = _.template( $(@template).html(), { video: video } )
          container.html(template)
          rtmp_video_path = "rtmp://192.168.0.103:1935/vod/mp4:2/135881aa04947e27c82999be01276888/135881aa04947e27c82999be01276888.transcoded.mp4"
          jwplayer("playerDvYNTTfdXjSG").setup
            file: rtmp_video_path
            image: video.get("thumbnail_url")
            title: video.get("title")
            width: "200px"
            height: "200px"
            fallback: "false"
    this
