-----------------------------------------------------------------------------------------
--
-- Created by: Matsuru Hoshi
-- Created on: Apr 24, 2016
--
-- This file contains a game.
-----------------------------------------------------------------------------------------

local physics = require( "physics")

physics.start()
physics.setGravity( 0, 10)
physics.setDrawMode("hybrid")

local background = display.setDefault( "background", 249/255, 206/255, 1)

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

local playerBall = display.newCircle( display.contentCenterX, 450, 37)
playerBall:setFillColor( 0, 234/255, 35/255)
playerBall.id = "player"
physics.addBody( playerBall, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball1 = display.newCircle( display.contentCenterX, 450, 37)
ball1.id = "ball1"
physics.addBody( ball1, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball2 = display.newCircle( 40, 450, 37)
ball2.id = "player"
physics.addBody( ball2, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})
local ball3 = display.newCircle( 100, 450, 37)
ball3.id = "player"
physics.addBody( ball3, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})
local ball4 = display.newCircle( 160, 450, 37)
ball4.id = "player"
physics.addBody( ball4, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})
local ball5 = display.newCircle( 210, 450, 37)
ball5.id = "player"
physics.addBody( ball5, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})
local ball6 = display.newCircle( 260, 450, 37)
ball6.id = "player"
physics.addBody( ball6, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball7 = display.newCircle( display.contentCenterX, 450, 37)
ball7.id = "player"
physics.addBody( ball7, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball8 = display.newCircle( 40, 450, 37)
ball8.id = "player"
physics.addBody( ball8, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})
local ball9 = display.newCircle( 100, 450, 37)
ball9.id = "player"
physics.addBody( ball9, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})
local ball10 = display.newCircle( 160, 450, 37)
ball10.id = "player"
physics.addBody( ball10, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})
local ball11 = display.newCircle( 210, 450, 37)
ball11.id = "player"
physics.addBody( ball11, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})
local ball12 = display.newCircle( 260, 450, 37)
ball12.id = "player"
physics.addBody( ball12, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball13 = display.newCircle( display.contentCenterX, 450, 37)
ball13.id = "ball13"
physics.addBody( ball13, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball14 = display.newCircle( 40, 450, 37)
ball14.id = "ball14"
physics.addBody( ball14, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})
local ball15 = display.newCircle( 100, 450, 37)
ball15.id = "ball15"
physics.addBody( ball15, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local balll16 = display.newCircle( 160, 450, 37)
balll16.id = "ball16"
physics.addBody( balll16, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball17 = display.newCircle( 210, 450, 37)
ball17.id = "ball17"
physics.addBody( ball17, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball18 = display.newCircle( 260, 450, 37)
ball18.id = "ball18"
physics.addBody( ball18, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball19 = display.newCircle( 260, 450, 37)
ball19.id = "ball19"
physics.addBody( ball19, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

local ball20 = display.newCircle( 260, 450, 37)
ball20.id = "ball20"
physics.addBody( ball20, "dynamic", {
	friction = 0.5,
	bounce = 0.2
	})

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
            self.y = event.y - event.yStart + self.markY
 
        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
 
            -- Reset touch focus
            display.getCurrentStage():setFocus( nil )
            self.isFocus = nil
            print( "Touch event ended on: " .. self.id )
        end
    end

    return true
end


playerBall:addEventListener( "touch", playerBall )

