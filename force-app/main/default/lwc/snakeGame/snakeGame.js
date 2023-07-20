import { LightningElement,track } from 'lwc';
export default class SnakeGame extends LightningElement 
{
    score = 0; //To Hold Score
    highScore = 0; // To Hold High Score

    blockSize = 20; //Declaring The Siize of each block

    @track gameBlocks = []; // Array Of All Blocks 

    renderComplete = false; // To avoid Infinite Looping in Conected Callback When making Smaller Blocks

    /* To decide the movement of snake (Snake Head) on X axis 
    -- All Possible value -1, 0, 1 Depends on what direction user choose using keystroke */
    xSpeed = 1;
    ySpeed = 0;

    /* Initial Cordinate of Snake Head */
    xHead = 0;
    yHead = 0;

    xMax; //To Store Maximum Cordinate Value on X - Axis
    yMax; //To Store Maximum Cordinate Value on Y - Axis

    tail = []; //Array To Store Tail Div Blocks

    showOverlay = true;
    gameOver = false; //To handle Game Over

    speed = 1; //To store Current Speed of Snake
    intervalObj; //To Handle Speed Of Snake

    connectedCallback() {
        this.highScore = localStorage.getItem('lwc_snake_high')
            ? localStorage.getItem('lwc_snake_high')
            : 0;
    }

    get displaySpeed() {
        return this.speed.toFixed(1);
    }

    //Method to be executed when user click start game button
    /* the startGame() method initializes the game by hiding the overlay and starting an interval that repeatedly calls the move() method 
        at a specific time interval, determined by the value of this.speed. */
    startGame() {
        this.showOverlay = false;
        this.intervalObj = setInterval(() => {
            this.move();
        }, 300 / this.speed);
    }

    //method having logic to increase the speed
    addSpeed() {
        this.speed = this.speed + 0.1;
        clearInterval(this.intervalObj);
        this.startGame();
    }

    //method that contains logic for movement of snake
    move() {
        //logic to handle the snake body movement
        const lastElement = this.tail[this.tail.length - 1];//getting the coordinates of last div of Snake Body
        if (lastElement !== `${this.xHead}:${this.yHead}`) { //if snake had alteast one div as its body other than head
            this.tail.push(`${this.xHead}:${this.yHead}`);//adding the head div in body of snake 
            const removedElement = this.tail.shift();//removing the first element from snake head and storing its coordinates
            const curPosIndex = this.gameBlocks.findIndex(
                (x) => x.id === removedElement //finding the index of removed body div in gameBlocks array
            );
            this.gameBlocks[curPosIndex].snake = false;//making the div normal that is removing snake body property
            this.gameBlocks[curPosIndex].class = '';
        }

    //logic to handle snake head movement
        this.xHead += this.xSpeed;//deciding the snake head x coordinate
        this.yHead += this.ySpeed;//deciding the snake head y coordinate

        if (this.xHead >= this.xMax) {//when snake cross the last div then it will again start from first div in same x axis
            this.xHead = 0;
        }

        if (this.xHead < 0) {//when snake cross the first div then it will again start from last div in same x axis
            this.xHead = this.xMax - 1;
        }

        if (this.yHead >= this.yMax) {//when snake cross the last div in y axis then it will again start from first div in same y axis
            this.yHead = 0;
        }

        if (this.yHead < 0) {//when snake cross the first div in y axis then it will again start from last div in same y axis
            this.yHead = this.yMax - 1;
        }

        if (this.tail.includes(`${this.xHead}:${this.yHead}`)) {//when snake bite itself
            this.exitGame();
        } else {
            const newPosIndex = this.gameBlocks.findIndex(//finding the current index of snake index
                (x) => x.id === `${this.xHead}:${this.yHead}`
            );//converting the current div properties as that of snake head
            this.gameBlocks[newPosIndex].snake = true;
            this.gameBlocks[newPosIndex].class = 'snake';

            //logic when snake eats food that is food div and snake head div is same
            if (this.gameBlocks[newPosIndex].food) {//checking if the current div which is snake head is also food div
                this.score++;//incrementing the score
                if (this.score > this.highScore) {//logic to update high score 
                    this.highScore = this.score;
                    localStorage.setItem('lwc_snake_high', this.highScore);
                }
                this.addSpeed();//calling addspeed method when ever a food is eaten by snake
                this.tail.push(`${this.xHead}:${this.yHead}`);//making the current div as part of snake body as after eating the food snake body increases by one div 
                this.gameBlocks[newPosIndex].food = false;//removing the food properties of current div as food is eaten
                this.generateFood(); //calling generateFood() method to generate new food
            }
        }
    }

