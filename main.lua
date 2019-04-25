-----------------------------------------------------------------------------------------
--
-- Created by: Matsuru Hoshi
-- Created on: Apr 24, 2016
--
-- This file contains a game.
-----------------------------------------------------------------------------------------

local physics = require( "physics")

physics.start()
physics.setGravity( 0, 1)
--physics.setDrawMode("hybrid")

local background = display.setDefault( "background", 186/255, 239/255, 205/255)

local music = audio.loadSound( "Bomberman.mp3")

audio.play( music )

local ground = display.newRect( display.contentCenterX, 555, 500, 60)
ground.id = "ground"
physics.addBody( ground, "static", {
	friction = 0.1,
	bounce = 0.3
	})

local leftWall = display.newRect( -50, display.contentCenterY, 100, 560)
leftWall.id = "left wall"
physics.addBody( leftWall, "static", {
	friction = 0.5,
	bounce = 0.1
	})

local rigthWall = display.newRect( 390, display.contentCenterY, 100, 560)
rigthWall.id = "left wall"
physics.addBody( rigthWall, "static", {
	friction = 0.5,
	bounce = 0.1
	})

local startButton = display.newRoundedRect( display.contentCenterX, 200, 200, 60, 30) 

local startText = display.newText( "Start", display.contentCenterX, 200, "Phosphate", 50)
startText:setFillColor( 161/255, 209/255, 177/255)
startText.align = "center"

local instructBox = display.newRoundedRect( display.contentCenterX, 380, 220, 190, 30)
instructBox:setFillColor( 1, 1, 1)

local instructText = [[Drag your ball from left to right to avoid obstacles]]

local options = {
	text = instructText,
	x = display.contentCenterX,
	y = 380,
	width = 180,
	height = 100,
	font = "Phosphate",
	fontSize = 20,
	align = "center"
}

local instructTextOut = display.newText( options )
instructTextOut:setFillColor( 161/255, 209/255, 177/255)

local function createBall()
	local function gameOver()
		local blank = display.newRect( 
			display.contentCenterX, display.contentCenterY,
			display.actualContentWidth, display.actualContentHeight)
		blank:setFillColor( 119/255, 26/255, 26/255)

		local gameOverText = display.newText( "Game Over!", display.contentCenterX, display.contentCenterY, "Phosphate", 50)
		gameOverText:setFillColor( 0, 0, 0)
	end

	local function whiteBallCollision(self, event)
		if ( event.phase == "began" ) then
			if (event.other.id == "ground") then
				display.remove(self)
			elseif (event.other.id == "player") then
				gameOver()
			end
			print("Whiteball is "..self.y.." with "..event.other.id)
		end
	end

	local x = math.random(100, display.contentWidth)
	local y = math.random(-5000, -100)
	local ball = display.newCircle( x, y, 37)
	ball.id = "ball"
	ball.collision = whiteBallCollision
	ball:addEventListener( "collision")
	physics.addBody( ball, "dynamic", {
		friction = 0.5,
		bounce = 0.2
	})
end

local function run()

	local playerBall = display.newCircle( display.contentCenterX, 450, 37)
	playerBall:setFillColor( 0, 234/255, 35/255)
	playerBall.id = "player"
	physics.addBody( playerBall, "dynamic", {
		friction = 0.5,
		bounce = 0.2
		})

	for i = 0, 20, 1 do
		createBall()
	end

	local rightButton = display.newRoundedRect( 258, 455, 100, 120, 5)
	rightButton:setFillColor( 0, 0, 0)
	rightButton.alpha = 0.8

	local leftButton = display.newRoundedRect( 60, 455, 100, 120, 5)
	leftButton:setFillColor( 0, 0, 0)
	leftButton.alpha = 0.8

	local rightArrow = display.newImageRect( "assets/rightarrow.png", 111, 109)
	rightArrow.alpha = 0.4
	rightArrow.x = 260
	rightArrow.y = 455

	local leftArrow = display.newImageRect( "assets/leftarrow.png", 111, 109)
	leftArrow.alpha = 0.4
	leftArrow.x = 58
	leftArrow.y = 455

	local function playerCollision( self, event )
	 
	    if ( event.phase == "began" ) then
	        print( self.id .. ": collision began with " .. event.other.id )
	 
	    elseif ( event.phase == "ended" ) then
	        print( self.id .. ": collision ended with " .. event.other.id )
	    end
	end 

	function playerBall:touch( event )
		local playerBallTouched = event.target

	    if ( event.phase == "began" ) then
	        print( "Touch event began on: " .. self.id )
	 
	        -- Set touch focus
	        display.getCurrentStage():setFocus( self )
	        self.markX = self.x
	        self.markY = self.y
	        self.isFocus = true
	     
	    elseif ( self.isFocus ) then
	        if ( event.phase == "moved" ) then
	            print( "Moved phase of touch event detected." )
	            self.x = event.x - event.xStart + self.markX
	            rightButton.alpha = 0.01
	        	rightArrow.alpha = 0.01
	 			leftButton.alpha = 0.01
	        	leftArrow.alpha = 0.01
	        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
	 
	            -- Reset touch focus
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = nil
	            print( "Touch event ended on: " .. self.id )
	            rightButton.alpha = 0.8
	    		rightArrow.alpha = 0.8
	    		leftButton.alpha = 0.8
	    		leftArrow.alpha = 0.8
	        end
	    end

	    return true
	end

	function rightButton:touch( event )
	    if ( event.phase == "moved" or event.phase == "began" ) then
	        -- move the character up
	        transition.moveBy( playerBall, { 
	        	x = 5, -- move 5 in the x direction 
	        	y = 0, -- move up 0 pixels
	        	time = 1 -- move in a 1/10 of a second
	        	} )
	        rightButton.alpha = 0.01
	        rightArrow.alpha = 0.01
	    elseif ( event.phase == "ended") then
	    	rightButton.alpha = 0.8
	    	rightArrow.alpha = 0.8
	    end

	    return true
	end

	function leftButton:touch( event )
	    if ( event.phase == "moved" or event.phase == "began" ) then
	        -- move the character up
	        transition.moveBy( playerBall, { 
	            x = -5, -- move  in the x direction 
	            y = 0, -- move up
	            time = 1 -- move in a 1/10 of a second
	            } )
	        leftButton.alpha = 0.01
	        leftArrow.alpha = 0.01
	    elseif ( event.phase == "ended") then
	    	leftButton.alpha = 0.8
	    	leftArrow.alpha = 0.8
		end

	    return true
	end

	rightButton:addEventListener( "touch", rightButton )
	leftButton:addEventListener( "touch", leftButton )
	playerBall:addEventListener( "touch", playerBall )

end

local function start( event )

	display.remove(startText)
	display.remove(startButton)
	display.remove(instructBox)
	display.remove(instructTextOut)

	print( 'hi')
	run()
end

startButton:addEventListener( "touch", start)
