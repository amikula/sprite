module Sprite
  module Styles
    # renders standard css style rules
    class CssGenerator
      def initialize(builder)
        @builder = builder
      end

      def write(path, sprite_files)
        # set up class_name to append to each rule
        sprites_class = @builder.config['sprites_class'] ? ".#{@builder.config['sprites_class']}" : ""

        # write styles to disk
        File.open(File.join(Sprite.root, path), 'w') do |f|
          # write stylesheet file to disk
          sprite_files.each do |sprite_file, sprites|
            sprites.each do |sprite|
              # if sprite name ends with some of special states, consider this a state
              # for example if the sprite name is 'image_hover' and 'hover' is among states, set sprite_name to image:hover
              sprite_name = sprite[:name].gsub /(.*)(_)(#{@builder.config['pseudo_classes'].join "|"})$/, '\1:\3'

              f.puts "#{sprites_class}.#{sprite[:group]}#{@builder.config['class_separator']}#{sprite_name} {"
              f.puts "  background: url('/#{@builder.config['image_output_path']}#{sprite_file}') no-repeat #{sprite[:x]}px #{sprite[:y]}px;"
              f.puts "  width: #{sprite[:width]}px;"
              f.puts "  height: #{sprite[:height]}px;"
              f.puts "}"
            end
          end
        end
      end

      def extension
        "css"
      end
    end
  end
end
