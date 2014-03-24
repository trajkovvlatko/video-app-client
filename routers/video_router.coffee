class Video.VideoRouter extends Backbone.Router

  routes:
    "" : "index"
    "home" : "index"
    "videos" : "my_videos"
    "admin_videos" : "admin_videos"
    "upload" : "index"
    "videos/view/:id" : "view"

  initialize: ->
    _.extend(Video.VideoRouter.prototype, Video.Utils)
    console.log "Video router initialized"

  index: ->
    @render_defaults()

  my_videos: ->
    console.log "my videos"
    action = "my_videos"
    @render_index_videos(action)

  admin_videos: ->
    action = "admin_videos"
    @render_index_videos(action)

  render_index_videos: (action) ->
    self = @
    console.log "render_index_videos"
    @set_before_ajax()
    @render_main_menu()
    @render_featured_videos()
    @videos = new Video.Videos()
    @videos.url = window.Video.root_path + "videos/#{action}"
    @videos.fetch
      success: =>
        console.log action
        if action == "admin_videos"
          @my_videos_view = new Video.AdminVideos({ collection: @videos })
        else
          @my_videos_view = new Video.MyVideos({ collection: @videos })
        $(".video-container").html @my_videos_view.render().el
      error: (collection, response, options) ->
        self.handle_unauthorized() if response.status == 401

  view: (id) ->
    @set_before_ajax()
    @render_main_menu()
    @render_featured_videos()
    videos = new Video.Videos()
    videos.url = window.Video.root_path + "videos/view/" + id
    videos.fetch
      success: ->
        @main_video = new Video.MainVideo({ videos: videos })
        $(".video-container").html @main_video.render().el
        main_video = videos.models[0]
        main_video_path = main_video.get("transcoded_file_url")
        main_video_path = main_video_path.replace("http://192.168.0.103/video-app-uploads/", "")
        rtmp_video_path = "rtmp://192.168.0.103:1935/vod/mp4:" + main_video_path
        console.log rtmp_video_path

        jwplayer("playerDvYNTTfdXjSG").setup
          file: rtmp_video_path
          image: main_video.get("thumbnail_url")
          title: main_video.get("title")
          width: "200px"
          height: "200px"
          fallback: "false"
