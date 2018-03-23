#!/bin/bash

GAME_STATUS="0"
CORRECT_PLACE="0"

GAME_BOARD=( "0" "0" "0"
             "0" "0" "0"
             "0" "0" "0" )

SIGN=("X" "Y")
PLAYER="0"
PLACE="0"

function printBoard(){
    printf "\t### Game board ###\n"
    printf "\t1${GAME_BOARD[0]} \t${GAME_BOARD[1]} \t${GAME_BOARD[2]}\n"
    printf "\t${GAME_BOARD[3]} \t${GAME_BOARD[4]} \t${GAME_BOARD[5]}\n"
    printf "\t${GAME_BOARD[6]} \t${GAME_BOARD[7]} \t${GAME_BOARD[8]}\n"
    printf "\t##################\n"
    printf "\n"
}

function pickPlace(){
    while [ $CORRECT_PLACE -eq "0" ]
    do
        printf "Player ${SIGN[PLAYER]} pick a place: "
        read PLACE
        PLACE=$((PLACE-1))
        checkIfPlaceIsCorrect
        printf "\n"
    done
    CORRECT_PLACE="0"
}

function changePlayer(){
    if [ $PLAYER -eq "0" ]
    then
        PLAYER="1"
    else
        PLAYER="0"
    fi
}

function checkIfPlaceIsCorrect(){
    if [ ${GAME_BOARD[$PLACE]} -eq "0" ]
    then
        GAME_BOARD[PLACE]=${SIGN[PLAYER]}
        CORRECT_PLACE="1"
    else
        echo "Incorrect input"
    fi
}

function checkIfWon(){
    echo PLAYER
}

while [ $GAME_STATUS -eq "0" ]
do
    printBoard
    pickPlace
    changePlayer
done
