# frozen_string_literal: true

require File.expand_path('./main')

describe Enumerable do
  let(:array1) { [1, 2, 3, 4, 5] }
  let(:array2) { %w[star wars] }
  describe '#my_each' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(array1.my_each.is_a?(Enumerable)).to eql(true)
      end
    end
    context 'If block is given' do
      it 'Return each element in an array' do
        expect(array1.my_each { |x| x }).to eql(0..4)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(array1.my_each_with_index.is_a?(Enumerable)).to eql(true)
      end
    end
    context 'If block is given' do
      it 'Return each element with index in an array' do
        arr = []
        array1.my_each_with_index { |x, i| arr[i] = x.to_i }
        expect(arr).to eql([1, 2, 3, 4, 5])
      end
    end
  end

  describe '#my_select' do
    context 'If block is not given' do
      it 'Return enumerable object' do
        expect(array1.my_select.is_a?(Enumerable)).to eql(true)
      end
    end
    context 'If block is given' do
      it 'Return elements in an array that meets given condition' do
        expect(array1.my_select { |x| x < 2 }).to eql([1])
      end
    end
  end

  describe '#my_any?' do
    context 'If no arguments are given' do
      it 'Return true if any elements meets true condition' do
        expect(array1.my_any?).to eql(true)
      end
    end
    context 'If arguments are given' do
      it 'Return true if any elements meets block condition' do
        expect(array1.my_any? { |x| x < 2 }).to eql(true)
      end
    end
  end

  describe '#my_none?' do
    context 'If no arguments are given' do
      it 'Return false if none of the elements meets true condition' do
        expect(array1.my_none?).to eql(false)
      end
    end
    context 'If arguments are given' do
      it 'Return false if none of the elements meets block condition' do
        expect(array1.my_none? { |x| x < 2 }).to eql(false)
      end
    end
  end

  describe '#my_all?' do
    context 'If no arguments are given' do
      it 'Return true if all elements meets true condition' do
        expect(array1.my_all?).to eql(true)
      end
    end
    context 'If arguments are given' do
      it 'Return true if all elements meets block condition' do
        expect(array1.my_all? { |x| x < 6 }).to eql(true)
      end
    end
  end
end
