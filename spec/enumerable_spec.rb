require 'enumerable'

describe Enumerable do
  let(:spec_num_arr) { [*1..20] }
  let(:spec_range) { (1..20) }
  let(:spec_hash) { { a: 1, b: 2, c: 3, d: 4 } }
  let(:word_array) { %w[a string very_long_string] }
  let(:test_array) { [*1..20].each(&:even?) }
  let(:test_range) { (1..20).each(&:even?) }
  let(:single_val_arr) { [1] }
  let(:empty_array) { [] }

  # my_each
  describe '#my_each' do
    context 'called on an array' do
      it 'returns the same value as the original given an array and a block' do
        expect(spec_num_arr.my_each(&:even?)).to eql(test_array)
      end

      it 'returns enumerator if array given without a block' do
        expect(spec_num_arr.my_each).to be_kind_of(Enumerable)
      end
    end

    context 'when used on a range' do
      it 'returns the same value as the original given a range and a block' do
        expect(spec_range.my_each(&:even?)).to eql(test_range)
      end

      it 'returns enumerator if a range given without a block' do
        expect(spec_range.my_each).to be_kind_of(Enumerable)
      end
    end
  end

  # my_each_with_index
  describe '#my_each_with_index' do
    context 'when operating on an array' do
      it 'returns the same value as the original given an array and a block' do
        expect(spec_num_arr.my_each_with_index { |a, b| a + b }).to eql(spec_num_arr.each_with_index { |a, b| a + b })
      end

      it 'returns enumerator if an array is given without a block' do
        expect(spec_num_arr.my_each).to be_kind_of(Enumerable)
      end
    end

    context 'when used on a range' do
      it 'returns enumerator if a range given without a block' do
        expect(spec_range.my_each).to be_kind_of(Enumerable)
      end

      it 'returns the same value as the original given a range and a block' do
        expect(spec_range.my_each_with_index { |a, b| a + b }).to eql(spec_range.each_with_index { |a, b| a + b })
      end
    end
  end

  # my_select
  describe '#my_select' do
    context 'operating on an array' do
      it 'returns enumerator if an array is given without a block' do
        expect(spec_num_arr.my_each).to be_kind_of(Enumerable)
      end

      it 'returns the same value as the original given an array and a block' do
        expect(spec_num_arr.my_select(&:even?)).to eql(spec_num_arr.select(&:even?))
      end
    end

    context 'working on a range' do
      it 'returns enumerator if a range is given without a block' do
        expect(spec_range.my_each).to be_kind_of(Enumerable)
      end

      it 'returns the same value as the original given a range and a block' do
        expect(spec_range.my_select(&:even?)).to eql(spec_range.select(&:even?))
      end
    end

    context 'when called on a hash' do
      it 'returns the same value as the original given a hash and a block' do
        expect(spec_hash.my_select { |_k, v| v.even? }).to eql(spec_hash.select { |_k, v| v.even? })
      end
    end
  end

  # my_all
  describe 'my_all' do
    it 'returns true if all values are smaller than 21' do
      expect(spec_num_arr.my_all? { |v| v < 21 }).to eql(spec_num_arr.all? { |v| v < 21 })
    end

    it 'returns true if all elements in an array are String values' do
      expect(word_array.my_all?(String)).to eql(true)
    end

    it 'returns true if all elements in an array are Integer values' do
      expect(spec_num_arr.my_all?(Integer)).to eql(true)
    end

    it 'returns fals if all elements in an array do not match the given pattern' do
      expect(word_array.my_all?(/d/)).to eql(false)
    end

    it 'returns false if a value in the array doesn\'t satisfy the block condition' do
      expect(spec_num_arr.my_all? { |v| v < 10 }).to eql(spec_num_arr.all? { |v| v < 10 })
    end

    it 'returns true if a single value array matches the query' do
      expect(single_val_arr.my_all?(1)).to eql(true)
    end
  end

  # my_none
  describe '#my_none?' do
    context 'when given an array' do
      it 'return false if any of the elements in the array is equal to true.' do
        expect(spec_num_arr.my_none?(&:even?)).to eql(false)
      end

      it 'returns true if none of the elements in an array are String values' do
        expect(spec_num_arr.my_none?(String)).to eql(true)
      end

      it 'returns true if no elements in an array are Integer values' do
        expect(word_array.my_none?(Integer)).to eql(true)
      end

      it 'returns true if no elements in an array match the given pattern' do
        expect(word_array.my_none?(/d/)).to eql(true)
      end
    end

    context 'when given a range' do
      it 'return false if any of the elements in the range is equal to true.' do
        expect(spec_range.my_none?(&:even?)).to eql(false)
      end
    end

    context 'when given a hash' do
      it 'return false if any of the elements in the hash is equal to true.' do
        expect(spec_hash.my_none? { |_key, val| val > 2 }).to eql(false)
      end
    end
  end

  # my_any
  describe '#my_any' do
    context 'when given an array' do
      it 'returns true if one value in the array is true.' do
        expect(spec_num_arr.my_any?(2)).to eql(true)
      end

      it 'returns true if any of the elements in a word array are string values' do
        expect(word_array.my_any?(String)).to eql(true)
      end

      it 'returns true if any element in an integer array are integer values' do
        expect(spec_num_arr.my_any?(Integer)).to eql(true)
      end

      it 'returns true if any element in an array matches the given pattern' do
        expect(spec_num_arr.my_any?(/d/)).to eql(false)
      end

      it 'returns false when running a query on an empty array' do
        expect(empty_array.my_any?(1)).to eql(false)
      end
    end

    it 'returns true if one value in a range is true.' do
      expect(spec_range.my_any?(2)).to eql(true)
    end

    it 'returns true if one key in the hash is true.' do
      expect(spec_hash.my_any? { |key, _val| key == :a }).to eql(true)
    end
  end

  # my_count
  describe '#my_count' do
    it 'counts the number of items in an array that match the given argument or block.' do
      expect(spec_num_arr.my_count(2)).to eql(1)
    end

    it 'counts the number of items in a range that match the given argument or block.' do
      expect(spec_range.my_count(&:even?)).to eql(10)
    end

    it 'counts the number of key value pairs in a hash that match the given argument or block.' do
      expect(spec_hash.my_count { |key, _val| key == :a }).to eql(1)
    end
  end

  # my_map
  describe '#my_map' do
    it 'iterates over every element in an array & performs an action on it. ' do
      expect(spec_num_arr.my_map { |el| el * 2 }).to eql(spec_num_arr.map { |el| el * 2 })
    end

    it 'iterates over every element in a range & performs an action on it. ' do
      expect(spec_range.my_map { |el| el * 2 }).to eql(spec_range.map { |el| el * 2 })
    end

    it 'iterates over every element in an hash & performs an action on the keys or values ' do
      expect(spec_hash.my_map { |_el, val| val * 2 }).to eql(spec_hash.map { |_el, val| val * 2 })
    end
  end

  # my_inject
  describe '#my_inject' do
    it 'returns the sum of all the values in an array' do
      expect(spec_num_arr.my_inject { |sum, val| sum + val }).to eql(210)
    end

    it 'behaves like the original when given a special operator term for addition' do
      expect(spec_num_arr.my_inject(:+)).to eql(210)
    end

    it 'behaves like the original when given a special operator term for multiplication' do
      expect(spec_num_arr.my_inject(:*)).to eql(spec_num_arr.inject(:*))
    end

    it 'behaves like the original when applied to a range' do
      expect(spec_range.my_inject { |sum, val| sum + val }).to eql(spec_range.inject { |sum, val| sum + val })
    end

    it 'finds the longest string' do
      expect(word_array.my_inject { |a, b| a.length > b.length ? a : b }).to eql('very_long_string')
    end
  end
end
