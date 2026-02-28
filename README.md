# Bubble Bobble Clone

## Description
This project is a 2D platformer inspired by the game Bubble Bobble. The player traps enemies in bubbles and pops them to earn points while avoiding damage.

## Controls

- **A / Left Arrow** – Move Left  
- **D / Right Arrow** – Move Right  
- **Space** – Jump  
- **F** – Shoot Bubble  
- **R** – Restart (Win or Game Over screen)

## Gameplay

- Enemies move across platforms
- Player shoot a bubble to trap an enemy
- Touch a trapped bubble to pop it and earn points
- Touching an enemy directly causes the player to lose a life
- If lives reach 0 you lose the game
- If all enemies are defeated you win the game

## Features

- Player movement with gravity
- One way platforms so you can jump up but not fall through
- Enemy movement AI
- Bubble trapping system
- Score tracking
- Lives system
- Wrap system (fall from bottom → appear at top)
- Start screen
- Game Over screen
- Win screen
- Restart functionality

## Bonus Feature

- Enemy escape timer from bubble
- HUD with score and lives display  

## Known Bugs / Limitations

- Enemies have simple movement AI there is no advanced pathfinding or random turns
- There is only one level not multiple levels 

## How to Run

1. Open the project in Godot
2. Open `Main.tscn`
3. Press the Play button
