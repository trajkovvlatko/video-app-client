class Video.UploadForm extends Backbone.View
  template: "#upload_form_tpl"
  className: "upload-form"

  initialize: ->
    _.extend(Video.UploadForm.prototype, Video.Utils)
    _.bindAll this, "render"

  events:
    "click .js-upload-cancel" : "cancel"
    "click .js-upload-confirm" : "confirm"

  render: ->
    self = @
    self.id = 0
    container = $(@el)
    template = _.template( $(@template).html() )
    container.html(template)
    console.log "test"
    $(@el).find('.js-upload-form').fileupload
      add: (e, data) ->
        console.log "add"
        data.form.context.action = window.Video.root_path + "videos/create?token=" + localStorage.token
        console.log data
        data.submit()
        container.find(".js-status").show().html("Starting upload.")
        container.find(".js-upload-confirm").show()
        container.find(".video-metadata").show()
      progress: (e, data) ->
        container.find(".js-status").show().html("Uploading...")
        console.log('progress')
      fail: (e, data) ->
        console.log('fail')
        container.find(".js-upload-confirm").hide()
        container.find(".js-status").show().html("Error.")
        container.find(".video-metadata").hide()
        self.handle_unauthorized() if data.jqXHR.status == 401
      done: (e, data) ->
        console.log data.result
        self.id = data.result[0].id
        console.log self.id
        container.find(".js-status").show().html("Upload successful.")
        container.find(".js-upload-confirm").show()
        container.find(".video-metadata").show()
    this

  cancel: (e) ->
    console.log "cancel"
    self = @
    e.preventDefault()
    $(".popup").html ""

  confirm: (e) ->
    console.log "confirm"
    e.preventDefault()
    self = @
    title = $(self.el).find(".js-video-title").val()
    description = $(self.el).find(".js-video-description").val()
    if title != ""
      video = new Video.VideoModel()
      video.url = window.Video.root_path + "videos/" + self.id + "?token=" + localStorage.token
      video.set({ id: self.id, title: title, description: description, confirmed: "1" })
      video.save null,
        success: ->
          window.location = "#videos/view/#{video.id}"
          $(".popup").html ""
    else
      $(self.el).find(".js-video-title").addClass "error"
