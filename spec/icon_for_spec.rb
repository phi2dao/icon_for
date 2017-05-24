require "spec_helper"

RSpec.describe IconFor::IconSet do
  context "when initialized with a hash" do
    subject :set do
      IconFor::IconSet.new({
        "types" => {
          "text/plain" => "text"
        },
        "icons" => {
          "text" => "file-text-o"
        }
      })
    end

    it "should return an icon string" do
      expect(set["text/plain"]).to be_a String
    end
  end

  context "when initialized with a string" do
    subject :set do
      IconFor::IconSet.new <<~JSON
        {
          "types": {
            "text/plain": "text"
          },
          "icons": {
            "text": "file-text-o"
          }
        }
      JSON
    end

    it "should return an icon string" do
      expect(set["text/plain"]).to be_a String
    end
  end

  context "when initialized with a file" do
    subject :set do
      File.open IconFor::PATH + "/fa.json" do |file|
        IconFor::IconSet.new file
      end
    end

    it "should return an icon string" do
      expect(set["text/plain"]).to be_a String
    end
  end

  context "with different mime types" do
    subject :set do
      File.open IconFor::PATH + "/fa.json" do |file|
        IconFor::IconSet.new file
      end
    end

    it "should match known mime types" do
      expect(set["text/plain"]).to eq "file-text-o"
    end

    it "should match known media types" do
      expect(set["audio/mp4"]).to eq "file-audio-o"
    end

    it "should fallback on unknown mime types" do
      expect(set["font/ttf"]).to eq "file-o"
    end
  end

  context "with different options" do
    subject :set do
      File.open IconFor::PATH + "/fa.json" do |file|
        IconFor::IconSet.new file
      end
    end

    it "should prepend prefixes" do
      expect(set["text/plain", prefix: "fa-"]).to eq "fa-file-text-o"
    end

    it "should append suffixes" do
      expect(set["text/plain", suffix: "-fa"]).to eq "file-text-o-fa"
    end
  end
end
