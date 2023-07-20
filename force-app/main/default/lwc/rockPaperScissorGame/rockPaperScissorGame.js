import { LightningElement } from 'lwc';
export default class RockPaperScissorGame extends LightningElement {
    gameStart = false;
    player1Choice = '';
    player2Choice = '';
    player1Score = 0;
    player2Score = 0;
    Winner = '';

    computerMode = false;
    dualMode = false;

    singlePlayerMode() {
        this.gameStart = true;
        this.computerMode = true;
        this.dualMode = false;
    }

    dualPlayerMode() {
        this.gameStart = true;
        this.computerMode = false;
        this.dualMode = true;
    }

    rockSelection() {

        if (this.computerMode === true) {
            this.player1Choice = 'Rock';
            this.gameplay();
        }
        else if (this.dualMode === true) {

            if (this.player1Choice === '' && this.player2Choice === '') {
                this.player1Choice = 'Rock';
            }
            else if (this.player1Choice !== '' && this.player2Choice === '') {
                this.player2Choice = 'Rock';
                this.gameplay();
            }
        }

        console.log('this.player1Choice :' + this.player1Choice);
        console.log('this.player2Choice :' + this.player2Choice);

    }

    paperSelection() {

        if (this.computerMode === true) {
            this.player1Choice = 'Paper';
            this.gameplay();
        }
        else if (this.dualMode === true) {
            if (this.player1Choice === '' && this.player2Choice === '') {
                this.player1Choice = 'Paper';
            }
            else if (this.player1Choice !== '' && this.player2Choice === '') {
                this.player2Choice = 'Paper';
                this.gameplay();
            }
        }

        console.log('this.player1Choice :' + this.player1Choice);
        console.log('this.player2Choice :' + this.player2Choice);
    }

    scissorSelection() {

        if (this.computerMode === true) {
            this.player1Choice = 'Scissor';
            this.gameplay();
        }
        else if (this.dualMode === true) {
            if (this.player1Choice === '' && this.player2Choice === '') {
                this.player1Choice = 'Scissor';
            }
            else if (this.player1Choice !== '' && this.player2Choice === '') {
                this.player2Choice = 'Scissor';
                this.gameplay();
            }
        }

        console.log('this.player1Choice :' + this.player1Choice);
        console.log('this.player2Choice :' + this.player2Choice);
    }

    gameplay() {
        if (this.computerMode === true) {
            const compChoise = Math.floor(Math.random() * 3);
            if (compChoise === 0) {
                this.player2Choice = 'Rock';
            }
            else if (compChoise === 1) {
                this.player2Choice = 'Paper';
            }
            else {
                this.player2Choice = 'Scissor';
            }
        }

        if (this.player1Choice === this.player2Choice) {
            this.Winner = 'Draw';
        }
        else if (this.player1Choice === 'Rock') {
            if (this.player2Choice === 'Paper') {
                this.Winner = 'Player2';
                this.player2Score += 1;
            }
            else {
                this.Winner = 'Player1';
                this.player1Score += 1;
            }
        }
        else if (this.player1Choice === 'Paper') {
            if (this.player2Choice === 'Scissor') {
                this.Winner = 'Player2';
                this.player2Score += 1;
            }
            else {
                this.Winner = 'Player1';
                this.player1Score += 1;
            }
        }
        else {
            if (this.player2Choice === 'Rock') {
                this.Winner = 'Player2';
                this.player2Score += 1;
            }
            else {
                this.Winner = 'Player1';
                this.player1Score += 1;
            }
        }

        if (this.dualMode === true) {
            this.player1Choice = '';
            this.player2Choice = '';
        }

    }

    backToHome() {
        this.gameStart = false;
        this.player1Choice = '';
        this.player2Choice = '';
        this.player1Score = 0;
        this.player2Score = 0;
        this.Winner = '';

        this.computerMode = false;
        this.dualMode = false;
    }
}