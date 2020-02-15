#Ruby Parser for the Grammar given in the ReadMe
#Does not utilize a Parse Tree, but instead
#Loads test files using File.read and pushes tokens
#onto a helper array, which is compared to a syntaxArr
#to check for syntactical errors

#Name of the file and a Flag determining whether
#My Prolog or Scheme followup project is used
txtFile = ARGV[0]
processFlag = ARGV[1]

#Class to be used throughout the parser
#All objects will have a type, such as :NUM
#and a lexeme, the actual
class Token

  def initialize(type, lexeme)
    @type = type
    @lexeme = lexeme
  end

  attr_accessor :type, :lexeme

end

if !(/.\.cpl$/ === txtFile)

    puts "Wrong Parameters(Incorrect file format or no test file specified)"
    puts "ruby parser.rb filename [-p | -s]"
    puts "Use -p to generate Prolog Queries"
    puts "Use -s to generate Scheme function call"

elsif !(/(^-p$|^-s$)/ === processFlag)

    puts "Wrong Parameters (Wrong flag)"
    puts "ruby parser.rb filename [-p | -s]"
    puts "Use -p to generate Prolog Queries"
    puts "Use -s to generate Scheme function call"

else
  if (processFlag == "-s")
    puts "; Processing Input File " + ARGV[0]
  else
    puts "/* Processing Input File " + ARGV[0]
  end

inputTxt = File.read(txtFile)
tempStr = ""
tokenArr = Array.new

while(inputTxt.size > 0)
    newChar = inputTxt.slice!(0)
    #puts tempStr
    case newChar
    when /[=;\(\)\,\.]/

        case newChar
        when /=/

          if tempStr.size == 0

            tokenArr << Token.new(:EQUAL, "")

          elsif /\Apoint\Z/ === tempStr || /[a-z]+/ === tempStr || /^(\d*\.)?\d+$/ === tempStr

            if /\Apoint\Z/ === tempStr

              tokenArr << Token.new(:POINT, "")
              tempStr.clear

            elsif /^(\d*\.)?\d+$/ === tempStr

              inStr = String.new(tempStr)
              tokenArr << Token.new(:NUM, inStr)
              tempStr.clear

            else

              inStr = String.new(tempStr)
              tokenArr << Token.new(:ID, inStr)
              tempStr.clear

            end

            tokenArr << Token.new(:EQUAL, "")
          else #tempStr has unnacceptable mix of chars to create a token
              abort "Lexical Error"
          end

        when /;/

          if tempStr.size == 0

            tokenArr << Token.new(:SEMICOLON, "")

          elsif /\Apoint\Z/ === tempStr || /[a-z]+/ === tempStr || /^(\d*\.)?\d+$/ === tempStr

            if /\Apoint\Z/ === tempStr

              tokenArr << Token.new(:POINT, "")
              tempStr.clear

            elsif /^(\d*\.)?\d+$/ === tempStr

              inStr = String.new(tempStr)
              tokenArr << Token.new(:NUM, inStr)
              tempStr.clear

            else

              inStr = String.new(tempStr)
              tokenArr << Token.new(:ID, inStr)
              tempStr.clear

            end

            tokenArr << Token.new(:SEMICOLON, "")
          else #tempStr has unnacceptable mix of chars to create a token
              abort "Lexical Error"
          end

        when /\(/

          if tempStr.size == 0

            tokenArr << Token.new(:LPAREN, "")

          elsif /\Apoint\Z/ === tempStr || /[a-z]+/ === tempStr || /^(\d*\.)?\d+$/ === tempStr

            if /\Apoint\Z/ === tempStr

              tokenArr << Token.new(:POINT, "")
              tempStr.clear

            elsif /^(\d*\.)?\d+$/ === tempStr

              inStr = String.new(tempStr)
              tokenArr << Token.new(:NUM, inStr)
              tempStr.clear

            else

              inStr = String.new(tempStr)
              tokenArr << Token.new(:ID, inStr)
              tempStr.clear

            end
            tokenArr << Token.new(:LPAREN, "")

          else #tempStr has unnacceptable mix of chars to create a token
              abort "Lexical Error"
          end

        when /\)/

          if tempStr.size == 0

            tokenArr << Token.new(:RPAREN, "")

          elsif /\Apoint\Z/ === tempStr || /[a-z]+/ === tempStr || /^(\d*\.)?\d+$/ === tempStr

            if /\Apoint\Z/ === tempStr

              tokenArr << Token.new(:POINT, "")
              tempStr.clear

            elsif /^(\d*\.)?\d+$/ === tempStr

              inStr = String.new(tempStr)
              tokenArr << Token.new(:NUM, inStr)
              tempStr.clear

            else

              inStr = String.new(tempStr)
              tokenArr << Token.new(:ID, inStr)
              tempStr.clear

            end
            tokenArr << Token.new(:RPAREN, "")

          else #tempStr has unnacceptable mix of chars to create a token
              abort "Lexical Error"
          end

        when /\,/

          if tempStr.size == 0

            tokenArr << Token.new(:COMMA, "")

          elsif /\Apoint\Z/ === tempStr || /[a-z]+/ === tempStr || /^(\d*\.)?\d+$/ === tempStr

            if /\Apoint\Z/ === tempStr

              tokenArr << Token.new(:POINT, "")
              tempStr.clear

            elsif /^(\d*\.)?\d+$/ === tempStr

              inStr = String.new(tempStr)
              tokenArr << Token.new(:NUM, inStr)
              tempStr.clear

            else

              inStr = String.new(tempStr)
              tokenArr << Token.new(:ID, inStr)
              tempStr.clear

            end
            tokenArr << Token.new(:COMMA, "")

          else #tempStr has unnacceptable mix of chars to create a token
              abort "Lexical Error"
          end

        when /\./ #Special case for . because it can be a PERIOD or a decimal
          #If . is a decimal (tempStr has numbers and does not contain a . already)
          if /[\d]/ === tempStr[-1,1] && !(/[\.]/ === tempStr)

              tempStr+=newChar

          elsif tempStr.size == 0 #if . is a PERIOD

              tokenArr << Token.new(:PERIOD,"")

          elsif /\Apoint\Z/ === tempStr || /[a-z]+/ === tempStr || /^(\d*\.)?\d+$/ === tempStr #tempStr has valid lexical units, but will be a syntax error

            if /\Apoint\Z/ === tempStr

              tokenArr << Token.new(:POINT, "")
              tempStr.clear

            elsif /^(\d*\.)?\d+$/ === tempStr

              inStr = String.new(tempStr)
              tokenArr << Token.new(:NUM, inStr)
              tempStr.clear

            else

              inStr = String.new(tempStr)
              tokenArr << Token.new(:ID, inStr)
              tempStr.clear

            end

            tokenArr << Token.new(:PERIOD, "")

          else #tempStr has unnacceptable mix of chars to create a token
              abort "Lexical Error"
          end

        end

    when /[0-9a-z]/

          tempStr+=newChar

    when /[\s\n]/
      next

    else
      abort "Lexical Error: Invalid character, matches no token"
    end

