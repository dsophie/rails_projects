require 'sinatra'
require 'sinatra/reloader' if development?

def choose_random
    choices = File.readlines "dictionnary.txt"
    choices_list = []
    choices.each do |word|
        if word.length <= 12 && word.length >= 5
            choices_list << word
        end
    end

    total = choices_list.length
    choice = choices_list[1 + rand(total)].downcase

    word_hash = {}
    guess_array = []

    alphabet = 'a'...'z'

    #store the letters in a hash
    choice.split("").each do |letter|
        if alphabet.include?(letter) == true
            letter_found = false
            word_hash.store(letter, letter_found)
        end
    end

    return word_hash
end


@@incorrect_guesses = 0
WORD = choose_random

get '/' do

    stop = false
    stop_message = ""
    guess_message = ""

    display = []


    display << WORD

    display_array = []

    guess_letter = params['guess']

    if guess_letter.nil? == false
        if WORD.include?(guess_letter) && WORD[guess_letter] == false
            WORD[guess_letter] = true
            guess_message = "Right guess"
            @@incorrect_guesses = @@incorrect_guesses
        elsif WORD.include?(guess_letter) == false
            @@incorrect_guesses += 1
            guess_message = "Wrong guess"
        else
            guess_message = ""
        end
    end

    count = 0 
    
    WORD.each do |key, value|
        if value == false
            display_array << "_ "
        elsif value == true
            display_array << key
            count = count + 1
        end
    end

    display << @@incorrect_guesses

    display << display_array

    
    if @@incorrect_guesses == 9
        stop = true
        stop_message = "You loose!"
        WORD = choose_random
        @@incorrect_guesses = 0
    elsif count == WORD.length
        stop = true
        stop_message = "You win!"
        WORD = choose_random
        @@incorrect_guesses = 0
    else
        stop_message= ""
    end 

    erb :index, :locals => {:display => display, :guess_message => guess_message, :stop_message => stop_message}
end



