require_relative '../phase3/controller_base'
require_relative './session'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      super
      @session.store_session(@res)
    end

    def render_content(content, content_type)
      super
      @session.store_session(@res)
    end

    # method exposing a `Session` object
    def session
      @session ||= Phase4::Session.new(@req)
      #parse request, construct session from it
    end
  end
end
