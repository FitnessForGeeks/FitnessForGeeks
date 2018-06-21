import * as Account from "@/assets/account";
import Vue from "vue";

export const state = () => ({
    account: null,
    authenticating: true
})

export const mutations = {
    logIn(state, payload){
        state.account = payload;
        state.authenticating = false;
    },
    logOut(state){
        state.account = null;
    },
    eatRecipe(state, payload){
        state.account.remainingCalories = (state.account.remainingCalories || state.account.tdee) - payload.calories;
    },
    update(state, changes){
        Object.assign(state.account, changes);
    },
    refreshProfilePicture(state){
        state.account.profilePicture = state.account.profilePicture;
    },
    authenticating(state, payload){
        if(!state.authenticating)
            state.authenticating = true;
    }
}

export const actions = {
    authenticate(context){
        context.commit("authenticating");
        return new Promise((resolve, reject) => {
            Account
                .authenticate()
                .then(response => {
                    context.commit("logIn", response.data);
                    resolve(response);
                })
                .catch(err => {
                    reject(err)
                })
        });
    },
    uploadProfilePicture(context, payload){
        return new Promise((resolve, reject) => {
            Account.uploadProfilePicture(payload, context.state.account.username)
            .then(res => {
                context.commit("refreshProfilePicture");
                resolve(res);
            })
            .catch(reject);
        });
    },
    update(context, payload){
        return new Promise((resolve, reject) => {
            const account =  Object.assign({}, payload);
            const updateEmail = account.email != context.state.account.email;
            if(!updateEmail)
                delete account.email;
            Account.update(account)
            .then(res => {
                context.commit("update", payload);
                resolve(res);
            })
            .catch(reject);
        });
    },
    logIn(context, payload){
        context.commit("authenticating");
        return new Promise((resolve, reject) => {
            Account
                .logIn(payload.username, payload.password)
                .then(response => {
                    context.commit("logIn", response.data);
                    resolve(response);
                })
                .catch(err => {
                    reject(err);
                })
        });
    },
    logOut(context){
        return new Promise((resolve, reject) => {
            Account
                .logOut()
                .then(response => {
                    context.commit("logOut");
                    resolve();
                });
        });
    },
    eatRecipe(context, payload){
        Account.eatRecipe(payload.id, context.state.account.id)
        .then(res => {
            context.commit("eatRecipe", payload);
        });
    }
}

export const getters = {
    account(state){
        return state.account;
    },
    authenticating(state){
        return state.authenticating;
    }
}