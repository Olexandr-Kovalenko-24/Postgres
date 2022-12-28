const API_BASE = 'http://randomuser.me/api/'

module.exports.getUsers = async () => {
    const response = await fetch(`${API_BASE}?results=1000&page=1&seed=alex2022`);
    const {results} = await response.json();
    return results;
}

// &page=2&results=200