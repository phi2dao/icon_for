require "spec_helper"

RSpec.describe IconFor::IconSet do
  context "when initialized with a hash" do
    subject :set do
      set = {
        "types" => {
          "text/*" => "text",
          "text/html" => "code"
        },
        "icons" => {
          "text" => "file-text-o",
          "code" => "file-code-o",
          "fallback" => "file-o"
        }
      }
      IconFor::IconSet.new set
    end

    context "when given a known mime type" do
      it "should return an icon string" do
        expect(set["text/html"]).to eq "file-code-o"
      end
    end

    context "when given a known media type" do
      it "should return an icon string" do
        expect(set["text/css"]).to eq "file-text-o"
      end
    end

    context "when given an unknown mime type" do
      it "should return a fallback" do
        expect(set["error/x-text"]).to eq "file-o"
      end
    end
  end

  context "when initialized with a file" do
    subject :set do
      File.open IconFor::PATH + "/fa.json" do |file|
        IconFor::IconSet.new file
      end
    end

    context "when given a mime type" do
      it "should return an icon string" do
        expect(set["text/html"]).to eq "file-code-o"
      end
    end

    context "with a prefix" do
      before { IconFor.config.prefix = "fa-" }
      after { IconFor.config.prefix = nil }

      it "should have a prefix" do
        expect(set["text/html"]).to eq "fa-file-code-o"
      end
    end

    context "with a suffix" do
      before { IconFor.config.suffix = "-suffix" }
      after { IconFor.config.suffix = nil }

      it "should have a suffix" do
        expect(set["text/html"]).to eq "file-code-o-suffix"
      end
    end
  end
end

RSpec.describe IconFor do
  describe ".register" do
    context "when default: false" do
      before { IconFor.config.default = nil }

      it "should define a constant" do
        expect(IconFor.const_defined? :FA).to be_truthy
      end

      it "should create a new IconSet" do
        expect(IconFor::FA).to be_a IconFor::IconSet
      end

      it "should not be accessable from IconFor" do
        expect(IconFor["text/html"]).to_not eq IconFor::FA["text/html"]
      end
    end

    context "when default: true" do
      before { IconFor.config.default = :FA }

      it "should be accessable from IconFor" do
        expect(IconFor["text/html"]).to eq IconFor::FA["text/html"]
      end
    end
  end
end
