# encoding: utf-8

require 'spec_helper'

ALL = Campbell::Glyph.from(:outer_n)
  .to(:outer_ne)
  .to(:outer_se)
  .to(:outer_s)
  .to(:outer_sw)
  .to(:outer_nw)
  .to(:outer_n)

  # ⠀⠀⢀⠤⠒⠑⠢⢄⡀⠀⠀
  # ⡔⠊⠁⠀⠀⠀⠀⠀⠈⠒⡄
  # ⡇⠀⠐⠀⠀⠀⠀⠐⠀⠀⡇
  # ⡇⠀⢀⠀⠀⠁⠀⢀⠀⠀⡇
  # ⢇⡀⠀⠀⠀⠀⠀⠀⠀⣀⠇
  # ⠀⠈⠒⠤⣀⢀⡠⠔⠉⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


ATTACK = Campbell::Glyph.from(:outer_sw)
  .to(:inner_nw)
  .to(:outer_n)
  .to(:inner_ne)
  .to(:outer_se)

  # ⠀⠀⠀⠀⡰⠱⡀⠀⠀⠀⠀
  # ⠄⠀⠀⡰⠁⠀⠱⡀⠀⠀⠄
  # ⠀⠀⡔⠁⠀⠀⠀⠘⡄⠀⠀
  # ⠀⡜⢀⠀⠀⠁⠀⢀⠘⢄⠀
  # ⠜⠀⠀⠀⠀⠀⠀⠀⠀⠈⠆
  # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


LESS_THAN = Campbell::Glyph.from(:outer_s)
  .to(:outer_sw)
  .to(:inner_sw)
  .to(:center)

  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠀⠐⠀⠀⠀⠀⠐⠀⠀⠀
  # ⠀⠀⢀⠤⠒⠁⠀⢀⠀⠀⠀
  # ⢔⡊⠁⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠈⠒⠤⣀⠀⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


BREATHE = Campbell::Glyph.from(:outer_nw, :center, :outer_ne)

# ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
# ⢄⡀⠀⠀⠀⠀⠀⠀⠀⣀⠄
# ⠀⠈⠑⠤⣀⢀⡠⠔⠊⠀⠀
# ⠀⠀⢀⠀⠀⠁⠀⢀⠀⠀⠀
# ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


LESS_THAN = Campbell::Glyph.from(:outer_s)
  .to(:outer_sw)
  .to(:inner_sw)
  .to(:center)

  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠀⠐⠀⠀⠀⠀⠐⠀⠀⠀
  # ⠀⠀⢀⠤⠒⠁⠀⢀⠀⠀⠀
  # ⢔⡊⠁⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠈⠒⠤⣀⠀⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


CLEAR = Campbell::Glyph.from(:outer_n)
  .to(:center)
  .to(:outer_s)

  # ⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⡇⠀⠀⠀⠀⠄
  # ⠀⠀⠐⠀⠀⡇⠀⠐⠀⠀⠀
  # ⠀⠀⢀⠀⠀⡇⠀⢀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⡇⠀⠀⠀⠀⠄
  # ⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


OPEN = Campbell::Glyph.from(:outer_s)
  .to(:inner_sw)
  .to(:inner_se)
  .to(:outer_s)

  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠀⠐⠀⠀⠀⠀⠐⠀⠀⠀
  # ⠀⠀⢀⣀⣀⣁⣀⣀⠀⠀⠀
  # ⠄⠀⠈⢢⠀⠀⢠⠃⠀⠀⠄
  # ⠀⠀⠀⠀⢣⢠⠃⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


USE = Campbell::Glyph.from(:center)
  .to(:inner_se)
  .to(:outer_ne)

  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄
  # ⠀⠀⠐⠀⠀⠀⠀⠐⢀⠜⠀
  # ⠀⠀⢀⠀⠀⠑⠢⢄⠎⠀⠀
  # ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
  # ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  # ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀


GLYPHS = {
  :all => ALL,
  :attack => ATTACK,
  :breathe => BREATHE,
  :capture => LESS_THAN + USE,
  :clear => CLEAR,
  :clear_all => CLEAR + ALL,
  :die => BREATHE.horizontal_mirror,
  :open => OPEN,
  :open_all => OPEN + ALL,
  :use => USE,
}

