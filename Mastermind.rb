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

    end

    # prints the color options for the user from the color_options member
    # This also colorizes the options
    def color_options
        @color_options.each_with_index do |color, index|
            if color == "cyan"
                print("and ".colorize(:background => :light_black)); print "#{index + 1}: #{color}".colorize(:background => :light_black).colorize(color.to_sym) 
            else
                print("#{(index + 1)}: #{color} ".colorize(:background => :light_black).colorize(color.to_sym))
            end
        
        end
    end


    # Generates a pseudorandom combination of colors for 
    # the user to guess without repeating colors
    def code_generator
        # copies the color options member array to a local variable
        localColorArray = @color_options

        # Creates an empty array to store colors that were already chosen
        # to ensure no duplicates are put into the color code
        already_taken = []
        
        # Array to store the random color combination
        code = []

        # For loop to select 4 colors
        for i in 0..3
            
            #Assigns color to a random index of the local array of colors
            color = localColorArray[rand(0..localColorArray.size - 1)]

            # while loop that will ensure no colors repeat.
            # tests if the color that was chosen is in the already_taken
            # array
            while already_taken.include?(color)
                
                # the color selection process repeats until a different value
                # is chosen 
                color = localColorArray[rand(0..localColorArray.size - 1)]
            end

            # Adds the chosen color to the already_taken array 
            already_taken << color

            # Adds the unique and random color to the code array at the index of the loop iteration
            code[i] = color
        end

        # return the code array 
        return code
    end
    
    # Welcome message to display to the user. It explains the overall goal 
    # of the game and instructs the user how to play the game. 
    def welcome_message 
        puts("Welcome to Mastermind. You will be given a 4-peg sequence that is made of 7 possible colors to choose from.")
        puts("You will have 12 guesses to find the correct sequence.\n\n")
        puts("Your color arrangement will be represented by a dot within a colored square.")
        puts("If the square is red with the colored dot in the middle, that color is not in the secret sequence.")
        puts("If the square is green with the colored dot in the middle, that color is in the correct")
        puts("position in the secret sequence.")
        puts("If the square is grey with green brackets around the colored dot, that color is ")
        puts("in the secret sequence, but not in the correct position")
        puts("Your options are: ")
        color_options
        puts
        print "Press enter to begin...".colorize(:mode => :bold)
        if gets
            return
        end
    end

    # This is a helper method that tests if the user's choice 
    # either matches the secret sequence's index or if it is present
    # at all
    def choice_checker(choice, iterator)

        # If the choice is in the sequence, but not in the right position...
        if (choice != @the_code[iterator]) && (!@the_code.include?(choice))
            return 1
        
        # If the choice is in the correct position...
        elsif (@the_code.include?(choice)) && (choice != @the_code[iterator])
            return 2
        
        # If the choice is not in the sequence...
        else 
            return 3
        end

    end


    # Generates & displays the game board that represents the user's choice for each attempt
    def game_board_gen(turn, input)
        
        # Prints the attempt number
        print "Attempt #{turn + 1}: "
        
        # Loops through
        for i in 0..3

            # Assigns the result of the choice_checker function to a local variable
            # to only call the function once per loop iteration
            choice_code = choice_checker(input[i], i)
            
            # The following statements colorize the user's choices that coorespond to the secret sequence
            
            # If the color is not in the sequence... 
            if choice_code == 1
                print @the_board[turn][i][0].colorize(input[i].to_sym).colorize(:light_red).colorize(:background => :light_red)
                print @the_board[turn][i][1].colorize(input[i].to_sym).colorize(:background => :light_red)
                print @the_board[turn][i][2].colorize(input[i].to_sym).colorize(:light_red).colorize(:background => :light_red)
                print " "

            # if the color is in the sequence, but not in the correct position...
            elsif choice_code == 2 
                print @the_board[turn][i][0].colorize(:background => :light_black).colorize(:light_green)
                print @the_board[turn][i][1].colorize(input[i].to_sym).colorize(:background => :light_black)
                print @the_board[turn][i][2].colorize(:background => :light_black).colorize(:light_green)
                print " "
            
            # The color is in the array & the correct position 
            elsif choice_code == 3
                print @the_board[turn][i][0].colorize(input[i].to_sym).colorize(:background => :light_green).colorize(:light_green)
                print @the_board[turn][i][1].colorize(input[i].to_sym).colorize(:background => :light_green).colorize(:mode => :bold)
                print @the_board[turn][i][2].colorize(input[i].to_sym).colorize(:background => :light_green).colorize(:light_green)
                print " "
            end
        end
        # New line for formatting 
        puts 
    end

    # This method validates user input. It tests if the user's choice is an integer that is between 
    # 1 and 7 and if the user entered in the correct amount of choices (4)
    def user_input_validation?(userInput)
        
        # Loops through each character and tests if it's an int between 1 & 7 (inclusive)
        userInput.each_char {|value| return false if (value.to_i > 7 || value.to_i < 1) }
        
        # Tests if user input is the correct length
        if userInput.length != 4
            return false
        
        # If the above tests pass, it is a valid input
        else 
            return true
        end
    end

    # Fetches input from the user
    def user_input

        # Prompt the user to enter their guess of the secret sequence
        print("Please enter your guess: ")
        
        # assign the user's input to the local variable userGuess
        # .chomp takes off the new line character
        userGuess = gets.chomp

        # Trims the user input string of spaces so that the input validation can be uniform 
        trimmed = userGuess.gsub(/\s+/, "")

        # While loop that will prompt the user to enter in a valid choice
        while !user_input_validation?(trimmed)
            puts("You have entered an invalid value. Please type 4 integers that correspond")
            puts("to your color selection. Your options are: "); color_options; puts
            print("Please enter your guess: ")

            userGuess = gets.chomp
            trimmed = userGuess.gsub(/\s+/, "")
        end        
        
        # Array to add to and return
        userArr = []

        # Loops through each character and appends the 
        # cooresponding color string to the userArr array
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
        
        # return the array of colors the user chose
        return userArr
    end
    
    # prints the colors that the user selected in text form
    def print_user_selection(userChoice)
        
        puts 
        
        print("You picked: | ".colorize(:background => :light_black))

        userChoice.each_with_index do |choice, index|
            
            print("#{choice.colorize(choice.to_sym)} | ".colorize(:background => :light_black))
            
        end

        # new line for formatting
        puts
    end

    # Called at the end of the game if the user wins or loses. 
    # Prompts user if they want to play another game
    def continue?

        # newline for formatting
        puts
        
        # Prompt the user if they want to start another game
        puts("Would you like to play again? (y or n):")
        userChoice = gets.chomp
        
        # Input validation that loops to ensure the user enters 'y' or 'n'
        while userChoice.downcase != "n" && userChoice.downcase != "y"
            puts("Please enter either \"y\" for yes or \"n\" for no")
            userChoice = gets.chomp
        end
        
        # assigns a new value to the secret sequence and returns true
        if userChoice == "y"
            @the_code = code_generator
            return true
        else
            return false
        end
    end

    # Used to print the secret sequence 
    def print_code
        print("The code was: ".colorize(:background => :light_black))
            @the_code.each  do |color|
                print("| #{color.colorize(color.to_sym)} ".colorize(:background => :light_black))
            end
    end

    # Main game loop 
    def game_loop

        # Display welcome message with instructions 
        welcome_message
        
        # Flag to test winning conditions
        flag = false
        
        # New line for formatting
        puts

        # while loop based on the flag defined above
        # If the user is correct, it will change the flag
        # to true and break out of the for loop with a break statement
        while !flag
            for i in 0..11

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

        # if user exceeds 12 attemps... 
        if !flag
            puts("Today is not your day.")
        
        # only other condition is that they won
        else
            puts "You did it!"
        end
        
        # Print the secret sequence to the user in text format
        print_code

        # Asks the user if they want to play another round 
        if continue?
            game_loop
        else
            exit
        end
    end
end


