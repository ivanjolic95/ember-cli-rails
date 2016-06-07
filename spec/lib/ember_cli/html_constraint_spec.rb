require "ember_cli/html_constraint"

describe EmberCli::HtmlConstraint do
  describe "#matches?" do
    context %{when the format is "html"} do
      it "return true" do
        constraint = EmberCli::HtmlConstraint.new
        request = double(format: :html)

        expect(constraint.matches?(request)).to be true
      end
    end

    context %{when the format isn't "html"} do
      it "return false" do
        constraint = EmberCli::HtmlConstraint.new
        request = double(format: :json)

        expect(constraint.matches?(request)).to be false
      end
    end

    context %{when the user agent is google bot} do
      context %{when the format is "html"} do
        it "return true" do
          constraint = EmberCli::HtmlConstraint.new
          request = double(
            format: :html,
            user_agent: "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
          )

          expect(constraint.matches?(request)).to be true
        end
      end
      context %{when the format isn't "html"} do
        it "return true" do
          constraint = EmberCli::HtmlConstraint.new
          request = double(
            format: :json,
            user_agent: "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
          )

          expect(constraint.matches?(request)).to be true
        end
      end
    end

    context %"when the format is empty or nil" do
      context %{when the user agent is google bot} do
        it "return true" do
          constraint = EmberCli::HtmlConstraint.new
          nil_request = double(
            format: nil,
            user_agent: "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
          )
          empty_request = double(
            format: "",
            user_agent: "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
          )

          expect(constraint.matches?(nil_request)).to be true
          expect(constraint.matches?(empty_request)).to be true
        end
      end
      context %{when the user agent isn't google bot} do
        it "return false" do
          constraint = EmberCli::HtmlConstraint.new
          nil_request = double(format: nil)
          empty_request = double(format: "")

          expect(constraint.matches?(nil_request)).to be false
          expect(constraint.matches?(empty_request)).to be false
        end
      end
    end
  end
end
