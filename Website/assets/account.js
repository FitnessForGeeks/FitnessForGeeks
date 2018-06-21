import sha256 from "js-sha256";
import axios from "axios";
import config from "./config";

const API_URL = config.apiServerUrl + "account";

export function logIn(username, password){
    const data = {
        username,
        password: sha256(password)
    }
    return axios.post(API_URL + "/login", data, { 
        withCredentials: true
    })
};

export function authenticate(){
    return axios.post(API_URL + "/authenticate", {}, { 
        withCredentials: true
    })
}

export function logOut(){
    return axios.post(API_URL + "/logout", null, { withCredentials: true});
};

export function register(username, password, email){
    const data = {
        username: username,
        password: sha256(password),
        email: email
    };
    return axios.post(API_URL, data)
};

export function eatRecipe(recipeId, accountId){
    return axios.post(API_URL + "/eatRecipe", {}, {
        params: {
            accountId,
            recipeId
        }
    })
}

export function getCurrentEatenRecipes(accountId){
    return axios.get(API_URL + `/eatenRecipes/today?accountId=${accountId}`);
}

export function getMyRecipes(accountId){
    return axios.get(API_URL + `/myRecipes?accountId=${accountId}`);
}

export function update(account){
    return axios.put(API_URL, account);
}

export function uploadProfilePicture(file, username){
    const formData = new FormData();
    formData.append("file", file);
    return axios.post(config.apiServerUrl + "static/" + username + "/profilePicture", formData);
}