end

  
#Syntax array that holds the Structure of the Grammar
#Hard coded for three lines
numArr = Array.new
iterator = 0
syntaxArr = [:ID,:EQUAL,:POINT,:LPAREN,:NUM,:COMMA,:NUM,:RPAREN,:SEMICOLON,
  :ID,:EQUAL,:POINT,:LPAREN,:NUM,:COMMA,:NUM,:RPAREN,:SEMICOLON,
  :ID,:EQUAL,:POINT,:LPAREN,:NUM,:COMMA,:NUM,:RPAREN,:PERIOD]

#Load the number values into an array
tokenArr.each do |myTok|
  if myTok.type == :NUM
    numArr << myTok.lexeme
  end
end

#If any of the tokens are not in the same order
#as the syntaxArr, a syntax error has occurred
syntaxArr.each do |token|
  if token != tokenArr[iterator].type
    abort "Syntax Error!"
  else
    iterator += 1
  end
end


if processFlag == "-p"

    puts "Lexical and Syntactical Analysis Passed*/"
    puts "query(line(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "query(triangle(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "query(vertical(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "query(horizontal(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "query(equilateral(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "query(isosceles(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "query(right(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "query(scalene(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "query(acute(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "query(obtuse(point2d(" + numArr[0] + "," + numArr[1] + "), point2d(" + numArr[2] + "," + numArr[3] + "), point2d(" + numArr[4] + "," + numArr[5] + ")))"
    puts "writeln(T) :- write(T), nl."
    puts "main:- forall(query(Q), Q-> (writeln('yes')) ; (writeln('no'))),\n\thalt."

else
    puts "; Lexical and Syntactical Analysis Passed"
    puts "(calculate-triangle (make-point " + numArr[0] + " " + numArr[1] + ") (make-point " + numArr[2] + " " + numArr[3] + ") (make-point " + numArr[4] + " " + numArr[5] + "))"

end
end
