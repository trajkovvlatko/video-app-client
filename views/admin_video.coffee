class Video.AdminVideo extends Backbone.View
  template: "#admin_video_tpl"
  className: "my-video"

  events:
    "click .js-delete" : "delete"
    "click .js-featured" : "featured"

  initialize: ->
    _.extend(Video.AdminVideo.prototype, Video.Utils)
    _.bindAll this, "render"

  render: ->
    if localStorage.user_type == "admin"
      container = $(@el)
      @video = @options.video
      @id = @video.id
      template = _.template( $(@template).html(), { video: @video } )
      container.html(template)
      this

  delete: (e) ->
    console.log "delete"
    self = @
    if confirm("Are you sure you want to delete this video?") == true
      $.ajax  window.Video.root_path + "videos/#{@id}?token=#{localStorage.token}",
        method: "DELETE"
        success: ->
          $(self.el).remove()
          console.log "deleted"
        error: (jqXHR, textStatus, errorThrow) ->
          self.handle_unauthorized() if jqXHR.status == 401

  featured: (e) ->
    console.log "featured"
    self = @
    update_video = new Video.VideoModel()
    update_video.url = "#{window.Video.root_path}videos/#{@id}?token=#{localStorage.token}"
    if $(e.target).prop("checked")
      update_video.set({ id: @id, featured: "1" })
    else
      update_video.set({ id: @id, featured: "0" })
    update_video.save null,
      success: ->
        self.render_featured_videos()
        console.log "success featured"
      error: (jqXHR, textStatus, errorThrow) ->
        self.handle_unauthorized() if jqXHR.status == 401
