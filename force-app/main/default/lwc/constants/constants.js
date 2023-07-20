/*
*
* Purpose : Constant Component JS
*
*Created Date : 05/19/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 05/19/2023
*
*/

const CHAR_BLANK = '';
const CHAR_BLANK_SPACE = ' ';
const CHAR_BLANK_COLON = ':';
const CHAR_BLANK_DASH = '-';
const CHAR_BACK_SLASH = '/';
const CHAR_YES = 'Yes';
const CHAR_NO = 'No';
const CHAR_ZERO = '0';
const CHAR_URL_FIELD = 'URLField';
const CHAR_COMMA = ',';

const NUMBER_ZERO = 0;
const NUMBER_ONE = 1;
const NUMBER_TWO = 2;
const NUMBER_FIVE = 5;

const DATA_TYPE_URL = 'url';
const DATA_TYPE_STRING = 'string';
const DATA_TYPE_DOUBLE = 'DOUBLE';
const DATA_TYPE_NUMBER = 'number';

const URL_TARGET_BLANK = '_blank';
const URL_TARGET_SELF = '_self';

const ELEMENT_TYPE_LIGHTNING_DATATABLE = 'lightning-datatable';
const ELEMENT_TYPE_GENERIC_TABLE = 'c-my-Generic-table';

const PAGEREFERENCE_TYPE_NAVIGATE_TO_WEB_PAGE = 'standard__webPage';

const STATUS_ERROR_LOWERCASE = 'error';
const STATUS_ERROR_UPPERCASE = 'ERROR';
const STATUS_SUCCESS_LOWERCASE = 'success';
const STATUS_SUCCESS_UPPERCASE = 'SUCCESS';

const CHARACTERS = 
{
    CHAR_ZERO,
    CHAR_BLANK,
    CHAR_BLANK_SPACE,
    CHAR_BLANK_COLON,
    CHAR_BLANK_DASH,
    CHAR_YES,
    CHAR_NO,
    CHAR_URL_FIELD,
    CHAR_BACK_SLASH,
    CHAR_COMMA
};

const NUMBERS = 
{
    NUMBER_ZERO,
    NUMBER_ONE,
    NUMBER_TWO,
    NUMBER_FIVE
};

const DATA_TYPES = 
{
    DATA_TYPE_URL,
    DATA_TYPE_STRING,
    DATA_TYPE_DOUBLE,
    DATA_TYPE_NUMBER
};

const URL_TARGET_TYPES = 
{
    URL_TARGET_BLANK,
    URL_TARGET_SELF
};

const ELEMENT_TYPES = 
{
    ELEMENT_TYPE_LIGHTNING_DATATABLE,
    ELEMENT_TYPE_GENERIC_TABLE
};

const PAGEREFERENCE_TYPES = 
{
    PAGEREFERENCE_TYPE_NAVIGATE_TO_WEB_PAGE
};

const STATUS_MESSAGES = 
{
    STATUS_ERROR_LOWERCASE,
    STATUS_ERROR_UPPERCASE,
    STATUS_SUCCESS_LOWERCASE,
    STATUS_SUCCESS_UPPERCASE
};

Object.freeze(CHARACTERS);
Object.freeze(NUMBERS);
Object.freeze(DATA_TYPES);
Object.freeze(URL_TARGET_TYPES);
Object.freeze(ELEMENT_TYPES);
Object.freeze(PAGEREFERENCE_TYPES);
Object.freeze(STATUS_MESSAGES);

export 
{
    CHARACTERS,
    NUMBERS,
    DATA_TYPES,
    URL_TARGET_TYPES,
    ELEMENT_TYPES,
    PAGEREFERENCE_TYPES,
    STATUS_MESSAGES
};