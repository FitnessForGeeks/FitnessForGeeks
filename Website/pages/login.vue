<template>
    <v-container>
        <v-card dense class="login-form">
            <v-card-text>
                <v-form v-model="valid" ref="vForm" @keydown.enter.native="onFormEnter">
                    <v-text-field
                        autofocus
                        label="Username"
                        v-model="username"
                        :rules="[rules.required('Username')]"
                        id="username"
                        :error-messages="errors.username"
                        prepend-icon="person"
                        required
                    ></v-text-field>
                    <v-text-field
                        label="Password"
                        v-model="password"
                        type="password"
                        id="password"
                        :rules="[rules.required('Password')]"
                        :error-messages="errors.password"
                        prepend-icon="lock"
                        required
                    ></v-text-field>
                    <loading-button 
                        class="login-button" 
                        :loading="loggingIn" 
                        @click="onSubmitButtonClicked"
                        :disabled="!valid"
                    > Login </loading-button>
                </v-form>
            </v-card-text>
        </v-card>
    </v-container>
</template>

<script>
import { logIn } from "@/assets/account.js";
import { mapGetters } from "vuex";
import loadingButton from "@/components/loadingButton";

export default {
    computed:{
        ...mapGetters({
            account: "account/account"
        })
    },
    components:{
        "loading-button": loadingButton
    },
    data(){
        return {
            username: "",
            password: "",
            valid: true,
            loggingIn: false,
            errors: {
                username: [],
                password: []
            },
            rules: {
                required: name => val => {
                    if(val === "")
                        return name + " is required";
                    return true;
                }
            }
        }
    },
    methods:{
        onFormEnter(){
            this.onSubmitButtonClicked();
        },
        onSubmitButtonClicked(){
            if(this.valid){
                this.loggingIn = true;
                this.errors.username = [];
                this.errors.password = [];
                this.$store
                    .dispatch("account/logIn", {
                        username: this.username,
                        password: this.password,
                    })
                    .then(res => {
                        this.$router.push(this.$route.query.redirectPath || "/")
                    })
                    .catch(err => {
                        this.loggingIn = false;
                        console.log(err);
                        if(err.response){
                            if(err.response.status === 404){
                                this.errors.username.push("Username doesn't exist");
                            }
                            else if(err.response.status === 403){
                                this.errors.password.push("Wrong password");
                            }
                        }
                    });
            }
        }
    }
}
</script>

<style scoped>
.login-form{
    width: 400px;
    margin: 200px auto;
}
.login-button{
    margin-left: 280px;
}
</style>
