Video.Utils = {

  render_main_menu: ->
    @main_menu = new Video.MainMenu()
    $(".main-menu-container").html @main_menu.render().el

  validate_email: (email) ->
    pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i)
    pattern.test(email)

  render_featured_videos: ->
    $(".featured-container").html ""
    videos = new Video.Videos()
    videos.url = window.Video.root_path + "videos/featured"
    videos.fetch
      success: ->
        videos.each (video) ->
          @featured_video = new Video.FeaturedVideo(video: video)
          $(".featured-container").append @featured_video.render().el

  render_defaults: ->
    @render_main_menu()
    @render_featured_videos()
    @main_video = new Video.MainVideo()
    @set_before_ajax()
    $(".video-container").html @main_video.render().el

  handle_unauthorized: ->
    localStorage.removeItem('email')
    localStorage.removeItem('name')
    localStorage.removeItem('token')
    localStorage.removeItem('user_type')
    @render_main_menu()
    alert("Please login")

  set_before_ajax: ->
    if localStorage.token
      $.ajaxSetup beforeSend: (xhr) ->
        xhr.setRequestHeader "token", localStorage.token

}
