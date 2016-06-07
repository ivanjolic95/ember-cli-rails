module EmberCli
  class HtmlConstraint
    def matches?(request)
      matches = request.format.to_s =~ /html/ || 
        user_agent(request) =~ /Google/ || -1

      matches > -1
    end

    def user_agent(request)
      if request.respond_to?(:user_agent)
        request.user_agent
      else
        ""
      end
    end
  end
end