describe Campbell do
  it 'has a version number' do
    expect(Campbell::VERSION).not_to be nil
  end

  describe 'the text renderer' do
    it 'renders the ALL glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:all])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⢀⠤⠒⠑⠢⢄⡀⠀⠀
        ⡔⠊⠁⠀⠀⠀⠀⠀⠈⠒⡄
        ⡇⠀⠐⠀⠀⠀⠀⠐⠀⠀⡇
        ⡇⠀⢀⠀⠀⠁⠀⢀⠀⠀⡇
        ⢇⡀⠀⠀⠀⠀⠀⠀⠀⣀⠇
        ⠀⠈⠒⠤⣀⢀⡠⠔⠉⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end

    it 'renders the ATTACK glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:attack])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⠀⠀⡰⠱⡀⠀⠀⠀⠀
        ⠄⠀⠀⡰⠁⠀⠱⡀⠀⠀⠄
        ⠀⠀⡔⠁⠀⠀⠀⠘⡄⠀⠀
        ⠀⡜⢀⠀⠀⠁⠀⢀⠘⢄⠀
        ⠜⠀⠀⠀⠀⠀⠀⠀⠀⠈⠆
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end

    it 'renders the BREATHE glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:breathe])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
        ⢄⡀⠀⠀⠀⠀⠀⠀⠀⣀⠄
        ⠀⠈⠑⠤⣀⢀⡠⠔⠊⠀⠀
        ⠀⠀⢀⠀⠀⠁⠀⢀⠀⠀⠀
        ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end

    it 'renders the CAPTURE glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:capture])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
        ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄
        ⠀⠀⠐⠀⠀⠀⠀⠐⢀⠜⠀
        ⠀⠀⢀⠤⠒⠑⠢⢄⠎⠀⠀
        ⢔⡊⠁⠀⠀⠀⠀⠀⠀⠀⠄
        ⠀⠈⠒⠤⣀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end

    it 'renders the CLEAR glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:clear])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀
        ⠄⠀⠀⠀⠀⡇⠀⠀⠀⠀⠄
        ⠀⠀⠐⠀⠀⡇⠀⠐⠀⠀⠀
        ⠀⠀⢀⠀⠀⡇⠀⢀⠀⠀⠀
        ⠄⠀⠀⠀⠀⡇⠀⠀⠀⠀⠄
        ⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end

    it 'renders the CLEAR ALL glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:clear_all])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⢀⠤⠒⡗⠢⢄⡀⠀⠀
        ⡔⠊⠁⠀⠀⡇⠀⠀⠈⠒⡄
        ⡇⠀⠐⠀⠀⡇⠀⠐⠀⠀⡇
        ⡇⠀⢀⠀⠀⡇⠀⢀⠀⠀⡇
        ⢇⡀⠀⠀⠀⡇⠀⠀⠀⣀⠇
        ⠀⠈⠒⠤⣀⣇⡠⠔⠉⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end

    it 'renders the DIE glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:die])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
        ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
        ⠀⠀⠐⠀⠀⠀⠀⠐⠀⠀⠀
        ⠀⠀⢀⠤⠒⠑⠢⢄⡀⠀⠀
        ⠔⠊⠁⠀⠀⠀⠀⠀⠈⠒⠄
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end

    it 'renders the OPEN glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:open])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
        ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
        ⠀⠀⠐⠀⠀⠀⠀⠐⠀⠀⠀
        ⠀⠀⢀⣀⣀⣁⣀⣀⠀⠀⠀
        ⠄⠀⠈⢢⠀⠀⢠⠃⠀⠀⠄
        ⠀⠀⠀⠀⢣⢠⠃⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end

    it 'renders the OPEN ALL glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:open_all])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⢀⠤⠒⠑⠢⢄⡀⠀⠀
        ⡔⠊⠁⠀⠀⠀⠀⠀⠈⠒⡄
        ⡇⠀⠐⠀⠀⠀⠀⠐⠀⠀⡇
        ⡇⠀⢀⣀⣀⣁⣀⣀⠀⠀⡇
        ⢇⡀⠈⢢⠀⠀⢠⠃⠀⣀⠇
        ⠀⠈⠒⠤⣣⢠⡣⠔⠉⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end

    it 'renders the USE glyph' do
      output = Campbell::GlyphRenderer.render(GLYPHS[:use])
      expect(output).to eq <<-EOF.undent.chomp
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
        ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄
        ⠀⠀⠐⠀⠀⠀⠀⠐⢀⠜⠀
        ⠀⠀⢀⠀⠀⠑⠢⢄⠎⠀⠀
        ⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀
      EOF
    end
  end


  it 'terminates after rendering all the glyphs' do
    puts <<-EOF

    ## Glyphs

    EOF

    GLYPHS.each do |name, glyph|
      puts "### #{ name.to_s.upcase.tr('_', ' ') }"
      puts
      puts Campbell::GlyphRenderer.render(glyph)
      puts
    end
  end
end
