import axios from "axios";
import config from "./config";

const API_URL = config.apiServerUrl + "recipe";

export function getAll(options){
    if(!options){
        return axios.get(API_URL);
    }
    else {
        return axios.get(API_URL, { params: options });
    }
}

export function getByQuery(query){
    return axios.get(API_URL + "/search", {
        params: {
            query
        },
        withCredentials: true
    })
}

export function create(recipe){
    return axios.post(API_URL, recipe);
}

export function uploadRecipePicture(file, title){
    const formData = new FormData();
    formData.append("file", file);
    return axios.post(config.apiServerUrl + "/static/recipes/" + title, formData);
}

export function update(recipe){
    return axios.put(API_URL + "/" + recipe.id, recipe);
}

export function deleteRecipe(id){
    return axios.delete(API_URL + "/" + id);
}