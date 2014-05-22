# encoding: utf-8
module FunWithStrings
  def clean(replacement)
    # replaces all non Unicode letter with ""
    # it needs the encoding header in the first line to work
    # (if it isn't there, the regex has to end in 'u': /\P{L}/u )
    clean_string = self.gsub(/\P{L}/, replacement)
    clean_string.downcase
  end
  
  def all_anagrams
    return [] if self.empty?
# get all the chars of this string in an array
# and then permutation returns an enumerator
# to each element of this enumerator, we map it
# to an array, with each result element being a concat (join)
# of the input element (char array)
    self.chars.to_a.permutation.map &:join
  end

  def palindrome?
    return false if self.empty?
    cleaned = self.clean("")
    half_length = (cleaned.length / 2) + (cleaned.length % 2)
    # a[0,3] returns first 3 positions
    # a[0..3] returns first 4 positions (index 0 to 3)
    return cleaned[0,half_length].reverse == cleaned[-half_length, half_length]
  end

  def count_words
    return {} if self.empty?
    cleaned_with_spaces = self.clean(" ")
    # replace all whitespaces with a single space
    cleaned = cleaned_with_spaces.gsub(/\s+/," ")
    tokens = cleaned.split(" ")
    # to each t tokens element, returns [t, 0] 
    # (inside an array with tokens.length)
    to_return = Hash[ tokens.uniq.collect { |t| [t, 0] }]
    tokens.each { |t| to_return[t] = to_return[t]+1 }
    return to_return
  end

  def anagram_groups
    return [] if self.empty?
    # removes nun Unicode letters
    cleaned_with_spaces = self.gsub(/\P{L}/, " ")
    # replace all whitespaces with a single space
    cleaned = cleaned_with_spaces.gsub(/\s+/," ")
    tokens = cleaned.split(" ")
    to_return = []
    # traverse tokens
    tokens.each { |t|
        # for each token, traverse to_return arrays
        group_indx = to_return.index { |a| (a.first.all_anagrams.index t) != nil }

        # if token is an anagram of the first element of the array,
        # add token to the array
        if (group_indx)
          to_return[group_indx].push t
        else
          # token wasn't anagram of any element in to_return yet,
          # so create a new group for it
          to_return.push [t]
        end
      }

      to_return
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end
