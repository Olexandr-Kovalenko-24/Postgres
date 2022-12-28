const { Client } = require('pg');
const {mapUsers} = require('./utils/mapUsers');
const configs = require('./configs/db');
const {getUsers} = require('./api/index');


const client = new Client(configs);


async function start(){
    await client.connect();
    const usersArray = await getUsers();
    const {rows} = await client.query(`INSERT INTO users (first_name, last_name, email, birthday, gender, is_subscribed) VALUES
    ${mapUsers(usersArray)};`);
    console.log(rows);
    await client.end();
}

start();