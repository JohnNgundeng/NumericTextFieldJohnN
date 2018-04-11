-- Title: NumericTextFields
-- Name: John Ngundneg
-- Course: ICS2O
-- This program this program displays a math question
-- and asks the user to answer in a numeric text field terminal.
------------------------------------------------------------------------

-- hide status bar 
display.setStatusBar(display.HiddenStatusBar)

-- sets the background color 
display.setDefault("background", 200/255, 155/255, 255/255)

-------------------------------------------------------------------------
-- LOCAL VARIABLES 
-------------------------------------------------------------------------

-- create local variables 
local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local randomOperator
local userAnswer 
local correctAnswer 
-------------------------------------------------------------------------
-- LOCAL FUNCTIONS 
-------------------------------------------------------------------------

local function AskQuestion()
	-- generate 2 random numbers  between a max. and a min. number
	randomNumber1 = math.random(0,10)
	randomNumber2 = math.random(0,10)
	randomOperator = math.random(1,3)

	-- subtraction 
	if (randomOperator == 1) then
	correctAnswer = randomNumber1 - randomNumber2
	questionObject.text = randomNumber1 .. " - " ..  randomNumber2 .. " = "
			if (correctAnswer < 0) then 
			questionObject.text = randomNumber2 .. " - " ..  randomNumber1 .. " = "
			correctAnswer = randomNumber2 - randomNumber1
		end

	-- multiplication
	elseif (randomOperator == 2) then  
		correctAnswer = randomNumber1 * randomNumber2
		questionObject.text = randomNumber1 .. " * " ..  randomNumber2 .. " = "
	


	-- addition 
	elseif (randomOperator == 3) then
		correctAnswer = randomNumber1 + randomNumber2
		questionObject.text = randomNumber1 .. " + " ..  randomNumber2 .. " = "
	end

end

local function HideCorrect()
	correctObject.isVisible = false 
	AskQuestion()
end 

local function HideIncorrect()
	incorrectObject.isVisible = false
end

local function NumericFieldListener( event )
	-- user begins editing "numericField"
	if ( event.phase == "began" ) then

	   	-- clear text field 
	  	event.target.text = "" 

		elseif event.phase == "submitted" then

			-- when the answer is subitted (enter key is pressed) set user input to user's answer
			userAnswer = tonumber(event.target.text)

			-- if the users answer and the correct answer are the same:
			if (userAnswer == correctAnswer) then 
			correctObject.isVisible = true
			timer.performWithDelay(2000, HideCorrect)

			elseif (userAnswer ~= correctAnswer) then
				incorrectObject.isVisible = true
				timer.performWithDelay(1000,HideIncorrect)
			end
		end
	end		
------------------------------------------------------------------------- 
-- OBJECT CREATION 
-------------------------------------------------------------------------

-- displays a question and sets the color 
questionObject = display.newText( '', display.contentWidth/3, display.contentHeight/2, nil, 50)
questionObject:setTextColor(255/255, 104/255, 0/255)

-- create the correct text object and make it invisible
correctObject = display.newText( " Correct ", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(155/255, 42/255, 198/255)
correctObject.isVisible = false 

-- create the Incorrect text object and make it invisible
incorrectObject = display.newText( " Incorrect ", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
incorrectObject:setTextColor(255/255, 7/255, 7/255)
incorrectObject.isVisible = false 

-- create numeric field 
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80)
numericField.inputType = "number"

-- add the event listener for the numeric field 
numericField:addEventListener ( "userInput", NumericFieldListener )

------------------------------------------------------------------------
-- FUNCTION CALLS
------------------------------------------------------------------------

-- call the function to ask the question 
AskQuestion()