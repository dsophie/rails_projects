require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
    message = params['message']
    shifts = params['shifts'].to_i

    if message.nil? == false && shifts.nil? == false
        string = caesar_cipher(message, shifts)
        result = "Here is your message encrypted: " + string
    else
        result = ""
    end

    erb :index, :locals => {:result => result}
end

#Cipher algorithm
def caesar_cipher(string, shift)

    alphabet = 'a'..'z'
    alphabet_cap = 'A'..'Z'
    alphabet = alphabet.to_a
    alphabet_cap = alphabet_cap.to_a

    result = []

    string.split("").each  do |letter|
        if alphabet.include?(letter) #lowercase letters
            i = alphabet.index(letter) #gets the index of the letter
            if letter == "z" && shift == 1
                le = 'a'
                result << le
            elsif (i + shift) < 26 
                i = i + shift
                le = alphabet[i] #gets the letter of the new index number
                result << le
            elsif (i + shift) > 26 #case when program need to go back to a
                over = (i + shift) - 26
                le = alphabet[over]
                result << le
            end
        elsif alphabet_cap.include?(letter) #uppercase letters
            i = alphabet_cap.index(letter) #gets the index of the letter
            if letter == "Z" && shift == 1
                le = 'A'
                result << le
            elsif (i + shift) < 26 
                i = i + shift
                le = alphabet_cap[i] #gets the letter of the new index number
                result << le
            elsif (i + shift) > 26 #case when program need to go back to a
                over = (i + shift) - 26
                le = alphabet_cap[over]
                result << le
            end
        else #case of spaces and special characters
            result << letter
        end
    end

    str_result = ""

    result.each do |letter|
        str_result = str_result + letter #change array into string
    end
    return str_result

end