const { Client } = require('pg');
const {mapUsers} = require('./utils/mapUsers');

const configs = {
    host: 'localhost',
    port: 5432,
    user: 'postgres',
    password: '2624',
    database: 'test'
};

const client = new Client(configs);

const users = [
    {
        firstName: 'Test1',
        lastName: 'Test1',
        email: '123g@.fdsf'
    },
    {
        firstName: 'Test2',
        lastName: 'Test2',
        email: '123g@.fdss'
    },
    {
        firstName: 'Test3',
        lastName: 'Test3',
        email: '123g@.f3ds'
    },
    {
        firstName: 'Test4',
        lastName: 'Test4',
        email: '123g@.fdsds'
    },
    {
        firstName: 'Test5',
        lastName: 'Test5',
        email: '123g@.fdgds'
    }
]

async function start(){
    await client.connect();
    const {rows} = await client.query(`INSERT INTO users (first_name, last_name, email) VALUES
    ${mapUsers(users)};`);
    console.log(rows);
    await client.end();
}

start();