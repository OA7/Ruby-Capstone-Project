require_relative '../lib/load_file.rb'
require_relative '../lib/line_space.rb'
require_relative '../lib/indent_check.rb'

RSpec.describe LineSpace do
  let(:file) { 'spec/test_spec.css' }
  let(:new_file) { LoadFile.new(file) }
  let(:space_check) { LineSpace.new }
  let(:indent_check) { IndentationCheck.new }

  describe "#line_spacing_after \',\'" do
    it 'Returns an error for wrong spacing between selectors' do
      expect do
        space_check.line_spacing_after(1, new_file.file_content[0], ',')
      end.to output("1: x Expected single space after \",\"\n").to_stdout
    end
  end

  describe "#line_spacing_after \':\'" do
    it 'Returns an error for wrong spacing between attribute and value' do
      expect do
        space_check.line_spacing_after(2, new_file.file_content[1], ':')
      end.to output("2: x Expected single space after \":\"\n").to_stdout
    end
  end

  describe "#line_spacing_before \'{\'" do
    it 'Returns an error for wrong spacing between selector and opening curly brace' do
      expect do
        space_check.line_spacing_before(6, new_file.file_content[5], '{')
      end.to output("6: x Expected single space before \"{\"\n").to_stdout
    end
  end

  describe '#indentation_error?' do
    it 'Returns an error message for wrong indentation' do
      expect do
        indent_check.indentation_error?(new_file.file_content[7], 8)
      end.to output("8: x Expected 2 space indentation\n").to_stdout
    end
  end
end