    //Method To Handle Direction of Snake
    addKeyboardControls() {
        window.addEventListener('keydown', (e) => {//returns the keystroks 
            e.preventDefault();
            switch (e.key) {
                case 'ArrowUp':    //when user press upArrow then there will be no change in x cordinate and y cordinate will be decrese by 1
                    this.xSpeed = 0;
                    this.ySpeed = -1;
                    break;
                case 'ArrowDown':
                    this.xSpeed = 0;
                    this.ySpeed = 1;
                    break;
                case 'ArrowLeft':
                    this.xSpeed = -1;
                    this.ySpeed = 0;
                    break;
                case 'ArrowRight':
                    this.xSpeed = 1;
                    this.ySpeed = 0;
                    break;
                default:
                    break;
            }
        });
    }

    //method having logic to generate food
    generateFood() {
        const xFood = Math.floor(Math.random() * (this.xMax - 1));/*generating x coordinate of food using Math.random() function then multipling it 
                                                                with (this.xMax - 1) so that the random number ranges between 0 to xMax as fraction 
                                                                multiply with number alwayes give a fraction that is less than or equal to the number
                                                                and then using math.floor() funtion to get the integer value of coordinate*/
        const yFood = Math.floor(Math.random() * (this.yMax - 1));

        if (!this.tail.includes(`${xFood}:${yFood}`)) {//ensuring that the new coordinates of food is not pointing the div of snake body
            const foodPosIndex = this.gameBlocks.findIndex(//finding the index of current coordinate div in gameBlocks array
                (x) => x.id === `${xFood}:${yFood}`
            );
            this.gameBlocks[foodPosIndex].food = true;//now changing div properties at current index to food 
            this.gameBlocks[foodPosIndex].class = 'food';
        } else {
            this.generateFood();//regenarting the food coordinates as it lies on snake body
        }
    }

    //Method To Create Game Blocks
    renderGameBlocks() {
        const gameContainerEl = this.template.querySelector('.game-container'); //Getting The Dimenstion Of game-container
        const eWidth = gameContainerEl.clientWidth; //Getting Width of container
        const eHeight = gameContainerEl.clientHeight; //Getting Height of container

        this.xMax = Math.floor(eWidth / this.blockSize); //Getting Value of Total Div Block on X- Axis using Math.floor for Integer Value
        this.yMax = Math.floor(eHeight / this.blockSize); //Getting Value of Total Div Block on Y- Axis using Math.floor for Integer Value

        const tmpBlocks = []; // Local temp Array to store all Div Block-- As We can store all div directly in main array as it result in infine rendering of renderedCallback()

        for (let y = 0; y < this.yMax; y++) { //For each Y all X is looped
            for (let x = 0; x < this.xMax; x++) {
                let obj;
                if (x === 0 && y === 0) { //Cordinate Where Snake Head is Present At Start Of Game 
                    obj = {
                        id: `${x}:${y}`,
                        snake: true, //Current Div will act as Sanke and Will have Its Properties
                        food: false,
                        class: 'snake' //Deciding the Current Class as Snake
                    };
                } else { // For All Div which is not part of Snake and food
                    obj = {
                        id: `${x}:${y}`,
                        snake: false,
                        food: false,
                        class: ''
                    };
                }
                tmpBlocks.push(obj);
            }
        }
        this.gameBlocks = tmpBlocks;
    }

    //Logic When Component Loads
    renderedCallback() {
        if (!this.renderComplete) { //Condition To Avoid Infine Looping
            this.renderComplete = true;
            this.renderGameBlocks(); //Method To Create Game Blocks
            this.addKeyboardControls(); //Method To Handle Direction of Snake
            this.generateFood(); // Method To generate Food
            window.addEventListener('resize', () => { //Logic When Window Size is Changed
                this.resetGameMetrics(); //Method To reset everything From Start
                this.showOverlay = true;
                this.gameOver = false;
            });
        }
    }

    resetGameMetrics() {
        this.xSpeed = 1;
        this.ySpeed = 0;

        this.xHead = 0;
        this.yHead = 0;

        this.tail = [];

        this.score = 0;
        this.speed = 1;

        this.renderGameBlocks();
        this.generateFood();
        clearInterval(this.intervalObj);
    }

    resetGame() {
        this.resetGameMetrics();
        this.startGame();
    }

    exitGame() {
        this.showOverlay = true;
        this.gameOver = true;
        clearInterval(this.intervalObj);
    }
}