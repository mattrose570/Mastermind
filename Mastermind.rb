# Needed to add a splash of color
require 'colorize'

# main Mastermind class
class Mastermind
    # Constructor
    def initialize
        # The board is a 2D array that holds the user's attempts. The string
        # in each element is a dot and brackets that will be colored based on
        # the code that is chosen and the user input
        @the_board = [["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"],
                      ["[\u2022]", "[\u2022]", "[\u2022]", "[\u2022]"]]

        # Array of strings that represent the 7 color options 
        @color_options = %w[ black red green light_yellow blue magenta cyan ]

        # Generates a pseudorandom arrangement of 4 colors. Colors
        # do not repeat and there are no blank spaces
        @the_code = code_generator

        @rolling_attempts =[]

    end

    def color_options
        @color_options.each_with_index do |color, index|
            if color == "cyan"
                print("and ".colorize(:background => :light_black)); print "#{index + 1}: #{color}".colorize(:background => :light_black).colorize(color.to_sym) 
            else
                print "#{(index + 1)}: #{color} ".colorize(:background => :light_black).colorize(color.to_sym)
            end
        
        end
    end

    def code_generator
        local = @color_options

        already_taken = []
        code = []
        for i in 0..3
            color = local[rand(0..local.size - 1)]

            while already_taken.include?(color)
                color = local[rand(0..local.size - 1)]
            
            end

            already_taken << color
            code[i] = color
        end
        return code

        
        
    end
    
    def welcome_message 
        puts ("Welcome to Mastermind. You will be given a 4-peg sequence that is made of 8 possible colors to choose from.")
        puts "You will have 12 guesses to find the correct sequence.\n\n"
        puts "Your options are: "
        color_options

        print "Press enter to begin...".colorize(:mode => :bold)

        if gets
            return
        end
        
        

    end

    def choice_checker(choice, iterator)
        if (choice != @the_code[iterator]) && (!@the_code.include?(choice))
            return 1

        elsif (@the_code.include?(choice)) && (choice != @the_code[iterator])
            return 2

        else 
            return 3
        
        end

    end



    def game_board_gen(turn, input)
        if turn < 9
            print " "
        end
        print "Attempt #{turn + 1}: "
        for i in 0..3
            if choice_checker(input[i], i) == 1
                print @the_board[turn][i][0].colorize(input[i].to_sym).colorize(:light_red).colorize(:background => :light_red)
                print @the_board[turn][i][1].colorize(input[i].to_sym).colorize(:background => :light_red)
                print @the_board[turn][i][2].colorize(input[i].to_sym).colorize(:light_red).colorize(:background => :light_red)
                print " "

            elsif choice_checker(input[i], i) == 2 
                print @the_board[turn][i][0].colorize(:background => :light_black).colorize(:light_green)
                print @the_board[turn][i][1].colorize(input[i].to_sym).colorize(:background => :light_black)
                print @the_board[turn][i][2].colorize(:background => :light_black).colorize(:light_green)
                print " "
            
            elsif choice_checker(input[i], i) == 3
                print @the_board[turn][i][0].colorize(input[i].to_sym).colorize(:background => :light_green).colorize(:light_green)
                print @the_board[turn][i][1].colorize(input[i].to_sym).colorize(:background => :light_green).colorize(:mode => :bold)
                print @the_board[turn][i][2].colorize(input[i].to_sym).colorize(:background => :light_green).colorize(:light_green)
                print " "
            
            end
            
        

            
        end
        puts 

    end

    def user_input_validation?(userInput)
        userInput.each_char {|value| return false if (value.to_i > 7 || value.to_i < 1) }
        
        if userInput.length != 4
            return false
        else 
            return true
        end

    end

    def user_input
        # fetches user input 
        userGuess = gets.chomp

        trimmed = userGuess.gsub(/\s+/, "")

        while !user_input_validation?(trimmed)
            puts("You have entered an invalid value. please type 4 integers that correspond")
            puts("to your color selection. Your options are: "); color_options; puts

            userGuess = gets.chomp
            trimmed = userGuess.gsub(/\s+/, "")
        end

        # trims user input 
        
        
        # Array to add to and return
        userArr = []

        trimmed.each_char do |char|
            if char == "1"
                userArr << "black"
                
            elsif 
                char == "2"
                userArr << "red"

            elsif 
                char == "3"
                userArr << "green"

            elsif 
                char == "4"
                userArr << "light_yellow"

            elsif 
                char == "5"
                userArr << "blue"

            elsif 
                char == "6"
                userArr << "magenta"

            elsif 
                char == "7"
                userArr << "cyan"

                
            end

        end        
        
        return userArr

    end
    
    def print_user_selection(userChoice)
        puts 
        print("You picked: | ".colorize(:background => :light_black))

        userChoice.each_with_index do |choice, index|
            
            
            print("#{choice.colorize(choice.to_sym)} | ".colorize(:background => :light_black))
            
        end

        puts




    end

    def continue?
        puts
        puts("Would you like to play again? (y or n):")
        userChoice = gets.chomp
        while userChoice.downcase != "n" && userChoice.downcase != "y"
            puts("Please enter either \"y\" for yes or \"n\" for no")
            
            userChoice = gets.chomp
            
        end
        

        if userChoice == "y"
            @the_code = code_generator
            return true
        
        else
            return false
            
        end


    end

    def print_code
        print("The code was: ".colorize(:background => :light_black))
            @the_code.each  do |color|
                print("| #{color.colorize(color.to_sym)} ".colorize(:background => :light_black))
            end
    end

    
    def game_loop
        # welcome_message
        flag = false
        
        # New line for formatting
        puts

        # while loop based on the flag defined above
        # If the user is correct, it will change the flag
        # to true and break out of the for loop with a break statement
        while !flag
            for i in 0..11
                #puts @the_code

                # prints color options
                color_options
                
                # New line for formatting
                puts
                
                # Assign the user input to a local varaible 
                getUserInput = user_input
                
                # Display the user's guess 
                game_board_gen(i, getUserInput)
                
                # Displays the user's selection through text
                print_user_selection(getUserInput)

                # Tests to see if the user is correct
                if getUserInput == @the_code
                    flag = true
                    break
                    
                end
            end
        end

        if !flag
            puts("Today is not your day.")
        else
            puts "You did it!"
        end
        
        print_code

        if continue?
            game_loop
        else
            exit
        end
    end
end


