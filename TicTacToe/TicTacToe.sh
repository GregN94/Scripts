#!/bin/bash

GAME_STATUS="0"
CORRECT_PLACE="0"

GAME_BOARD=( "0" "0" "0"
             "0" "0" "0"
             "0" "0" "0" )

SIGN=("X" "Y")
PLAYER="0"
PLACE="0"
GAMES="1"
MAX_GAMES="9"

function printBoard(){
    printf "\t### Game board ###\n"
    printf "\t${GAME_BOARD[0]} \t${GAME_BOARD[1]} \t${GAME_BOARD[2]}\n"
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

function setWinner()
{
    printf "Winner!! Player  ${SIGN[PLAYER]} won\n"
    GAME_STATUS="1"
}

function checkHorizontal()
{
    if !(($INDEX % 3));
        then
        if [[ ${GAME_BOARD[INDEX]} = ${SIGN[PLAYER]} &&
              ${GAME_BOARD[INDEX+1]} = ${SIGN[PLAYER]} &&
              ${GAME_BOARD[INDEX+2]} = ${SIGN[PLAYER]} ]]
        then
            setWinner
        fi
    fi
}

function checkVertical()
{
    if [[ $INDEX -eq "0" || $INDEX -eq "3" || $INDEX -eq "6" ]]
    then
        if [[ ${GAME_BOARD[INDEX]} = ${SIGN[PLAYER]} &&
              ${GAME_BOARD[INDEX+3]} = ${SIGN[PLAYER]} &&
              ${GAME_BOARD[INDEX+6]} = ${SIGN[PLAYER]} ]]
        then
            setWinner
        fi
    fi
}

function checkDiagonal(){
    if [[ $INDEX -eq "0" ]]
    then
        if [[ ${GAME_BOARD[INDEX]} = ${SIGN[PLAYER]} &&
              ${GAME_BOARD[INDEX+4]} = ${SIGN[PLAYER]} &&
              ${GAME_BOARD[INDEX+8]} = ${SIGN[PLAYER]} ]]
        then
            setWinner
        fi
    fi
    if [[ $INDEX -eq "2" ]]
    then
        if [[ ${GAME_BOARD[INDEX]} = ${SIGN[PLAYER]} &&
              ${GAME_BOARD[INDEX+2]} = ${SIGN[PLAYER]} &&
              ${GAME_BOARD[INDEX+4]} = ${SIGN[PLAYER]} ]]
        then
            setWinner
        fi
    fi
}

function checkIfDraw(){
    if [[ $GAMES -eq "MAX_GAMES" ]]
    then
        GAME_STATUS="1"
        printf "No one won, DRAW\n"
    fi
    GAMES=$((GAMES+1))
}

function checkIfWon(){
    INDEX="0"
    for i in ${GAME_BOARD[@]}
    do
        checkHorizontal
        checkVertical
        checkDiagonal
        INDEX=$((INDEX+1))
    done
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

while [ $GAME_STATUS -eq "0" ]
do
    printBoard
    pickPlace
    checkIfWon
    changePlayer
    checkIfDraw
done
printBoard
